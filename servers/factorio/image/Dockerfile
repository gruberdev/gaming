FROM subchen/frep:1.3.13 as frep

FROM golang:1.22.2-bookworm as builder

WORKDIR /go/src/factorio
RUN apt-get update && apt-get install -y unzip curl
COPY . .

ENV CGO_ENABLED=0

RUN go mod tidy && go build -o wrapper .

FROM frolvlad/alpine-glibc:alpine-3.9

LABEL org.opencontainers.image.authors="gruberdev <gh@gruber.dev.br>"
LABEL org.opencontainers.image.url="https://github.com/gruberdev/gaming/blob/main/servers/factorio"
LABEL org.opencontainers.image.documentation="https://github.com/gruberdev/gaming/blob/main/servers/factorio/README.md"
LABEL org.opencontainers.image.source="https://github.com/gruberdev/gaming.git"
LABEL org.opencontainers.image.licenses="MIT"
LABEL org.opencontainers.image.title="Factorio (Agones version)"
LABEL org.opencontainers.image.description DESCRIPTION="Factorio dedicated servers with Agones integration."

ARG USER=factorio
ARG GROUP=factorio
ARG PUID=845
ARG PGID=845
ARG VERSION=1.0.0

ENV FCTR_PORT=34197 \
    FCTR_RCON_PORT=27015 \
    FCTR_IP=0.0.0.0 \
    FCTR_MAXPLAYERS=32 \
    SAVES=/factorio/saves \
    CONFIG=/config \
    MODS=/factorio/mods \
    SCENARIOS=/factorio/scenarios \
    SCRIPTOUTPUT=/factorio/script-output \
    VERSION="$VERSION" \
    PUID="$PUID" \
    PGID="$PGID"

RUN mkdir -p /opt /factorio && \
    apk add --update --no-cache pwgen su-exec binutils gettext libintl shadow && \
    apk add --update --no-cache --virtual .build-deps curl && \
    curl -sSL "https://www.factorio.com/get-download/$VERSION/headless/linux64" \
        -o /tmp/factorio_headless_x64_$VERSION.tar.xz && \
    tar xf "/tmp/factorio_headless_x64_$VERSION.tar.xz" --directory /opt && \
    chmod ugo=rwx /opt/factorio && \
    rm "/tmp/factorio_headless_x64_$VERSION.tar.xz" && \
    ln -s "$SAVES" /opt/factorio/saves && \
    ln -s "$MODS" /opt/factorio/mods && \
    ln -s "$SCENARIOS" /opt/factorio/scenarios && \
    ln -s "$SCRIPTOUTPUT" /opt/factorio/script-output && \
    apk del .build-deps && \
    addgroup -g "$PGID" -S "$GROUP" && \
    adduser -u "$PUID" -G "$GROUP" -s /bin/sh -SDH "$USER"

WORKDIR /factorio

COPY --from=frep /usr/local/bin/frep /usr/local/bin/frep
COPY ./config/server-settings.json /config/server-settings.json
COPY entrypoint.sh /entrypoint.sh
COPY --from=builder /go/src/factorio /tmp

RUN chmod +x /entrypoint.sh /usr/local/bin/frep /tmp/wrapper \
    && chown -R "$USER":"$GROUP" /opt/factorio /factorio /tmp

ENTRYPOINT ["/tmp/wrapper", "-i", "/entrypoint.sh"]
