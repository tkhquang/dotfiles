#!/bin/bash
# ========================================= #
# Normalize MacOS related stuff             #
# ========================================= #

set -euf -o pipefail

[[ "$(uname)" != Darwin ]] && return

# brew install wget

# brew tap homebrew/cask-fonts
# brew install --cask font-hack-nerd-font

# brew install kitty neovim ripgrep bat tmux fzf exa
