#!/bin/bash

set -euf -o pipefail

echo ">>> Commit to git..."

git pull origin master

# Back up current Tilix configs
if [ -x "$(command -v tilix)" ]; then
  dconf dump /com/gexperts/Tilix/ > tilix.dconf
fi

git config commit.template ./.gitmessage
git add .
git commit
# git push origin master

echo ">>> Done!"
