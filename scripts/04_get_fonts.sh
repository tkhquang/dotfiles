#!/bin/bash

# Get custom Fonts

set -euf -o pipefail

echo ">>> Installing Custom Fonts..."

# Nerd Font - Hack
echo "+ Downloading Hack Nerd Font"
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip -O temp.zip --quiet --show-progress
echo "+ Extracting Hack Nerd to Font Directory"
sudo unzip -o temp.zip -d /usr/share/fonts/hack-nerd-test
rm -rf temp.zip

echo "+ Building Font Cache"
sudo fc-cache

echo ">>> Custom fonts installed!"
