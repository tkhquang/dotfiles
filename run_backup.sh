#!/bin/bash

set -euf -o pipefail

echo ">>> Commit to git..."

git pull origin master

# Back up current Tilix configs
if [ -x "$(command -v tilix)" ]; then
  dconf dump /com/gexperts/Tilix/ > tilix.dconf
fi

git add .
git commit -m "Backup at $(date)"
git push origin master

echo ">>> Done!"
