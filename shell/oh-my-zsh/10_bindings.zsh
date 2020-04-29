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
# bindkey "jk" vi-cmd-mode

# Reveal aliases definition
# Bind to '~~''
function reveal_alias_definition() {
  zle _expand_alias
  zle expand-word
}
zle -N reveal_alias_definition
bindkey "~~" reveal_alias_definition
