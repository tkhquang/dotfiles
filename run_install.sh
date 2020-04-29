#!/bin/bash

set -euf -o pipefail

if [[ $(id -u) -eq 0 ]]; then
  echo "This script must be run as normal user" 1>&2
  exit 1
fi

# Grant this user access to the sudo commands without passwords
# Add all required cmds to the CMDS alias
sudo tee /etc/sudoers.d/$USER <<END > /dev/null 2>&1
$USER $(hostname) = NOPASSWD: ALL
END

for file in $HOME/dotfiles/scripts/*.sh; do
  if [[ -f "$file" ]]; then
    chmod +x "$file" && "$file"
  fi
done

# Then, remove the sudo access
sudo /bin/rm /etc/sudoers.d/$USER
sudo -k
