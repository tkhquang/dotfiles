# vim: set foldmethod=marker foldlevel=0 nomodeline:
# ========================================= #
# SYSTEM-WIDE UTILITIES                     #
# ========================================= #
# System-wide functions and aliases

# ----------------------------------------- #
# CORE {{{
# ----------------------------------------- #
# Contains functions which are required for
# some other functions to execute

# Check if command is available
function has() {
  type "${1:?too few arguments}" >/dev/null 2>&1
}

# Normalize `open` across Linux, macOS, and Windows.
# This is needed to make the `o` function cross-platform.
if [ ! $(uname -s) = "Darwin" ]; then
  if grep -q Microsoft /proc/version; then
    # Ubuntu on Windows using the Linux subsystem
    alias open="explorer.exe"
  else
    alias open="xdg-open"
  fi
fi

# }}}

# ----------------------------------------- #
# HELPERS {{{
# ----------------------------------------- #

# Create a new directory and enter it
function mkd() {
  mkdir -p "$@" && cd "$_"
}

# `o` with no arguments opens the current directory,
# otherwise opens the given location
function o() {
  if [[ $# -eq 0 ]]; then
    open .
  else
    open "$1"
  fi
}

# Go up multiple directory levels
function cd_up() {
  cd $(printf "%0.s../" $(seq 1 $1 ))
}
alias "cd.."="cd_up"

alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# Reload the shell (i.e. invoke as a login shell)
alias reload="exec ${SHELL} -l"

# }}}
