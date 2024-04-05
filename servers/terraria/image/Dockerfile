# Build stage
FROM golang:1.22.2-bookworm as builder

# Update package lists and install unzip and curl
RUN apt-get update \
    && apt-get install -y unzip curl \
    && rm -rf /var/lib/apt/lists/*

# Copy the local source files to the container's Go workspace
COPY . /go/src/terraria
WORKDIR /go/src/terraria

ENV CGO_ENABLED=0

# Tidy the Go module dependencies and build the wrapper binary
RUN go mod tidy && go build -o wrapper .

# Final image stage
FROM golang:1.22.2-bookworm

# Add OCI annotations for the image
LABEL org.opencontainers.image.authors="gruberdev <gh@gruber.dev.br>"
LABEL org.opencontainers.image.url="https://github.com/gruberdev/gaming/blob/main/servers/terraria"
LABEL org.opencontainers.image.documentation="https://github.com/gruberdev/gaming/blob/main/servers/terraria/README.md"
LABEL org.opencontainers.image.source="https://github.com/gruberdev/gaming.git"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.title="Terraria (Agones version)"
LABEL org.opencontainers.image.description DESCRIPTION="Terraria dedicated servers with Agones integration."

ARG VERSION=1.0.0.0

# Set environment variables for server configuration
ENV TERRARIA_MOTD="A server powered by Kubernetes and Agones!" \
    TERRARIA_PASS="" \
    TERRARIA_MAXPLAYERS="16" \
    TERRARIA_WORLDNAME="Example" \
    TERRARIA_WORLDSIZE="3" \
    TERRARIA_WORLDSEED="Docker" \
    TERRARIA_USECONFIGFILE="No" \
    VERSION="$VERSION"

# Update package lists and install necessary packages, then clean up
RUN apt-get update && \
    apt-get install -y \
            wget unzip tmux bash \
            && rm -rf /var/lib/apt/lists/*

# Set working directory to /server
WORKDIR /server

# Download and unzip the Terraria server files
RUN TERRARIA_DOWNLOAD=$(echo ${VERSION} | tr -d '.') && \
    echo ${TERRARIA_DOWNLOAD} && \
    wget https://terraria.org/api/download/pc-dedicated-server/terraria-server-${TERRARIA_DOWNLOAD}.zip \
    -O terraria.zip && \
    unzip -o terraria.zip && \
    mv ${TERRARIA_DOWNLOAD}/* /server && \
    rm terraria.zip && \
    mkdir -p /root/.local/share/Terraria/Worlds

# Copy entrypoint.sh script and the built wrapper binary from the builder stage
COPY entrypoint.sh /tmp/entrypoint.sh
COPY --from=builder /go/src/terraria /tmp

# Make the entrypoint script, wrapper binary, and TerrariaServer binary executable
RUN chmod +x /tmp/entrypoint.sh /tmp/wrapper /server/Linux/TerrariaServer.bin.x86_64

# Set the entrypoint to start the wrapper and entrypoint script
ENTRYPOINT /tmp/wrapper -i /tmp/entrypoint.sh
