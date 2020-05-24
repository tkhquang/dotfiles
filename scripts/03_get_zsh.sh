#!/bin/bash

# Install Z Shell and related stuff

set -euf -o pipefail

echo ">>> Installing Z Shell and related stuff..."

echo "+ Installing Z Shell"
sudo dnf install -y zsh
echo "+ Making Z Shell the default shell"
chsh -s $(which zsh)

# Install Oh my zsh
echo "+ Installing Oh my zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install Powerlevel10k
echo "+ Installing Powerlevel10k"
rm -rf ~/.oh-my-zsh/custom/themes/powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo ">>> Z Shell and related stuff installed!"

