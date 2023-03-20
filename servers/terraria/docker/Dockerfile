# build
FROM golang:1.19.1 as builder

RUN apt-get update && apt-get install -y unzip curl

COPY . /go/src/examples/terraria
WORKDIR /go/src/examples/terraria
RUN go mod tidy && go build -o wrapper .

FROM mono:slim

# The Terraria Game Version, ignoring periods. For example, version 1.4.4.9 will be a value of 1449 in this variable.
ARG TERRARIA_VERSION=1449

# The shutdown message is broadcast to the game chat when the container was stopped from the host.
ENV TERRARIA_SHUTDOWN_MESSAGE="Closing active connections..."

# The following environment variables will configure common settings for the Terraria server.
ENV TERRARIA_MOTD="A server powered by Kubernetes and Agones!"
ENV TERRARIA_PASS=""
ENV TERRARIA_MAXPLAYERS="16"
ENV TERRARIA_WORLDNAME="Example"
ENV TERRARIA_WORLDSIZE="3"
ENV TERRARIA_WORLDSEED="Docker"
ENV TERRARIA_USECONFIGFILE="No"

# Loading a configuration file expects a proper Terraria config file to be mapped to /root/terraria-server/serverconfig.txt
# Set this to "Yes" if you would rather use a config file instead of the above settings.

RUN apt-get update
RUN apt-get install -y \
            wget unzip tmux bash \
            && rm -rf /var/lib/apt/lists/*

WORKDIR /server

RUN wget https://terraria.org/api/download/pc-dedicated-server/terraria-server-${TERRARIA_VERSION}.zip \
    -O terraria.zip && \
    unzip -o terraria.zip && \
    mv ${TERRARIA_VERSION}/* /server && \
    rm terraria.zip && \
    mkdir -p /root/.local/share/Terraria/Worlds

COPY entrypoint.sh /tmp/entrypoint.sh
COPY --from=builder /go/src/examples/terraria /tmp

RUN chmod +x /tmp/entrypoint.sh /tmp/wrapper /server/Linux/TerrariaServer.bin.x86_64

ENTRYPOINT /tmp/wrapper -i /tmp/entrypoint.sh
