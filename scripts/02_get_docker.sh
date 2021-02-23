#!/bin/bash

# Install docker & docker-compose

# Might be fail on new fedora
# set -euf -o pipefail

echo ">>> Installing docker & docker-compose..."

echo "+ Removing old versions (if any)"
sudo dnf autoremove docker

# Enable old CGroups as docker still not support CgroupsV2
sudo grubby --update-kernel=ALL --args="systemd.unified_cgroup_hierarchy=0"

# Set up firewall
sudo firewall-cmd --permanent --zone=trusted --add-interface=docker0
sudo firewall-cmd --permanent --zone=FedoraWorkstation --add-masquerade

# Install Moby, the open-source version of Docker
sudo dnf install moby-engine docker-compose
sudo systemctl enable docker

# Runing without sudo
sudo groupadd docker
sudo usermod -aG docker $USER

echo ">>> docker & docker-compose installed!"
