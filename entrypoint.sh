#!/bin/sh

./install.sh | PIXI_BIN_DIR=/opt/ PIXI_NO_PATH_UPDATE=1 bash
PATH="/opt/.pixi/bin:${PATH}"
cd /opt/es_sfgtools
pixi shell-hook -e full -s bash >> /etc/skel/.bashrc
pixi run setup -e full

# Copy the .bashrc file from the skeleton directory to the user's home directory
cp /opt/skel/.bashrc /home/user/.bashrc

# Execute the original container command
exec "$@"