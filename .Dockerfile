# Use a base Linux image
FROM ubuntu:latest

# Install Java
RUN apt-get update && apt-get install -y openjdk-11-jre

# Download the Minecraft server jar file
RUN wget -O minecraft_server.jar https://piston-data.mojang.com/v1/objects/450698d1863ab5180c25d7c804ef0fe6369dd1ba/server.jar

# Set the server options and start the server
CMD java -Xmx1024M -Xms1024M -jar minecraft_server.jar nogui