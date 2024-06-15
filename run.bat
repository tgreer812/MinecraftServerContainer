@echo off

REM Build the Docker image
docker build -t myimage .

REM Run the Docker container
docker run -d --name mycontainer myimage