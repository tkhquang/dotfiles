#!/bin/bash

# Install some other packages

set -euf -o pipefail

echo ">>> Installing some other packages..."

# Generic syntax highlighter
# https://github.com/pygments/pygments
echo "+ Installing Pygments"
pip3 install --user Pygments

echo "+ Installing other packages"
sudo dnf -y install tilix vim-enhanced neovim ripgrep bat tmux xclip xsel fd-find fzf exa ibus\*

# vim and neovim
mkdir -p ~/.config/nvim
ln -svf ~/.vim ~/.config/nvim

# For plasma5-wallpapers-dynamic
sudo dnf install cmake extra-cmake-modules git kf5-kpackage-devel kf5-plasma-devel kf5-ki18n-devel qt5-qtbase-devel qt5-qtdeclarative-devel qt5-qtlocation-devel kf5-kio-devel
git clone https://github.com/zzag/plasma5-wallpapers-dynamic.git
cd plasma5-wallpapers-dynamic
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_INSTALL_LIBDIR=lib -DBUILD_TESTING=OFF
make
sudo make install

rm -rf $HOME/plasma5-wallpapers-dynamic

# Install tpm, the tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install yarn is for current user
curl -o- -L https://yarnpkg.com/install.sh | bash

echo ">>> Some other packages installed!"
