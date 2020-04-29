#!/bin/bash

# Install Node Version Manager and NodeJS

set -euf -o pipefail

echo ">>> Installing Node Version Manager and NodeJS..."

echo "+ Installing Node Version Manager"
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.35.3/install.sh | bash
. ~/.nvm/nvm.sh

echo "+ Installing latest LTS NodeJS"
nvm install --lts
echo "lts/*" > ~/.nvmrc

echo ">>> Node Version Manager and NodeJS installed!"

