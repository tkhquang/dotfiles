#!/bin/bash

# Things to perform after all the required packages have been installed

set -euf -o pipefail

echo ">>> Final actions..."

echo "+ Installing Vim plugins"
vim +PlugInstall! +qall

echo "+ Configurating bin_common"
for file in $HOME/dotfiles/bin_common/*; do
  if [[ -f "$file" ]]; then
    chmod +x $file
  fi
done

echo "+ Restoring Tilix config"
dconf load /com/gexperts/Tilix/ < ~/dotfiles/tilix.dconf

echo ">>> Done!"
