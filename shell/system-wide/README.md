# /etc/profile.d/

All files in this directory are symlinked to `/etc/profile.d/`

Files in `/etc/profile.d/` are run when a user logs in (unless setting `/etc/profile` to not do this) and are generally used to set environment variables, aliases, functions which should be used for multiple users. They will be automatically loaded in alphabetical order.

To create or recreate symlinks, run

```bash

# Remove all broken symbolic links in the targer directory (if any)
for file in /etc/profile.d/*.(local|sh); do
  if [[ -L "$file" ]] && ! [[ -e "$file" ]]; then
    sudo rm -v -- "$file"
  fi
done

# Create symlinks
for file in $HOME/dotfiles/shell/system-wide/*.(local|sh); do
  sudo ln -svf "$file" "/etc/profile.d/${file##*/}"
done

```
