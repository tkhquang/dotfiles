#!/bin/bash

# Download the basic packages

set -euf -o pipefail
# Install pre-reqs
echo ">>> Installing Prerequisite Packages..."
sudo dnf install -y git python3 ruby dnf-plugins-core
echo ">>> Prerequisite Packages installed!"
