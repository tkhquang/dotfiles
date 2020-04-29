#!/bin/bash

# Install Archi Steam Farm

set -euf -o pipefail

if [ -d ~/.local/share/ArchiSteamFarm/ ]; then
  echo ">>> ASF folder found, skipping..."
else
  echo ">>> Installing Archi Steam Farm..."

  # Installing pre-reqs for ASF
  echo "+ Installing pre-reqs for Archi Steam Farm"
  sudo dnf install -y libcurl libicu krb5-libs lttng-ust openssl-libs zlib

  echo "+ Downloading Archi Steam Farm"
  wget https://github.com/JustArchiNET/ArchiSteamFarm/releases/latest/download/ASF-linux-x64.zip -O temp.zip --quiet --show-progress

  mkdir -p ~/.local/share/ArchiSteamFarm/

  echo "+ Extracting ASF"
  unzip temp.zip -d ~/.local/share/ArchiSteamFarm

  chmod +x ~/.local/share/ArchiSteamFarm/ArchiSteamFarm

  ln -svf ~/.local/share/ArchiSteamFarm/ArchiSteamFarm ~/.local/bin/ArchiSteamFarm

  echo ">>> Archi Steam Farm installed!"
fi
