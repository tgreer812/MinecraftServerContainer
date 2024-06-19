#!/bin/sh

# Ensure the server path is set
# TODO: Test if this actually works if the user sets the MOUNT_PATH environment variable
# might not work because of the way docker does layers
: ${MOUNT_PATH:=/mnt/server}

# Export the environment variable
export MOUNT_PATH
