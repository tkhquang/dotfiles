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

# Enabling the RPM Fusion repositories
sudo dnf -y install https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
sudo dnf -y install https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm


# Installing plugins for playing movies and music
sudo dnf -y install gstreamer1-plugins-{bad-\*,good-\*,base} gstreamer1-plugin-openh264 gstreamer1-libav --exclude=gstreamer1-plugins-bad-free-devel
sudo dnf -y install lame\* --exclude=lame-devel
sudo dnf group upgrade --with-optional Multimedia

echo ">>> Some other packages installed!"
