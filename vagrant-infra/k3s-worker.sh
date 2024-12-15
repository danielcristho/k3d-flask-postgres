#!/bin/bash
# Get the token from the shared folder
TOKEN=$(cat /vagrant/token)

# Install K3s agent (worker) and join the master node
curl -sfL https://get.k3s.io | K3S_URL=https://192.168.56.20:6443 K3S_TOKEN=$TOKEN sh -

# install docker
curl -fsSL https://get.docker.com -o install-docker.sh
sudo sh install-docker.sh

# set rootless
sudo sh -eux <<EOF
# Install newuidmap & newgidmap binaries
apt-get install -y uidmap
# Add subuid entry for vagrant
echo "vagrant:100000:65536" >> /etc/subuid
# Add subgid entry for vagrant
echo "vagrant:100000:65536" >> /etc/subgid
EOF
dockerd-rootless-setuptool.sh install