#!/bin/sh -x
set -euo pipefail

FACTORIO_VOL=/factorio

if [ ! -f "$FACTORIO_VOL" ]; then
  mkdir -p "$FACTORIO_VOL"
fi

if [ ! -f "$SCENARIOS" ]; then
  mkdir -p "$SCENARIOS"
fi

if [ ! -f "$MODS" ]; then
  mkdir -p "$MODS"
fi

if [ ! -f "$FACTORIO_VOL" ]; then
  mkdir -p "$FACTORIO_VOL"
fi

if [ ! -f "$SCRIPTOUTPUT" ]; then
  mkdir -p "$SCRIPTOUTPUT"
fi

if [ ! -f "$CONFIG" ]; then
  mkdir -p "$CONFIG"
fi

if [ ! -f "$SAVES" ]; then
  mkdir -p "$SAVES"
fi

if [ ! -f "$CONFIG/rconpw" ]; then
  # Generate a new RCON password if none exists
  pwgen 15 1 >"$CONFIG/rconpw"
fi

frep $CONFIG/server-settings.json:/config/server-settings.json --overwrite

if [ ! -f "$CONFIG/map-gen-settings.json" ]; then
  cp /opt/factorio/data/map-gen-settings.example.json "$CONFIG/map-gen-settings.json"
fi

if [ ! -f "$CONFIG/map-settings.json" ]; then
  cp /opt/factorio/data/map-settings.example.json "$CONFIG/map-settings.json"
fi

NRTMPSAVES=$( find -L "$SAVES" -iname \*.tmp.zip -mindepth 1 | wc -l )
if [ "$NRTMPSAVES" -gt 0 ]; then
  # Delete incomplete saves (such as after a forced exit)
  rm -f "$SAVES"/*.tmp.zip
fi

if [ "$(id -u)" = '0' ]; then
  # Update the User and Group ID based on the PUID/PGID variables
  usermod -o -u "$PUID" factorio
  groupmod -o -g "$PGID" factorio
  # Take ownership of factorio data if running as root
  chown -R factorio:factorio "$FACTORIO_VOL"
  # Drop to the factorio user
  SU_EXEC="su-exec factorio"
else
  SU_EXEC=""
fi

NRSAVES=$( find -L "$SAVES" -iname \*.zip -mindepth 1 | wc -l )
if [ "$NRSAVES" -eq 0 ]; then
  # Generate a new map if no save ZIPs exist
  $SU_EXEC /opt/factorio/bin/x64/factorio \
    --create "$SAVES/_autosave1.zip" \
    --map-gen-settings "$CONFIG/map-gen-settings.json" \
    --map-settings "$CONFIG/map-settings.json"
fi

# shellcheck disable=SC2086
exec $SU_EXEC /opt/factorio/bin/x64/factorio \
  --bind "$FCTR_IP:$FCTR_PORT" \
  --start-server-load-latest \
  --server-settings "$CONFIG/server-settings.json" \
  --server-banlist "$CONFIG/server-banlist.json" \
  --rcon-port "$FCTR_RCON_PORT" \
  --server-whitelist "$CONFIG/server-whitelist.json" \
  --use-server-whitelist \
  --server-adminlist "$CONFIG/server-adminlist.json" \
  --rcon-password "$(cat "$CONFIG/rconpw")" \
  --server-id /factorio/config/server-id.json \
  "$@"
