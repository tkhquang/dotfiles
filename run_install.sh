#!/bin/bash

for file in $HOME/dotfiles/scripts/*.sh; do
  chmod +x "$file" && "$file"
done
