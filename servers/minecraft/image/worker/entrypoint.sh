#!/usr/bin/env sh

SERVER_NAME=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 8 | head -n 1)
sed -i "s/my-name: .*/my-name: $SERVER_NAME/" /app/multipaper.yml

exec java -jar /opt/multipaper/multipaper.jar $@
