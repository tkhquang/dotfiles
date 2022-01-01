# vim: set foldmethod=marker foldlevel=0 nomodeline:
# ========================================= #
# Z SHELL ONLY                              #
# ========================================= #

# Not in zsh?
[[ -z "$ZSH_VERSION" ]] && return

# Powerlevel10k's Instant Prompt
# Requires to be put at the top of ~/.zshrc
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ----------------------------------------- #
# Oh My Zsh {{{
# A framework for managing zsh configuration
# https://github.com/ohmyzsh/ohmyzsh
# ----------------------------------------- #

# Path to Oh My Zsh directory
export ZSH="$HOME/.oh-my-zsh"

# Registered plugins for Oh my zsh
plugins=(
  bgnotify
  colorize
  command-not-found
  dnf
  fd
  git
  ripgrep
  history-substring-search
  sudo
  vi-mode
  z
  zsh-autosuggestions
  fancy-ctrl-z
  zsh-syntax-highlighting
)

[[ $UID = 0 ]] && ZSH_DISABLE_COMPFIX=true

# Set to the name theme to load.
# Look in ~/.oh-my-zsh/themes/
ZSH_THEME="powerlevel10k/powerlevel10k"

# Colorize
# - Requires 'Pygmentize' or 'Chroma'
#   https://github.com/pygments/pygments
#   https://github.com/alecthomas/chroma
ZSH_COLORIZE_TOOL=pygmentize
ZSH_COLORIZE_STYLE="solarized-dark"

source $ZSH/oh-my-zsh.sh

# }}}

# ----------------------------------------- #
# OTHERS {{{
# ----------------------------------------- #

### History
HISTFILE=$HOME/.zsh_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE

### Settings
# https://linux.die.net/man/1/zshoptions

# Record timestamp of command in HISTFILE
setopt extended_history
# Delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_expire_dups_first
# Ignore duplicated commands history list
setopt hist_ignore_dups
# Ignore commands that start with space
setopt hist_ignore_space
# Remove superfluous blanks from each command line
setopt hist_reduce_blanks
# Show command with history expansion to user before running it
setopt hist_verify
# Add commands to HISTFILE in order of execution
setopt inc_append_history
# Share command history data
setopt share_history

# Powerlevel10k
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# fzf
if has fzf; then
  [[ -f /usr/share/fzf/shell/key-bindings.zsh ]] && source /usr/share/fzf/shell/key-bindings.zsh
fi

# asdf
if has asdf; then
  fpath=(${ASDF_DIR}/completions $fpath)
  autoload -Uz compinit && compinit
fi

# Fix slowness of pastes with zsh-syntax-highlighting.zsh
# Taken from https://gist.github.com/magicdude4eva/2d4748f8ef3e6bf7b1591964c201c1ab
pasteinit() {
  OLD_SELF_INSERT=${${(s.:.)widgets[self-insert]}[2,3]}
  # I wonder if you'd need `.url-quote-magic`?
  zle -N self-insert url-quote-magic
}
pastefinish() {
  zle -N self-insert $OLD_SELF_INSERT
}
zstyle :bracketed-paste-magic paste-init pasteinit
zstyle :bracketed-paste-magic paste-finish pastefinish

# Fixes a corrupt .zsh_history file
zsh_fix_history() {
  mv ~/.zsh_history ~/.zsh_history_bad
  strings -eS ~/.zsh_history_bad > ~/.zsh_history
  fc -R ~/.zsh_history
  rm ~/.zsh_history_bad
}

# }}}
