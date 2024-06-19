# Use a base Linux image
FROM ubuntu:latest

# Log the start of the Dockerfile
RUN echo "The Dockerfile has started."

# Install dependencies and OpenJDK 21
RUN apt-get update && apt-get install -y openjdk-21-jre-headless wget

# Copy the setup script
COPY scripts/setup-env.sh /setup-env.sh
RUN chmod +x /setup-env.sh

# Source the setup script to set environment variables and create the server directory
RUN /setup-env.sh

# This should be the mount path for the volume
RUN echo "The mount path is $MOUNT_PATH"

# Make sure the persistence directory exists
# If it doesn't, create it, but it will be emphemeral because it's not a volume
RUN mkdir -p $MOUNT_PATH

# Set the working directory to /app
WORKDIR /app

# Create a symbolic link from /app to the server path
RUN ln -sf $MOUNT_PATH ./server && ls -la ./

# Copy the startup script to the container
COPY scripts/start-minecraft.sh .

# Make the startup script executable
RUN chmod +x ./start-minecraft.sh

# Set the entrypoint
COPY scripts/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose the Minecraft server port and the RCON port
EXPOSE 25565 25575

RUN echo "The Dockerfile is complete."

# Run the entrypoint script
ENTRYPOINT ["/entrypoint.sh"]


