#!/bin/bash
# ========================================= #
# Create symlinks for the dotfiles          #
# ========================================= #

set -euf -o pipefail

echo ">>> Creating symlinks for the dotfiles..."

# List of files located in ~/dotfiles/index_targets
while read target; do
  # Skip blank lines and lines starting with '#'
  case $target in
    ''| \#*) continue ;;
  esac
  if [[ -f "$HOME/dotfiles/$target" ]]; then
    ln -svfn "$HOME/dotfiles/$target" "$HOME/$target"
  elif [[ -d "$HOME/dotfiles/$target" ]]; then
    mkdir -p "$HOME/$target/"
    #TODO: Handle hidden files later
    # For now, there are no hidden files so it's not a problem
    ln -svfn "$HOME/dotfiles/$target/"* "$HOME/$target/"
  fi
done < ~/dotfiles/index_targets

# Custom bin
ln -svfn ~/dotfiles/bin_common ~/bin_common

### /etc/profile.d/
# Remove all broken symbolic links in the targer directory (if any)
for file in /etc/profile.d/*.local /etc/profile.d/*.sh; do
  if [[ -L "$file" ]] && ! [[ -e "$file" ]]; then
    sudo rm -v -- "$file"
  fi
done
# Create symlinks
for file in $HOME/dotfiles/shell/system-wide/*.local $HOME/dotfiles/shell/system-wide/*.sh; do
  sudo ln -svf "$file" "/etc/profile.d/${file##*/}"
done

### $HOME/.oh-my-zsh/custom
mkdir -p $HOME/.oh-my-zsh/custom
# Remove all broken symbolic links in the targer directory (if any)
for file in $HOME/.oh-my-zsh/custom/*.zsh; do
  if [[ -L "$file" ]] && ! [[ -e "$file" ]]; then
    rm -v -- "$file"
  fi
done
# Create symlinks
for file in $HOME/dotfiles/shell/oh-my-zsh/*.zsh; do
  ln -svf "$file" "$HOME/.oh-my-zsh/custom/${file##*/}"
done

echo ">>> Symlinks for the dotfiles created!"
