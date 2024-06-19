#!/bin/sh

echo "Running entrypoint script..."

echo "Current directory: $(pwd)"
echo "Contents of current directory: $(ls -la)"

# Run the start-minecraft.sh script
cd /app/server && /app/start-minecraft.sh
