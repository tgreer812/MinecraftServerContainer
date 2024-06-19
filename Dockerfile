# Use a base Linux image
FROM ubuntu:latest

# Log the start of the Dockerfile
RUN echo "The Dockerfile has started."

# Install dependencies and OpenJDK 21
RUN apt-get update && apt-get install -y openjdk-21-jre-headless wget

# Set the working directory to /app
WORKDIR /app

# Copy the setup script
COPY scripts/setup-env.sh /setup-env.sh
RUN chmod +x /setup-env.sh

# Source the setup script to set environment variables and create the server directory
# The . command is equivalent to the source command in bash and is important 
# because it allows the script to set environment variables in the current shell
# NOTE: This needs to be done in the same RUN command in order for the environment variables to persist
RUN . /setup-env.sh && \
    echo "The mount path is $MOUNT_PATH" && \
    mkdir -p $MOUNT_PATH && \
    ln -sf $MOUNT_PATH ./server && \
    ls -la ./

# Copy the startup script to the container
COPY scripts/start-minecraft.sh .

# Make the startup script executable
RUN chmod +x /app/start-minecraft.sh

# Set the entrypoint
COPY scripts/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose the Minecraft server port and the RCON port
EXPOSE 25565 25575

# Run the entrypoint script
ENTRYPOINT ["/entrypoint.sh"]
