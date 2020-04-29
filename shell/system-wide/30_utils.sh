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

# Distro independent utils
# - [p]ac[k]a[g]e search, install, remove
# - [dist]ro update, upgrade, cleanup
if has apt; then
  alias pkg-search="apt search"
  alias pkg-install="sudo apt-get install"
  alias pkg-remove="sudo apt-get remove --purge"

  alias dist-update="sudo apt-get update"
  alias dist-upgrade="sudo apt-get dist-upgrade"
  alias dist-cleanup="sudo apt-get autoremove"
elif has zypper; then
  alias pkg-search="zypper search"
  alias pkg-install="sudo zypper install"
  alias pkg-remove="sudo zypper remove --clean-deps"

  alias dist-update="sudo zypper refresh"
  alias dist-upgrade="sudo zypper update"
  alias dist-cleanup="sudo zypper rm -u"
elif has dnf; then
  alias pkg-search="dnf search"
  alias pkg-install="sudo dnf install"
  alias pkg-remove="sudo dnf remove"

  alias dist-update="sudo dnf check-update"
  alias dist-upgrade="sudo dnf update"
  alias dist-cleanup="sudo dnf autoremove"
elif has yum; then
  alias pkg-search="yum search"
  alias pkg-install="sudo yum install"
  alias pkg-remove="sudo yum remove"

  alias dist-update="sudo yum check-update"
  alias dist-upgrade="sudo yum update"
  alias dist-cleanup="sudo yum autoremove"
elif has pacman; then
  alias pkg-search="pacman -Ss"
  alias pkg-install="sudo pacman -S"
  alias pkg-remove="sudo pacman -R"

  alias dist-update="sudo pacman -Sy"
  alias dist-upgrade="sudo pacman -Syu"
  alias dist-cleanup="sudo pacman -Rsn"
elif has emerge; then
  alias pkg-search="emerge -s"
  alias pkg-install="sudo emerge -av"
  alias pkg-remove="sudo emerge -avC"

  alias dist-update="sudo emerge --sync"
  alias dist-upgrade="sudo emerge -avuND @world"
  alias dist-cleanup="sudo emerge --ask --depclean"
elif has pkg; then
  alias pkg-search="pkg -o search"
  alias pkg-install="sudo pkg install"
  alias pkg-remove="sudo pkg remove"

  alias dist-update="sudo pkg update"
  alias dist-upgrade="sudo pkg upgrade"
  alias dist-cleanup="sudo pkg autoremove"
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