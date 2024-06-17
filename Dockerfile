# Use a base Linux image
FROM ubuntu:latest

# Install dependencies and OpenJDK 21
RUN apt-get update && apt-get install -y openjdk-21-jre-headless

# Install wget
RUN apt-get install -y wget

# Download the Minecraft server jar file
RUN wget -O /app/minecraft_server.jar https://piston-data.mojang.com/v1/objects/450698d1863ab5180c25d7c804ef0fe6369dd1ba/server.jar

# Accept the EULA
RUN echo "eula=true" > eula.txt

# Copy the startup script to the container
COPY scripts/start-minecraft.sh /app/start-minecraft.sh

# Make the startup script executable
RUN chmod +x /app/start-minecraft.sh

# Set the working directory
WORKDIR /app

# Expose the Minecraft server port and the RCON port
EXPOSE 25565 25575

# Run the startup script
CMD ["./start-minecraft.sh"]
