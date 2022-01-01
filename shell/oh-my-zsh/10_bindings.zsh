# vim: set foldmethod=marker foldlevel=0 nomodeline:
# ========================================= #
# Oh My Zsh                                 #
# KEY BINDINGS                              #
# ========================================= #

# The delete button doesn't work
# unless we bind it to `delete-char`
bindkey "^[[3~" delete-char

# Set Shift-Tab for zsh autocompletion
bindkey "^[[Z" autosuggest-accept

# Bind 'jk' to <ESC>
bindkey -s jk "\e"
bindkey "jk" vi-cmd-mode

# Reveal aliases definition
# Bind to '~~'
function reveal_alias_definition() {
  zle _expand_alias
  zle expand-word
}
zle -N reveal_alias_definition
bindkey "~~" reveal_alias_definition

# Convert single-line command to multi-line one
# https://github.com/bbkane/dotfiles/blob/master/bin_common/bin_common/format_shell_cmd.py
# Bind to 'ff'
function format-shell-cmd() {
  BUFFER=$(echo "$BUFFER" | sed -e :a -e '/\\$/N; s/\\\n//; ta' | format_shell_cmd.py)
}
zle -N format-shell-cmd
bindkey "ff" format-shell-cmd
