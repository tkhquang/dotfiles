# vim: set foldmethod=marker foldlevel=0 nomodeline:
# ========================================= #
# BASH ONLY                                 #
# ========================================= #

# Not in bash?
[[ -z "$BASH_VERSION" ]] && return

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

# asdf
if has asdf; then
  if [[ -f $HOME/.asdf/completions/asdf.bash ]]; then
    . "$HOME/.asdf/completions/asdf.bash"
  fi
fi
