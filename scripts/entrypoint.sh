#!/bin/sh

echo "Running entrypoint script..."

echo "Current directory: $(pwd)"
echo "Contents of current directory: $(ls -la)"


# Running entrypoint script...
# Current directory: /app
# Contents of current directory: total 12
# drwxr-xr-x 1 root root 4096 Jun 19 05:06 .
# drwxr-xr-x 1 root root 4096 Jun 19 05:12 ..
# lrwxrwxrwx 1 root root   11 Jun 19 05:06 server -> /mnt/server
# -rwxr-xr-x 1 root root 3497 Jun 19 05:05 start-minecraft.sh


# Run the start-minecraft.sh script
if [ "$USE_FORGE" = "true" ]; then
  echo "Starting Minecraft Forge server..."
  cd ./server && /app/start-forge-server.sh
else
  echo "Starting Minecraft Vanilla server..."
    cd ./server && /app/start-vanilla-server.sh
