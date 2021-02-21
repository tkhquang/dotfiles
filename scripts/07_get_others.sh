#!/bin/bash

# Install some other packages

set -euf -o pipefail

echo ">>> Installing some other packages..."

# Generic syntax highlighter
# https://github.com/pygments/pygments
echo "+ Installing Pygments"
pip3 install --user Pygments

echo "+ Installing other packages"
sudo dnf -y install tilix vim-enhanced neovim ripgrep bat tmux xclip xsel fd-find fzf exa

# vim and neovim
mkdir -p ~/.config/nvim
ln -svf ~/.vim ~/.config/nvim

# Install tpm, the tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install yarn is for current user
curl -o- -L https://yarnpkg.com/install.sh | bash

echo ">>> Some other packages installed!"
