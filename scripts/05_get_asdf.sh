#!/bin/bash

# Install asdf

set -euf -o pipefail

echo ">>> Installing asdf..."

git clone https://github.com/asdf-vm/asdf.git ~/.asdf
asdf plugin add erlang
asdf plugin add elixir
asdf plugin add deno
asdf plugin add nodejs
asdf plugin add yarn

echo ">>> asdf installed!"
