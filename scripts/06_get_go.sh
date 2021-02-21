#!/bin/bash

# Download and install the latest Golang release for AMD64
# https://golang.org/dl/go1.14.1.linux-amd64.tar.gz

set -euf -o pipefail

echo ">>> Installing latest Golang release for AMD64..."

# Download Latest Go
latest="$(wget -qO- https://golang.org/VERSION?m=text | sed -nre 's/^[^0-9]*(([0-9]+\.)*[0-9]+).*/\1/p')"

# Exit script if the same version has been installed
if [ ${latest} == $(go version | sed -nre 's/^[^0-9]*(([0-9]+\.)*[0-9]+).*/\1/p') ]; then
  echo ">>> Latest Go installed, skipping..."
  exit 0
fi

url="https://golang.org/dl/go${latest}.linux-amd64.tar.gz"

echo "+ Downloading latest Go for AMD64: ${latest}"
wget --quiet --continue --show-progress "${url}"

unset url

# Remove Old Go
sudo rm -rf /usr/local/go

# Install new Go
sudo tar -C /usr/local -xzf go"${latest}".linux-amd64.tar.gz
echo "+ Create the skeleton for your local users go directory"
mkdir -p ~/go/{bin,pkg,src}
echo "+ Setting up GOPATH"
echo "export GOPATH=~/go" >> ~/.profile && source ~/.profile
echo "+ Setting PATH to include golang binaries"
echo "export PATH='$PATH':/usr/local/go/bin:$GOPATH/bin" >> ~/.profile && source ~/.profile

# Remove Download
rm go"${latest}".linux-amd64.tar.gz

echo ">>> Go ${latest} installed!"

