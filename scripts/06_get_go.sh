#!/bin/bash

# Download and install the latest Golang release for AMD64
# https://dl.google.com/go/go1.14.1.linux-amd64.tar.gz

set -euf -o pipefail

echo ">>> Installing latest Golang release for AMD64..."

# Download Latest Go
GOURLREGEX='https:\/\/dl\.google\.com\/go\/go([0-9\.]+)\.linux-amd64\.tar\.gz'
echo "+ Finding latest version of Go for AMD64"
url="$(wget -qO- https://golang.org/dl/ | grep -oP ${GOURLREGEX} | head -n 1)" || { [ $? -ne 0 ] && [ $? -ne 8 ] && echo Found || exit 1; }
latest="$(echo $url | grep -oP 'go[0-9\.]+' | grep -oP '[0-9\.]+' | head -c -2 )"

# Exit script if the same version has been installed
if [ ${latest} == $(go version | sed -nre 's/^[^0-9]*(([0-9]+\.)*[0-9]+).*/\1/p') ]; then
  echo ">>> Latest Go installed, skipping..."
  exit 0
fi

echo "+ Downloading latest Go for AMD64: ${latest}"
wget --quiet --continue --show-progress "${url}"
unset url
unset GOURLREGEX

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
echo "+ Installing dep for dependency management"
go get -u github.com/golang/dep/cmd/dep

# Remove Download
rm go"${latest}".linux-amd64.tar.gz

echo ">>> Go ${latest} installed!"

