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

# # Workaround for Steam notification greyed out
# # https://github.com/ValveSoftware/steam-for-linux/issues/4735
# # THis will also enforce using intel graphics card
# cat << EOF | sudo tee /etc/X11/xorg.conf.d/20-intel.conf
# Section "Device"
#    Identifier  "Intel Graphics"
#    Driver      "intel"
#    Option      "AccelMethod"  "sna"
# EndSection
# EOF

echo ">>> Done!"
