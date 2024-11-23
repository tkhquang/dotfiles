# vim: set foldmethod=marker foldlevel=0 nomodeline:
# ========================================= #
# FUNCTIONS                                 #
# ========================================= #

# ----------------------------------------- #
# HELPERS {{{
# ----------------------------------------- #

# Reload the shell (i.e. invoke as a login shell)
function reload_as_login_shell() {
  # Reload Tmux config if currently inside Tmux
  if [[ -n "$TMUX" ]] && [[ "$TERM" =~ ^(screen|tmux).*$ ]]; then
    tmux source-file ~/.tmux.conf \; display "Reloaded!"
  fi
  exec ${SHELL} -l
}

# Create Backups
function bak() {
  if [[ -d "$1" ]]; then
    # https://stackoverflow.com/a/9018877/2958070
    local -r no_slash="${1%/}"
    cp -r "${no_slash}" "${no_slash}.$(date +'%Y-%m-%d.%H.%M.%S').bak"
  elif [[ -f "$1" ]]; then
    cp "$1" "${1}.$(date +'%Y-%m-%d.%H.%M.%S').bak"
  else
    echo "Only files and directories supported"
  fi
}

# Determine size of a file or total size of a directory
function fs() {
  if du -b /dev/null > /dev/null 2>&1; then
    local arg=-sbh
  else
    local arg=-sh
  fi
  if [[ -n "$@" ]]; then
    du $arg -- "$@"
  else
    du $arg .[^.]* ./*
  fi
}

# Compare original and gzipped file size
function gz() {
  local origsize=$(wc -c < "$1")
  local gzipsize=$(gzip -c "$1" | wc -c)
  local ratio=$(echo "$gzipsize * 100 / $origsize" | bc -l)
  printf "orig: %d bytes\n" "$origsize"
  printf "gzip: %d bytes (%2.2f%%)\n" "$gzipsize" "$ratio"
}

# Create a data URL from a file
function dataurl() {
  local mimeType=$(file -b --mime-type "$1")
  if [[ $mimeType == text/* ]]; then
    mimeType="${mimeType};charset=utf-8"
  fi
  echo "data:${mimeType};base64,$(openssl base64 -in "$1" | tr -d '\n')"
}

# Get weather infomation of given location
# https://github.com/chubin/wttr.in
function weather() {
  local query_str=$(printf -- "+%s" $*)
  curl "wttr.in/${query_str:1}"
}

# Usage: list_file_by_size +1M
# Find all files larger than 1 megabyte
function list_file_by_size() {
  local ls_cmd=$(has eza && echo "eza" || echo "ls")

  if [[ $# -eq 0 ]]; then
    echo "too few arguments"
    return
  fi

  if has fd; then
    fd \
      --type f \
      --color=never \
      --hidden \
      --no-ignore-vcs \
      --exclude "{.git,node_modules,*.pyc}" \
      --size "$@" \
      --exec-batch "$ls_cmd" -la {} \;
  else
    find \
      -type f \
      -not \
      \( \
        -path "*/.git/*" \
        -o \
        -path "*/node_modules/*" \
        -o \
        -name "*.pyc" \
      \) \
      -size "$@" \
      -exec "$ls_cmd" -la {} \;
  fi
}

# List aliases with highlighting if available
function list_aliases() {
  if has bat; then
    alias "$@" | bat -l bash --style=plain
  else
    alias "$@"
  fi
}

# List environment variables with highlighting if available
function list_env() {
  if has bat; then
    env | bat -l bash --style=plain
  else
    env
  fi
}

# }}}

# ----------------------------------------- #
# FZF (Fuzzy Finder) {{{
# ----------------------------------------- #

# Search Scripts for Fuzzy finding (fzf)
# https://github.com/junegunn/fzf
# https://github.com/bluz71/dotfiles

# [f]zf [f]ind [e]dit - Find File and Edit
# Fuzzy find a file, with optional initial file name, and then edit:
# - If one file matches then edit immediately
# - If multiple files match, or no file name is provided, then open fzf with colorful preview
# - If no files match then exit immediately
function ffe() {
  local file=$(
    fzf --query="$1" --no-multi --select-1 --exit-0 \
      --preview 'bat --color=always --line-range :500 {}'
  )
  if [[ -n $file ]]; then
    $EDITOR "$file"
  fi
}

# [f]zf [c]hange [d]irectory - Find Directory and Change
# Fuzzy find a directory, with optional initial directory name, and then change to it:
# - If one directory matches then cd immediately
# - If multiple directories match, or no directory name is provided, then open fzf with tree preview
# - If no directories match then exit immediately
function fcd() {
  local directory=$(
    fd --type d |
      fzf --query="$1" --no-multi --select-1 --exit-0 \
        --preview 'tree -C {} | head -100'
  )
  if [[ -n $directory ]]; then
    cd "$directory"
  fi
}

# [f]zf [g]rep [e]dit - Find File with Term and Edit
# Fuzzy find a file, with colorful preview, that contains the supplied term, then once selected edit it in your preferred editor.
# Note, if your EDITOR is Vim or Neovim then you will be automatically scrolled to the selected line.
function fge() {
  if [[ $# == 0 ]]; then
    echo 'Error: search term was not provided.'
    return
  fi
  local match=$(
    rg --color=always --line-number --column "$1" |
      fzf --no-multi --delimiter : \
        --preview "~/.vim/plugged/fzf.vim/bin/preview.sh {}"
  )
  local file=$(echo "$match" | cut -d':' -f1)
  if [[ -n $file ]]; then
    $EDITOR "$file" +$(echo "$match" | cut -d':' -f2)
  fi
}

# [f]zf [kill] process - Find and Kill Process
# Fuzzy find a process or group of processes, then SIGKILL them.
# Multi-selection is enabled to allow multiple processes to be selected via the TAB key.
# This script negates the need to run ps manually and all the related pain involved to kill a recalcitrant process
function fkill() {
  local pid_col
  if [[ $UNAME = Linux ]]; then
    pid_col=2
  elif [[ $UNAME = Darwin ]]; then
    pid_col=3
  else
    echo 'Error: unknown platform'
    return
  fi
  local pids=$(
    ps -f -u $USER | sed 1d | fzf --multi | awk '{print $2}' ORS=' '
  )
  if [[ -n $pids ]]; then
    echo "$pids" | xargs kill -9 "$@"
  fi
}

# [f]zf [g]it [a]dd - Git Stage Files
# Selectively stage modified and untracked files, with preview, for committing.
# Note, modified and untracked files will be listed for staging.
function fga() {
  local selections=$(
    git status --porcelain |
      fzf --preview 'if (git ls-files --error-unmatch {2} &>/dev/null); then
        git diff --color=always {2}
      else
        bat --color=always --line-range :500 {2}
      fi'
  )
  if [[ -n $selections ]]; then
    git add --verbose $(echo "$selections" | cut -c 4- | tr '\n' ' ')
  fi
}

# [f]zf [g]it [l]og - Git Log Browser
# Displays a compact Git log list that can be filtered by entering a fuzzy term at the prompt.
# Navigation up and down the commit list will preview the changes of each commit.

function fgl() {
  local selections=$(
    git log --graph --format="%C(yellow)%h%C(red)%d%C(reset) - %C(bold green)(%ar)%C(reset) %s %C(blue)<%an>%C(reset)" --color=always "$@" |
      fzf --no-sort --height 100% \
        --preview "echo {} | grep -o '[a-f0-9]\{7\}' | head -1 | \
                      xargs -I@ sh -c 'git show --color=always @'"
  )
  if [[ -n $selections ]]; then
    local commits=$(echo "$selections" | cut -d' ' -f2 | tr --delete '\n' | tr '\n' ' ')
    git show $commits
  fi
}

# [f]zf [g]it [r]eflog - Git RefLog Browser
# Displays a Git reflog list that can be filtered by entering a fuzzy term at the prompt.
# Navigation up and down the hash list will preview the changes of each hash.
function fgr() {
  local selection=$(
    git reflog --color=always "$@" |
      fzf --no-multi --ansi --no-sort --height 100% \
        --preview "git show --color=always {1}"
  )
  if [[ -n $selection ]]; then
    git show $(echo $selection | cut -d' ' -f1)
  fi
}

# [f]zf [g]it [l]og [p]ickaxe - Git Pickaxe Browser
# Displays a Git log list that has been pickaxe (-S) filtered by the supplied search term.
# Navigation up and down the commit list will preview the changes of each hash.
function fglp() {
  if [[ $# == 0 ]]; then
    echo 'Error: search term was not provided.'
    return
  fi
  local selections=$(
    git log --oneline --color=always -S "$@" |
      fzf --ansi --no-sort --height 100% \
        --preview "git show --color=always {1}"
  )
  if [[ -n $selections ]]; then
    local commits=$(echo "$selections" | cut -d' ' -f1 | tr '\n' ' ')
    git show $commits
  fi
}

# }}}

# ----------------------------------------- #
# TMUX {{{
# ----------------------------------------- #

### Split vertically
# - If no arguments were passed, move to that pane directly
# - If arguments were passed, run the passed commands
#   while staying in the current pane
function tmux_vertical_split() {
  if [[ $# -eq 0 ]]; then
    tmux split-window -h
  else
    tmux split-window -h
    tmux send-keys "$@" Enter
    tmux last-pane
  fi
}

### Split horizontally
# - If no arguments were passed, move to that pane directly
# - If arguments were passed, run the passed commands
#   while staying in the current pane
function tmux_horizontal_split() {
  if [[ $# -eq 0 ]]; then
    tmux split-window -v
  else
    tmux split-window -v
    tmux send-keys "$@" Enter
    tmux last-pane
  fi
}

# }}}
