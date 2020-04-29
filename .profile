# ========================================= #
# .profile                                  #
# ========================================= #
# `.profile` is for things that are not specifically related to Bash, like environment variables `PATH` and related stuff, and should be available anytime.
# For example, `.profile` should also be loaded when starting a graphical desktop session.

if [[ -f ~/dotfiles/shell/env-var/path.sh ]]; then
  source ~/dotfiles/shell/env-var/path.sh
fi

if [[ -f ~/dotfiles/shell/env-var/variables.sh ]]; then
  source ~/dotfiles/shell/env-var/variables.sh
fi
