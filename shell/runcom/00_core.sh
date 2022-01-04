# vim: set foldmethod=marker foldlevel=0 nomodeline:
# ========================================= #
# CORE OPTIONS                              #
# ========================================= #

# Disable CTRL-S and CTRL-Q, it's horrible
stty -ixoff -ixon

### Tmux
# Allows to have multiple sessions opened
# Use the same windows, makes TMUX work like SCREEN.
if [[ -z "$TMUX" ]]; then
  local base_session="${USER}_session"

  # Create a new session if it doesn't exist
  tmux has-session -t $base_session 2>/dev/null || tmux new-session -s $base_session -d

  local client_cnt=$(tmux list-clients | wc -l)
  # Are there any clients connected already?
  if [ $client_cnt -ge 1 ]; then
    local client_id=0
    local session_name=$base_session"-"$client_id
    while [ $(
      tmux has-session -t $session_name 2>&/dev/null
      echo $?
    ) -ne 1 ]; do
      client_id=$((client_id + 1))
      session_name=$base_session"-"$client_id
    done
    tmux new-session -t $base_session -s $session_name -d
    tmux attach-session -t $session_name \; set-option destroy-unattached
  else
    tmux attach-session -t $base_session
  fi
fi

### asdf
if [[ -f $HOME/.asdf/asdf.sh ]]; then
  . $HOME/.asdf/asdf.sh
fi
if has brew; then
  . $(brew --prefix asdf)/libexec/asdf.sh
fi

### ibus
if has ibus-daemon; then
  ibus-daemon -drxR
fi
