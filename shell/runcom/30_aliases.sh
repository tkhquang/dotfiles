# vim: set foldmethod=marker foldlevel=0 nomodeline:
# ========================================= #
# ALIASES                                   #
# ========================================= #

# ----------------------------------------- #
# THINGS TO REMEMBER {{{
# ----------------------------------------- #

### Function alias schemes
# alias sample='true ; __f() { unset -f $0; echo "$@"; }; __f'

# }}}

# ----------------------------------------- #
# VIM-RELATED COMMANDS {{{
# ----------------------------------------- #

alias :q="exit"
alias :q!="exit"
alias :e="$EDITOR"
alias :sp="tmux_horizontal_split"
alias :vsp="tmux_vertical_split"

# [e]ditor [i]nstall plugins
alias :ei="vim +PlugInstall +qall"
alias ei="vim +PlugInstall +qall"

# [e]dit [d]otfiles
alias :ed="$EDITOR $HOME/dotfiles"
alias ed="$EDITOR $HOME/dotfiles"

# }}}

# ----------------------------------------- #
# CONVENIENT HELPERS {{{
# ----------------------------------------- #

alias c="clear"

alias ll="ls -lh"
alias l.="ls -d .*"
alias ll.="ls -lh -d .*"
alias lls="ls -lha --sort=size"
alias llt="ls -lha --sort=time"

alias lc="colorls --sd --sf -A"

# Reload the shell (i.e. invoke as a login shell)
alias reload="reload_as_login_shell"

# Suspend (when going AFK)
alias afk="systemctl suspend"

# Lock the screen
alias lock="loginctl lock-session"

# Run ArchiSteamFarm
alias asf="ArchiSteamFarm"

### Docker
alias dpsa="docker ps -a"
alias dcup="docker-compose up"
alias dcupd="docker-compose up -d"

### Tmux
alias tmux="tmux -u -2"
alias t="tmux"
alias tl="tmux list-sessions"
alias tls="ls $TMPDIR/tmux*/"
alias ta="tmux attach -t"
alias tad="tmux attach -d -t"
alias ts="tmux new-session -s"
alias tksv="tmux kill-server"
alias tkss="tmux kill-session -t"

### Tilix
alias tilix-prefs="tilix --preferences"

# List users
alias ls-users="cut -d: -f1 /etc/passwd"

# List mounted drives
list_mounted_drives_cmds=(
  mount
  \|
  grep ^\/dev
  \|
  gawk \'{ print \$1, \$3}\'
  \|
  column -t
  \|
  sort
)
alias ls-drives="${list_mounted_drives_cmds[*]}"
unset list_mounted_drives_cmds

### What has been installed?
# Packages on npm
alias ls-npm="npm list -g --depth=0"
# Pakages on Fedora listed with size
# - %10{size}: aligns the size of the package to the right
#   with a padding of 10 characters.
# -%-25{name}: aligns the name of the package to the left,
#  padded to 25 characters.
# - %{version}: indicates the version and sort -n flag sorts
#   the packages according to size from the smallest
#   to the largest in bytes.
list_apps_cmd=(
  rpm
  -qa
  --queryformat
  \"%10{size} - %-25{name} \\t %{version}\\n\"
  \|
  sort -n
)
alias ls-apps="${list_apps_cmd[*]}"
unset list_apps_cmd
# Installed Kernels and All Kernel Packages
alias ls-kernels="rpm -qa kernel\* | sort -V"

# Print each PATH entry on a separate line
alias ls-path="echo -e ${PATH//:/$'\n'}"
# alias ls-path='tr ':' '\n' <<< "$PATH"'

# List aliases with highlighting if available
alias ls-aliases="list_aliases"

# Usage: ls-fs +1M
# Find all files larger than 1 megabyte
alias ls-fs="list_file_by_size"

# Remove old kernels on Fedora
# dnf repoquery set negative --latest-limit
# as how many old kernels you want keep
clean_kernels_cmd=(
  sudo dnf remove
  '$('
  dnf repoquery
  --installonly
  --latest-limit=-2
  -q
  ')'
)
alias clean-kernels="${clean_kernels_cmd[*]}"
unset clean_kernels_cmd

# }}}

# ----------------------------------------- #
# CROSS-PLATFORM HELPERS {{{
# ----------------------------------------- #

if ! has ren; then
  alias ren="mv"
fi

if ! has pbcopy; then
  alias pbcopy="xclip -selection clipboard"
  alias pbpaste="xclip -selection clipboard -o"
fi
# if [ $+commands[xclip] ]; then
#   alias pbcopy='xclip -selection clipboard -in'
#   alias pbpaste='xclip -selection clipboard -out'
# fi

# Normalize `open` across Linux, macOS, and Windows.
# This is needed to make the `o` function cross-platform.
if [ ! $(uname -s) = 'Darwin' ]; then
  if grep -q Microsoft /proc/version; then
    # Ubuntu on Windows using the Linux subsystem
    alias open="explorer.exe"
  else
    alias open="xdg-open"
  fi
fi

# }}}

# ----------------------------------------- #
# OVERRIDES {{{
# ----------------------------------------- #
# Override commands
# Prefix '\' for running with the originals
# ex: \ls

# Make the editors consistent
alias vi="$EDITOR"
alias vim="$EDITOR"

# Trick to pass aliases to sudo
alias sudo="sudo "

# Use 'bat' as default 'cat' if available
if has bat; then
  alias cat="bat"
fi

# Use 'exa' as default 'ls' if available
# Use 'exa --tree' as default 'tree' if available
if has exa; then
  alias ls="exa"
  alias tree="exa --tree"
fi

# }}}

# ----------------------------------------- #
# OTHERS {{{
# ----------------------------------------- #

alias nvidia="__NV_PRIME_RENDER_OFFLOAD=1 __GLX_VENDOR_LIBRARY_NAME=nvidia __VK_LAYER_NV_optimus=NVIDIA_only"

# }}}
