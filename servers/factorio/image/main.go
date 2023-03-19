package main

import (
	"flag"
	"fmt"
	"io"
	"log"
	"os"
	"os/exec"
	"regexp"
	"strconv"
	"strings"
	"time"

	sdk "agones.dev/agones/sdks/go"
)

type interceptor struct {
	forward   io.Writer
	intercept func(p []byte)
}

// Write will intercept the incoming stream, and forward
// the contents to its `forward` Writer.
func (i *interceptor) Write(p []byte) (n int, err error) {
	if i.intercept != nil {
		i.intercept(p)
	}

	return i.forward.Write(p)
}

// main intercepts the stdout of the Terraria gameserver and uses it
// to determine if the game server is ready or not.
func main() {

	fmt.Println(">>> Initializing server...")

	input := flag.String("i", "", "path to server_linux.sh or server_windows.bat")
	args := flag.String("args", "", "additional arguments to pass to the script")

	enablePlayerTracking := flag.Bool("player-tracking", true, "If true, player tracking will be enabled.")
	serverCapacity, err := strconv.ParseInt(os.Getenv("FCTR_MAXPLAYERS"), 10, 64)

	flag.Parse()

	s, err := sdk.NewSDK()
	if *enablePlayerTracking {
		if err := s.Alpha().SetPlayerCapacity(serverCapacity); err != nil {
			log.Fatalf("could not set play count: %v", err)
		}

		argsList := strings.Split(strings.Trim(strings.TrimSpace(*args), "'"), " ")
		fmt.Println(">>> Connecting to Agones with the SDK")
		if err != nil {
			log.Fatalf(">>> Could not connect to sdk: %v", err)
		}

		fmt.Println(">>> Starting health checking")

		go doHealth(s)

		fmt.Println(">>> Starting wrapper for Factorio!")
		fmt.Printf(">>> Path to Factorio server script: %s %v\n", *input, argsList)

		cmd := exec.Command(*input, argsList...) // #nosec

		cmd.Stderr = &interceptor{forward: os.Stderr}
		cmd.Stdout = &interceptor{
			forward: os.Stdout,
			intercept: func(p []byte) {
				action, player := handleLogLine(string(p))
				switch action {
				case "READY":
					if err := s.Ready(); err != nil {
						log.Fatal(">>> failed to mark server ready")
					}
				case "PLAYERJOIN":
					if player == nil {
						log.Print(">>> could not determine player")
						break
					}
					if *enablePlayerTracking {
						result, err := s.Alpha().PlayerConnect(*player)
						if err != nil {
							log.Print(err)
						} else {
							log.Print(result)
						}
					}
				case "PLAYERLEAVE":
					if player == nil {
						log.Print(">>> could not determine player")
						break
					}
					if *enablePlayerTracking {
						result, err := s.Alpha().PlayerDisconnect(*player)
						if err != nil {
							log.Print(err)
						} else {
							log.Print(result)
						}
					}
				case "SHUTDOWN":
					if err := s.Shutdown(); err != nil {
						log.Fatal(err)
					}
					os.Exit(0)
				}
				str := strings.TrimSpace(string(p))
				if strings.Contains(str, "Opening socket for broadcast") {
					err = s.Ready()
					if err != nil {
						log.Fatalf("Could not send ready message")
					}
				}
			},
		}
		err := cmd.Start()
		if err != nil {
			log.Fatalf(">>> Error Starting Cmd %v", err)
		}
		err = cmd.Wait()
		log.Fatal(">>> Factorio shutdown unexpectantly", err)
	}
}

// doHealth sends the regular Health Pings
func doHealth(sdk *sdk.SDK) {
	tick := time.Tick(2 * time.Second)
	for {
		err := sdk.Health()
		if err != nil {
			log.Fatalf("[wrapper] Could not send health ping, %v", err)
		}
		<-tick
	}
}

func handleLogLine(line string) (string, *string) {
	// The various regexes that match server lines
	playerJoin := regexp.MustCompile(`(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}) \[JOIN\] (.+) joined the game`)
	playerLeave := regexp.MustCompile(`(\d{4}-\d{2}-\d{2} \d{2}:\d{2}:\d{2}) \[LEAVE\] (.+) left the game`)
	serverStart := regexp.MustCompile(`Opening socket for broadcast`)

	// Start the server
	if serverStart.MatchString(line) {
		log.Print(">>> Server ready")
		return "READY", nil
	}

	// Player tracking
	if playerJoin.MatchString(line) {
		matches := playerJoin.FindSubmatch([]byte(line))
		player := string(matches[2])
		log.Printf(">>> Player %s joined\n", player)
		return "PLAYERJOIN", &player
	}
	if playerLeave.MatchString(line) {
		matches := playerLeave.FindSubmatch([]byte(line))
		player := string(matches[2])
		log.Printf(">>> Player %s disconnected", player)
		return "PLAYERLEAVE", &player
	}
	return "", nil
}
