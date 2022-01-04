# vim: set foldmethod=marker foldlevel=0 nomodeline:
# ========================================= #
# OSX specific settings                     #
# ========================================= #

# Force Darwin to use /etc/profile.d
if [[ "$(uname)" == Darwin ]]; then
  for i in /etc/profile.d/*.sh /etc/profile.d/sh.local; do
    if [ -r "$i" ]; then
      if [ "${-#*i}" != "$-" ]; then
        . "$i"
      else
        . "$i" >/dev/null
      fi
    fi
  done
fi
