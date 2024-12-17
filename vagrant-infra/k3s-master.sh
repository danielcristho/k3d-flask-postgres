#!/bin/bash

# Update /etc/systemd/resolved.conf
echo "DNS=8.8.8.8 1.1.1.1" | sudo tee -a /etc/systemd/resolved.conf > /dev/null
echo "FallbackDNS=8.8.4.4 1.0.0.1" | sudo tee -a /etc/systemd/resolved.conf > /dev/null
sudo systemctl restart systemd-resolved

# Add entry to /etc/hosts
echo "192.168.56.20 k3s-master" | sudo tee -a /etc/hosts > /dev/null
echo "192.168.56.21 k3s-app1" | sudo tee -a /etc/hosts > /dev/null
echo "192.168.56.22 k3s-app2" | sudo tee -a /etc/hosts > /dev/null
echo "192.168.56.23 k3s-db" | sudo tee -a /etc/hosts > /dev/null

# Install K3s on the master node
curl -sfL https://get.k3s.io | sh -s - --tls-san 192.168.56.20

# Make sure kubectl is set up for the vagrant user
sudo mkdir -p /home/vagrant/.kube
sudo cp /etc/rancher/k3s/k3s.yaml /home/vagrant/.kube/config
sudo chown -R vagrant:vagrant /home/vagrant/.kube/config
sudo cp /home/vagrant/.kube/config /vagrant/config

# Get the token for the worker nodes
TOKEN=$(sudo cat /var/lib/rancher/k3s/server/node-token)
# Store the token for the workers to use
echo $TOKEN > /vagrant/token

# Install Docker
echo "Install Docker"
sudo apt-get update
sudo apt-get install ca-certificates curl -y
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
# Add the repository to Apt sources
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
sudo usermod -aG docker vagrant
echo "Install Docker done..."

# Install k3d (optional)
# curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash