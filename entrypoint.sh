#!/bin/sh
# Copy the .bashrc file from the skeleton directory to the user's home directory
cp /opt/skel/.bashrc /home/user/.bashrc

# Execute the original container command
exec "$@"