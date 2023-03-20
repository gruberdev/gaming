FROM golang:1.19.1 as builder

RUN apt-get update && apt-get install -y unzip curl

COPY . /go/src/minecraft
WORKDIR /go/src/minecraft
RUN go mod tidy && go build -o wrapper ./main.go

RUN chmod +x /go/src/minecraft/wrapper

FROM eclipse-temurin:19-jre as base

RUN useradd -d /app -s /bin/false multipaper
USER multipaper
WORKDIR /app

COPY ./entrypoint.sh /entrypoint.sh
COPY ./binaries/eula.txt /app/eula.txt
COPY ./binaries/multipaper.jar /opt/multipaper/multipaper.jar
COPY --from=builder /go/src/minecraft /tmp

user root
RUN chmod +x /tmp/wrapper

ENTRYPOINT /tmp/wrapper -i /entrypoint.sh -args "--max-players=30"
