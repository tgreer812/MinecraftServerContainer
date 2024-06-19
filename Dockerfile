# Use a base Linux image
FROM ubuntu:latest

# Install dependencies and OpenJDK 21
RUN apt-get update && apt-get install -y openjdk-21-jre-headless wget

# Copy the setup script
COPY scripts/setup-env.sh /setup-env.sh
RUN chmod +x /setup-env.sh

# Source the setup script to set environment variables and create the server directory
RUN . /setup-env.sh && mkdir -p $SERVER_PATH

# Set the working directory to /app (which is now a symlink to $SERVER_PATH)
WORKDIR /app

# Create a symbolic link from /app to the server path
RUN ln -sf $SERVER_PATH /app/server

# Copy the startup script to the container
COPY scripts/start-minecraft.sh .

# Make the startup script executable
RUN chmod +x ./start-minecraft.sh

# Set the entrypoint
COPY scripts/entrypoint.sh ./entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["./entrypoint.sh"]

# Expose the Minecraft server port and the RCON port
EXPOSE 25565 25575
