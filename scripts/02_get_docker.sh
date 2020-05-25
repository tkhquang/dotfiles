#!/bin/bash

# Install docker & docker-compose

# Might be fail on new fedora
# set -euf -o pipefail

echo ">>> Installing docker & docker-compose..."

echo "+ Removing old versions (if any)"
sudo dnf autoremove docker

echo "+ Setting up the stable repository"
curl -O https://download.docker.com/linux/fedora/docker-ce.repo
# Waiting for official fedora 32 repo
sed -i 's/$releasever/31/g' docker-ce.repo
sudo mv docker-ce.repo /etc/yum.repos.d/

echo "+ Installing latest version of Docker Engine and containerd"
sudo dnf install -y docker-ce docker-ce-cli containerd.io

echo "+ Installing latest version of docker-compose"
sudo curl -L "https://github.com/docker/compose/releases/download/1.25.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -sf /usr/local/bin/docker-compose /usr/bin/docker-compose
sudo usermod -aG docker $USER

echo ">>> docker & docker-compose installed!"
