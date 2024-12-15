#!/bin/bash

# Install K3s on the master node
curl -sfL https://get.k3s.io | sh -

# Make sure kubectl is set up for the vagrant user
sudo mkdir -p /home/vagrant/.kube
sudo cp /etc/rancher/k3s/k3s.yaml /home/vagrant/.kube/config
sudo chown -R vagrant:vagrant /home/vagrant/.kube/config

# Get the token for the worker nodes
TOKEN=$(sudo cat /var/lib/rancher/k3s/server/node-token)

# Store the token for the workers to use
echo $TOKEN > /vagrant/token

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


# Install k3d
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash