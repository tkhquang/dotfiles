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

# Open Tilix Here
mkdir -p ~/.local/share/kservices5/ServiceMenus/
cat << EOF | tee ~/.local/share/kservices5/ServiceMenus/openTilixHere.desktop
[Desktop Entry]
Type=Service
ServiceTypes=KonqPopupMenu/Plugin
MimeType=inode/directory
Actions=openTilix;
X-KDE-Priority=TopLevel
X-KDE-StartupNotify=false
Icon=com.gexperts.Tilix

[Desktop Action openTilix]
Name=Open Tilix Here
Icon=com.gexperts.Tilix
Exec=tmux split-window -h -c %f & tmux send-keys "$@" Enter & tmux last-pane & tilix -w %u
EOF

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

# OS specific settings for kitty
# As include {ENV}.conf doesn't seem to work with OSX Launchpad
case "$(uname)" in
  Darwin)
  cat << EOF | tee ~/dotfiles/.config/kitty/os.conf
# Do not edit this file
# As it is autogenerated from
# ~/dotfiles/scripts/12_post_install.sh
font_size 12.0

map cmd+equal   increase_font_size
map cmd+minus   decrease_font_size
map cmd+0       restore_font_size
EOF
    ;;
  Linux)
    cat << EOF | tee ~/dotfiles/.config/kitty/os.conf
# Do not edit this file
# As it is autogenerated from
# ~/dotfiles/scripts/12_post_install.sh
font_size 10.0

map ctrl+equal   increase_font_size
map ctrl+minus   decrease_font_size
map ctrl+0       restore_font_size
EOF
    ;;
  *)
    ;;
esac

echo ">>> Done!"
