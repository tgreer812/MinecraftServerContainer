#!/bin/sh

echo "Running entrypoint script..."

echo "Current directory: $(pwd)"
echo "Contents of current directory: $(ls -la)"

# List all the environment variables for debugging purposes
env

# Run the start-minecraft.sh script
if [ "$USE_FORGE_ENV" = "true" ]; then
  echo "Starting Minecraft Forge server..."
  cd ./server && /app/start-forge-server.sh
else
  echo "Starting Minecraft Vanilla server..."
  cd ./server && /app/start-vanilla-server.sh
fi
