#!/bin/bash
# ========================================= #
# MacOS related stuff                       #
# ========================================= #

set -euf -o pipefail

[[ "$(uname)" != Darwin ]] && return

# Force Darwin to use /etc/profile.d
sudo tee -a /etc/profile > /dev/null <<EOT

for i in /etc/profile.d/*.sh /etc/profile.d/sh.local ; do
  if [ -r "\$i" ]; then
      if [ "\${-#*i}" != "\$-" ]; then
        . "\$i"
      else
        . "\$i" >/dev/null
      fi
  fi
done
EOT
