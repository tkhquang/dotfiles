#!/bin/bash

for file in "$HOME/dotfiles/scripts"/*.sh; do
  if [[ -f "$file" ]]; then
    chmod +x "$file" && "$file"
  fi
done

# for file in "$HOME/dotfiles/scripts_darwin"/*.sh; do
#   if [[ -f "$file" ]]; then
#     chmod +x "$file" && "$file"
#   fi
# done
