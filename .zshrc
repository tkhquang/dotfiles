# ========================================= #
# .zshrc                                    #
# ========================================= #
# [Read when interactive]
# Put everything needed only for interactive usage in this file.
# Should contains:
# - prompt
# - command completion
# - command correction
# - command suggestion
# - command highlighting
# - output coloring
# - aliases
# - key bindings
# - commands history management
# - other miscellaneous interactive tools,
#   e.g. `auto_cd`, `manydots-magic`,...

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

for file in $HOME/dotfiles/shell/runcom/*.sh; do
  if [[ -f "$file" ]]; then
    source "$file"
  fi
done
