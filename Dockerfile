# Use a base Linux image
FROM ubuntu:latest

# Install dependencies and OpenJDK 21
RUN apt-get update && apt-get install -y openjdk-21-jre-headless wget

# Create a directory for the Minecraft server if it doesn't exist
RUN mkdir -p /app/data

# Copy the startup script to the container
COPY scripts/start-minecraft.sh /app/start-minecraft.sh

# Make the startup script executable
RUN chmod +x /app/start-minecraft.sh

# Set the working directory
WORKDIR /app

# Expose the Minecraft server port and the RCON port
EXPOSE 25565 25575

# Run the startup script
CMD ["/app/start-minecraft.sh"]
