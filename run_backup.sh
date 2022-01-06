#!/bin/bash

set -euf -o pipefail

echo ">>> Commit to git..."

git pull origin master

touch ~/dotfiles/.gitmessage
cat <<EOF | tee ~/dotfiles/.gitmessage
Backup at $(date)

-
EOF

git config commit.template ~/dotfiles/.gitmessage
git add .
git commit
git push origin master

echo ">>> Done!"
