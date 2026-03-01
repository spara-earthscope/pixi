#!/bin/sh


./install.sh --prefix /opt/bin/.pixi/bin
PATH="/opt/bin/.pixi/bin:${PATH}"
cd /opt/es_sfgtools
pixi shell-hook -e full -s bash >> /etc/skel/.bashrc
pixi run setup -e full

# Copy the .bashrc file from the skeleton directory to the user's home directory
cp /opt/skel/.bashrc /home/user/.bashrc

# Execute the original container command
exec "$@"