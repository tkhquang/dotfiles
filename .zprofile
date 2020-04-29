# ========================================= #
# zprofile                                  #
# ========================================= #
# [Read at login]
# This file is like `.zlogin` except that it's sourced directly before `.zshrc`.
# Should contains:
# - Environment variables to configure tools
#   (flags for compilation, data folder location, etc...)
# - Configuration which execute commands,
#   e.g. `SCONSFLAGS="--jobs=$(( $(nproc) - 1 ))"`)
#   as it may take some time to execute.

if [[ -f ~/dotfiles/shell/env-var/variables.sh ]]; then
  source ~/dotfiles/shell/env-var/variables.sh
fi
