#!/bin/bash

# Base startup command
CMD="/server/Linux/TerrariaServer.bin.x86_64 -server"

# Check Config
if [[ "$TERRARIA_USECONFIGFILE" == "Yes" ]]; then
  if [ -e /server/Linux/config/serverconfig.txt ]; then
    echo -e "Terraria server will launch with the supplied config file."
  else
    echo -e "[!!] ERROR: The Terraria server was set to launch with a config file, but it was not found. Please map the file and launch the server again."
    mkdir -p /server/Linux/config
  fi
else
  echo -e "Shutdown Message set to: $TERRARIA_SHUTDOWN_MESSAGE"
  echo -e "World Name set to: $TERRARIA_WORLDNAME"
  echo -e "World Size set to: $TERRARIA_WORLDSIZE"
  echo -e "World Seed set to: $TERRARIA_WORLDSEED"
  echo -e "Max Players set to: $TERRARIA_MAXPLAYERS"
  echo -e "Server Password set to: $TERRARIA_PASS"
  echo -e "MOTD Set to: $TERRARIA_MOTD"
  echo -e "Server version: $VERSION"

fi

# If config, we supply it at the command line.
if [[ "$TERRARIA_USECONFIGFILE" == "Yes" ]]; then
  CMD="$CMD -config /server/Linux/config/serverconfig.txt"
else
  # Check if the world file exists.
  if [ -e "/root/.local/share/Terraria/Worlds/$TERRARIA_WORLDNAME.wld" ]; then
    CMD="$CMD -world \"/root/.local/share/Terraria/Worlds/$TERRARIA_WORLDNAME.wld\""
  else
  # If it does not, alert the player, and set the startup parameters to automatically generate the world.
    echo -e "[!!] WARNING: The world \"$TERRARIA_WORLDNAME\" was not found. The server will automatically create a new world."
    sleep 3s
    CMD="$CMD -world \"/root/.local/share/Terraria/Worlds/$TERRARIA_WORLDNAME.wld\""
    CMD="$CMD -autocreate $TERRARIA_WORLDSIZE -worldname \"$TERRARIA_WORLDNAME\" -seed \"$TERRARIA_WORLDSEED\""
  fi

  CMD="$CMD -players $TERRARIA_MAXPLAYERS"

  if [[ "$TERRARIA_PASS" == "" ]]; then
    echo -e "[!!] Server Password has been disabled."
  else
    CMD="$CMD -pass \"$TERRARIA_PASS\""
  fi

  CMD="$CMD -motd \"$TERRARIA_MOTD\""
fi

exec $CMD $@
