# $HOME/.oh-my-zsh/custom

All files in this directory are symlinked to `$HOME/.oh-my-zsh/custom`

Files in `$HOME/.oh-my-zsh/custom` are custom scripts for oh-my-zsh, will be automatically loaded by the init script, in alphabetical order.

To create or recreate symlinks, run

```bash

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

```
