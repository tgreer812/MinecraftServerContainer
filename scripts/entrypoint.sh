#!/bin/sh

echo "Running entrypoint script..."

echo "Current directory: $(pwd)"
echo "Contents of current directory: $(ls -la)"

# Switch to the server directory
# and start the Minecraft server
cd ./server || exit 1

# Run the start-minecraft.sh script
/app/start-minecraft.sh
