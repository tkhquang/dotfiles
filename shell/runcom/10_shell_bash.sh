# vim: set foldmethod=marker foldlevel=0 nomodeline:
# ========================================= #
# BASH ONLY                                 #
# ========================================= #

# Not in bash?
[[ -z "$BASH_VERSION" ]] && return

# Source global definitions
if [ -f /etc/bashrc ]; then
  . /etc/bashrc
fi

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

# Autocorrect typos in path names when using `cd`
shopt -s cdspell

export HISTSIZE=100000
export HISTFILESIZE=$HISTSIZE

# fzf
if has fzf; then
  [[ -f /usr/share/fzf/shell/key-bindings.bash ]] && source /usr/share/fzf/shell/key-bindings.bash
fi
