#!/bin/sh

git clone --single-branch --branch main https://github.com/EarthScope/es_sfgtools.git
chown -R ${NB_USER}:${NB_USER} es_sfgtools
wget -qO- https://pixi.sh/install.sh > install.sh
chmod +x install.sh
chown ${NB_USER}:${NB_USER} install.sh
apt-get update && apt-get install -y libsuitesparse-dev
mkdir /opt/bin
echo 'export PATH=$PATH:/opt/bin/.pixi/bin' >> /etc/skel/.bashrc

./install.sh --prefix /opt/bin/.pixi/bin
ENV PATH="/opt/bin/.pixi/bin:${PATH}"
WORKDIR /opt/es_sfgtools
RUN pixi shell-hook -e full -s bash >> /etc/skel/.bashrc
RUN pixi run setup -e full

# Copy the .bashrc file from the skeleton directory to the user's home directory
cp /opt/skel/.bashrc /home/user/.bashrc

# Execute the original container command
exec "$@"