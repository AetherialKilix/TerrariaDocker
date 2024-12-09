#!/bin/bash

# Default values
: "${DIFFICULTY:=0}"
: "${WORLD_NAME:=Terraria}"
: "${MAX_PLAYERS:=4}"

# Start generating the config file
cat > /app/.config <<EOL
# World is mounted in Dockerfile
world=/app/world.wld
# priority may be realtime, as this is run in a container
priority=0
# playercount
maxplayers=${MAX_PLAYERS}

# Settings for autocreate
# Difficulty 0(classic), 1(expert), 2(master), 3(journey)
difficulty=${DIFFICULTY}
# World Name
worldname=${WORLD_NAME}
EOL

# Add optional fields only if they are set
if [ -n "$PASSWORD" ]; then
  echo "password=${PASSWORD}" >> /app/.config
fi

if [ -n "$MOTD" ]; then
  echo "motd=${MOTD}" >> /app/.config
fi

# Allow execution
chmod +x *

# Start the server with the generated config
./TerrariaServer.bin.x86_64 -config /app/.config