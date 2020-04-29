# vim: set foldmethod=marker foldlevel=0 nomodeline:
# ========================================= #
# SHELL SPECIFIC OPTIONS                    #
# ========================================= #

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# ----------------------------------------- #
# Z SHELL {{{
# ----------------------------------------- #
if [[ -n "$ZSH_VERSION" ]]; then
  # Placeholder
  :
# }}}

# ----------------------------------------- #
# BASH {{{
# ----------------------------------------- #
elif [[ -n "$BASH_VERSION" ]]; then
  ### Prompt
  if [[ $(id -u) -eq 0 ]]; then
    # Root user
    PS1="[\\[$red\\]\\u@\\h:\\w]\n 🍀 # \\[$reset\\]"
  else
    # Normal user
    PS1="[\\u@\\h:\\w]\n 🍀 $ "
  fi
# }}}

# ----------------------------------------- #
# OTHERS {{{
# ----------------------------------------- #
else
  # Placeholder
  :
fi
# }}}
