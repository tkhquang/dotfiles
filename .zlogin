# ========================================= #
# .zlogin                                   #
# ========================================= #
# [Read at login]
# This file is like `.zprofile`, but is read after `.zshrc` -> The shell is basically fully set up at `.zlogin` execution time.
# Should contains:
# - External commands which do not modify shell behaviors
#   e.g. a login manager, fortune, msgs, etc...

if [[ -f ~/dotfiles/shell/others/login.sh ]]; then
  source ~/dotfiles/shell/others/login.sh
fi
