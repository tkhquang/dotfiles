# ========================================= #
# zshenv                                    #
# ========================================= #
# [Read every time]
# This file is always sourced.
# Should contains:
# - `PATH` (or its associated counterpart path).

if [[ -f ~/dotfiles/shell/env-var/path.sh ]]; then
  source ~/dotfiles/shell/env-var/path.sh
fi

# Force zsh $path array to have unique values
# https://unix.stackexchange.com/a/62599
typeset -U path
