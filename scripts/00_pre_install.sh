#!/bin/bash
# ========================================= #
# Backup all the existing configs (if any)  #
# ========================================= #

set -euf -o pipefail

function create_backup () {
  mkdir -p "$HOME/.backup"

  if [[ -d "$1" ]]; then
    local -r no_slash="${1%/}"
    mkdir -p "$HOME/.backup${no_slash}"
    cp -vr "${no_slash}" "$HOME/.backup${no_slash}.$(date +'%Y-%m-%d.%H.%M.%S').bak"
  elif [[ -f "$1"  ]]; then
    mkdir -p "$HOME/.backup${1}"
    cp -v "$1" "$HOME/.backup${1}.$(date +'%Y-%m-%d.%H.%M.%S').bak"
  else
    echo "Only files and directories supported"
  fi
}

# List of files located in ~/dotfiles/index_targets
while read target; do
  # Skip blank lines and lines starting with '#'
  case "$target" in
    ''| \#*) continue ;;
  esac
  if [[ -f "$HOME/$target" || -d "$HOME/$target" ]]; then
    create_backup "$HOME/$target"
  fi
done < ~/dotfiles/index_targets

if [[ -d /etc/profile ]]; then
  create_backup "/etc/profile"
fi

if [[ -d /etc/profile.d ]]; then
  create_backup "/etc/profile.d"
fi

if [[ -d ~/.vim ]]; then
  create_backup "$HOME/.vim"
fi

if [[ -d ~/.config/nvim ]]; then
  create_backup "$HOME/.config/nvim"
fi

unset -f create_backup

echo ">>> Backup created in ~/.backup!"
