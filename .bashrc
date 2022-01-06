# ========================================= #
# .bashrc                                   #
# ========================================= #
# `.bashrc` is for the configuring the interactive Bash usage,
# like Bash aliases, setting your favorite editor,
# setting the Bash prompt, etc.

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

for file in "$HOME/dotfiles/shell/runcom"/*.sh; do
  if [[ -f "$file" ]]; then
    source "$file"
  fi
done
