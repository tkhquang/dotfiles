# ========================================= #
# .zlogout                                  #
# ========================================= #
# [Read at logout] [Within login shell]
# Should contains:
# - Execution to clear terminal
#   or any other resource which was setup at login.

if [[ -f ~/dotfiles/shell/others/logout.sh ]]; then
  source ~/dotfiles/shell/others/logout.sh
fi
