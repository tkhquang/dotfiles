# vim: set foldmethod=marker foldlevel=0 nomodeline:
# ========================================= #
# VARIABLES                                 #
# ========================================= #

# What platform are we running on
export UNAME=$(uname)

# Create $TMPDIR varibale if not exist
if [[ -z "$TMPDIR" ]]; then
  export TMPDIR="/tmp"
fi

# Make sure XDG dirs are set
[[ -n "$XDG_CONFIG_HOME" ]] || export XDG_CONFIG_HOME=$HOME/.config
[[ -n "$XDG_CACHE_HOME" ]] || export XDG_CACHE_HOME=$HOME/.cache
[[ -n "$XDG_DATA_HOME" ]] || export XDG_DATA_HOME=$HOME/.local/share

# Prevent storing history of `less`
export LESSHISTFILE=-
export LESSHISTSIZE=0

export LESS="-i -N -w -z-4 -g -M -X -F -R"
export BAT_PAGER="less"
export PAGER="nvim -c PAGER -"
export MANPAGER="nvim -c MANPAGER \
-c ':setlocal conceallevel=0' \
-c ':setlocal colorcolumn=0' \
-"

# Requires https://github.com/sharkdp/vivid
if has vivid; then
  export LS_COLORS="$(vivid generate snazzy)"
fi

# Required for GPG
export GPG_TTY=$(tty)

# Set USER if it does not exist.
# https://github.com/sorin-ionescu/prezto/pull/605
if [ ! "$USER" ]; then
  export USER="${USER:-$(whoami)}"
fi

# Set default browser to firefox if exists
if has firefox; then
  export BROWSER=firefox
fi

export FILER=dolphin

# Set default text editor to Neovim if exists
if has nvim; then
  export VISUAL=nvim
else
  export VISUAL=vim
fi
export EDITOR="$VISUAL"
export SYSTEMD_EDITOR="$VISUAL"

# ibus
if has ibus; then
  export XMODIFIERS="@im=ibus"
  export GTK_IM_MODULE="ibus"
  export QT4_IM_MODULE="ibus"
  export QT_IM_MODULE="ibus"
fi

# fzf
if has fzf; then

  # Use the 'fd' command instead of the default 'find' command
  if has fd; then
    fzf_fd_cmd=(
      fd
      --type f
      --color=always
      --hidden
      --no-ignore-vcs
      '--exclude "{.git,node_modules,*.pyc}"'
    )
    export FZF_DEFAULT_COMMAND="${fzf_fd_cmd[*]}"
    unset fzf_fd_cmd

    # Search for files in the current location
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

    # Search for directories in the current location
    fzf_fd_alt_c_cmd=(
      fd
      --type d .
      --color=always
      --hidden
      --no-ignore-vcs
      '--exclude "{.git,node_modules}"'
    )
    export FZF_ALT_C_COMMAND="${fzf_fd_alt_c_cmd[*]}"
    unset fzf_fd_alt_c_cmd
  fi

  fzf_opts=(
    --ansi
    --multi
    --reverse
    --height 96%
    --bind alt-j:down,alt-k:up
  )
  export FZF_DEFAULT_OPTS="${fzf_opts[*]}"
  unset fzf_opts

  if has bat; then
    fzf_ctrl_t_opts=(
      --preview
      \"
      bat
      --color=always
      --line-range :500
      {}
      \"
    )
    export FZF_CTRL_T_OPTS="${fzf_ctrl_t_opts[*]}"
    unset fzf_ctrl_t_opts
  fi
fi
