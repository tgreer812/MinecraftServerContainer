#!/bin/sh

echo "Running entrypoint script..."

# Switch to the server directory
# and start the Minecraft server
cd ./server && ./start-minecraft.sh
