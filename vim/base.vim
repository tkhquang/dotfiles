" vim: set foldmethod=marker foldlevel=0 nomodeline:
" ================================================= "
" VIM BASE SETTINGS                                 "
" ================================================= "

" ------------------------------------------------- "
" GENERIC BEHAVIORS {{{
" ------------------------------------------------- "

" > Spell checking
set spelllang=en_us

" > Respect modeline (may have security issues)
set modelines=2

" > No beeps (it's annoying as hell)
set noerrorbells visualbell t_vb=

" > Allow backspacing over indention, line breaks and insertion start
set backspace=indent,eol,start

" > Open new split panes to right, bottom
set splitright splitbelow

" > Don’t reset cursor to start of line when moving around
set nostartofline

" > Automatically interface with the system's clipboard
" https://vi.stackexchange.com/a/96
set clipboard^=unnamed,unnamedplus

" > In many terminal emulators
" the mouse works just fine, thus enable it
if has('mouse')
  set mouse=a
endif

" > If linux then set ttymouse
let s:uname = system("echo -n \"$(uname)\"")
if !v:shell_error && s:uname == "Linux" && !has('nvim')
  set ttymouse=xterm
endif

" > Use the mouse just like visual mode
" so you can use vim commands on mouse selections
" eg. 'x' to cut and 'y' to yank
set selectmode-=mouse

" > Reload files if changed externally
set autoread

" > Time out on key codes but not mappings.
" Basically this makes terminal Vim work sanely.
set notimeout
set ttimeout
set ttimeoutlen=10

" }}}

" ------------------------------------------------- "
" TEXT RENDERING {{{
" ------------------------------------------------- "

" > The encoding displayed
set encoding=utf-8

" > It is not 'safe' to set these while resourcing $MYVIMRC
" in read-only files (netrw for example)
" so don't set them globally
if &modifiable
  " The encoding written to file
  set fileencoding=utf-8
  " Use unix line endings
  set fileformat=unix
  set fileformats=unix,mac,dos
endif

" > Always try to show a paragraph’s last line
set display+=lastline

" > Enable line wrapping
set wrap

" > Avoid wrapping a line in the middle of a word
set linebreak

" > The number of screen lines to keep above and below the cursor
set scrolloff=1

" > The number of screen columns to keep to the left and right of the cursor
set sidescrolloff=5

" > Show 'invisible' characters
" ▶ ◀ » « › ‹ ◥ ❮ ❯ ↪ ↲ ⏎ ¶ ␣ ⎵ • ×
" ★ ‡ § │ ⍿ ¤ → ← … ░ ⣿ ▓ ░ ␠ ○ ⦸
set showbreak=↪\
set list
set listchars=eol:↲
set listchars+=extends:…
set listchars+=nbsp:␣
set listchars+=precedes:…
set listchars+=space:⎵
set listchars+=tab:⍿\ " Preserved whitepsace
set listchars+=trail:×

" > Show @@@ in the last line if it is truncated.
set display=truncate

" > 'syntax enable' will keep your current color settings
" This allows using ":highlight" commands
" to set your preferred colors before or after using this command
" If you want Vim to overrule your settings with the defaults,
" use 'syntax on'
syntax enable
syntax on

" }}}

" ------------------------------------------------- "
" BACKUP/SAFEGUARD {{{
" ------------------------------------------------- "

" > Create directories if not exist yet
if !isdirectory("~/.vim/backup")
  call mkdir ($HOME."/.vim/backup", "p")
endif
if !isdirectory("~/.vim/swap")
  call mkdir ($HOME."/.vim/swap", "p")
endif

" > Put the undo directory to the /tmp folder
" as it’s subject to system level cleanups
if !isdirectory("/tmp/.vim/undo")
  call mkdir("/tmp/.vim/undo", "p", 0700)
endif

" > Make vim put swap, backup and undo files defined locations
" instead of the working directory of the file being edited
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undodir=/tmp/.vim/undo//

" > Use persistent history
set undofile

" > Increase history (default = 20)
set history=999

" > More undo (default=100)
set undolevels=999

" > Display a confirmation dialog when closing an unsaved file
set confirm

" }}}

" ------------------------------------------------- "
" KEY MAPPINGS {{{
" ------------------------------------------------- "

" > Remap bad habits to do nothing
imap <Up>    <Nop>
imap <Down>  <Nop>
imap <Left>  <Nop>
imap <Right> <Nop>
nmap <Up>    <Nop>
nmap <Down>  <Nop>
nmap <Left>  <Nop>
nmap <Right> <Nop>
nmap <S-s>   <Nop>
nmap >>      <Nop>
nmap <<      <Nop>
vmap >>      <Nop>
vmap <<      <Nop>
map  $       <Nop>
map  ^       <Nop>
map  {       <Nop>
map  }       <Nop>
" Comment out due to using zsh's fancy-ctrl-z
" Use Ctrl-Z to switch back and forth between Vim and zsh
" map <C-z>    <Nop>
map <C-s>    <Nop>

" > <ESC> is very far away, use (jk) for it
inoremap jk <Esc>
inoremap jk <Esc>
xnoremap jk <Esc>
tnoremap jk <Esc>
cnoremap jk <C-c>

" > qq to record, <Leader>Q to replay
nnoremap <Leader>Q @q

" > Conveniently turn 'paste' on and off with one keypress
" set paste   -> Turn on aid in pasting text unmodified
" set nopaste -> Turn off aid in pasting text unmodified
" set pastetoggle=<F2>

" > Use tab and shift tab to indent and de-indent code
nnoremap <Tab>   >>
nnoremap <S-Tab> <<
vnoremap <Tab>   >><Esc>gv
vnoremap <S-Tab> <<<Esc>gv
inoremap <S-Tab> <C-d>

" > When pairing some braces or quotes, put cursor between them
inoremap <> <><Left>
inoremap () ()<Left>
inoremap {} {}<Left>
inoremap [] []<Left>
inoremap "" ""<Left>
inoremap '' ''<Left>
inoremap `` ``<Left>

" > Save using <C-s> in every mode
" When in operator-pending or insert, takes you to normal mode
nnoremap <C-s> :write<Cr>
vnoremap <C-s> <C-c>:write<Cr>
inoremap <C-s> <Esc>:write<Cr>
onoremap <C-s> <Esc>:write<Cr>

" > Easier one-off navigation in insert mode
inoremap <C-k> <Up>
inoremap <C-j> <Down>
inoremap <C-h> <Left>
inoremap <C-l> <Right>
inoremap <C-^> <C-o><C-^>

" > Easier one-off navigation in command mode
cnoremap <C-k> <Up>
cnoremap <C-j> <Down>
cnoremap <C-h> <Left>
cnoremap <C-l> <Right>

" > Easier one-off navigation in insert mode
inoremap <A-k> <Up>
inoremap <A-j> <Down>
inoremap <A-h> <Left>
inoremap <A-l> <Right>

" > Easier one-off navigation in command mode
cnoremap <A-k> <Up>
cnoremap <A-j> <Down>
cnoremap <A-h> <Left>
cnoremap <A-l> <Right>

" > Easier moving between splits, saving a keypress
" > Easier moving between splits, saving a keypress
" Use ctrl-[hjkl] to select the active split
nmap <silent> <C-k> :wincmd k<CR>
nmap <silent> <C-j> :wincmd j<CR>
nmap <silent> <C-h> :wincmd h<CR>
nmap <silent> <C-l> :wincmd l<CR>

" > Easier moving between buffers
map <Leader>n <esc>:bn<CR>
map <Leader>p <esc>:bp<CR>

" > [c]lose [a]ll buffers but this one
map <Leader>ca :%bd\|e#\|bd#<CR>

" > Movement by screen line instead of file line (for text wrap)
nnoremap j gj
nnoremap k gk

" > Move to beginning/end of line
nnoremap B ^
nnoremap E $

" Bash-like keys for the command line
cnoremap <C-a> <Home>
cnoremap <C-e> <End>

" > Duplicate lines, similar to Eclipse
noremap <C-S-Up>   YP
noremap <C-S-Down> YP

" > Visually selects the block of characters
" which were added last time in INSERT mode
nnoremap gV `[v`]

" > Prevent x from overriding what's in the clipboard.
noremap x "_x
noremap X "_x

" > Prevent selecting and pasting from overwriting what you originally copied.
xnoremap p pgvy

" > Keep cursor at the bottom of the visual selection after you yank it.
vmap y ygv<Esc>

" > Clear search (space space)
nnoremap <silent> <Leader><Space> :let @/=""<CR>

" > Make Y behave like other capitals
nnoremap Y y$

" > Don't use Ex mode, use Q for formatting.
map Q gq

" > CTRL-U in insert mode deletes a lot.
" Use CTRL-G u to first break undo, so that
" you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" > Format paragraph (selected or not) to 80 character lines.
nnoremap <Leader>g gqap
xnoremap <Leader>g gqa

" > Toggle show “[i]nvisible” [c]haracters
nnoremap <Leader>ic :set nolist!<CR>

" > Move windows around (only works on same row)
noremap <C-S-Right> <C-w>r
noremap <C-S-Left>  <C-w>R

" > Toggle [s]pell [c]heckingss
nnoremap <leader>sc :setlocal spell!<CR>

" > Copy the path of the current file to the clipboard
" Relative path
" :let @+ = expand("%")
" Full path
" :let @+ = expand("%:p")
" Just filename
" :let @+ = expand("%:t")
nmap <Leader>cp :let @+=expand("%:p")<CR>

" > Quickly new splits
nnoremap <leader>ss :new<CR>
nnoremap <leader>vv :vnew<CR>

" > File explorer
nnoremap <F2> :Vexplore<CR>
nnoremap <F3> :Vexplore .<CR>

" }}}

" ------------------------------------------------- "
" INDENTATION AND TEXT-WRAP {{{
" ------------------------------------------------- "

" ====================
" Use indentation without tabs:
"  'expandtab', 'shiftwidth', 'softtabstop' to the same value
"  while leaving 'tabstop' at its default value
" ====================

" > Automatic formating
set formatoptions=tcqrn1

" > Don't start new lines with comment leader
" on pressing 'o'
set formatoptions-=o
set textwidth=79
set wrapmargin=0

" > Highligh long lines
set colorcolumn=+2

" > Indent using {n} spaces
set tabstop=4

" > When shifting, indent using {n} spaces
set shiftwidth=2

" > Affects what happens when pressing the <TAB> or <BS> keys
set softtabstop=2

" > Convert tabs to spaces
set expandtab

" > When shifting lines, round the indentation
" to the nearest multiple of 'shiftwidth'
set shiftround

" > Insert “tabstop” number of spaces when the “tab” key is pressed
set smarttab

" > New lines inherit the indentation of previous lines
set autoindent smartindent

" > Every wrapped line will continue visually indented
set breakindent

" > Copy previous indentation on auto indent
set copyindent

" > For Mutt email client
au BufRead /tmp/mutt-* set tw=72
au BufRead /tmp/mutt-* setlocal fo+=aw

" }}}

" ------------------------------------------------- "
" PERFORMANCE/BUFFERS {{{
" ------------------------------------------------- "

" > Allow leaving buffers without saving
set hidden

" > Send more characters for redraws
set ttyfast

" > Don’t update screen during macro and script execution
set lazyredraw

" }}}

" ------------------------------------------------- "
" netrw {{{
" ------------------------------------------------- "

" > <Ctrl-^> should go to the last file, not to netrw
let g:netrw_altfile = 1
" > The tree list view in netrw
let g:netrw_liststyle = 3
" > Removing the banner
let g:netrw_banner = 0
" > How files are opened
" 0 - open files in current tab
" 1 - open files in a new horizontal split
" 2 - open files in a new vertical split
" 3 - open files in a new tab
" 4 - open in previous window
let g:netrw_browse_split = 0

" }}}

" ------------------------------------------------- "
" AUTO-COMPLETE {{{
" ------------------------------------------------- "

" > Visual Auto-complete for command menu
set wildmenu

" > Auto-complete is getting much better :e <tab>...
set wildchar=<Tab> wildmenu wildmode=full
set wildignore=*.o,*.obj,*.bak,*.exe,*.swp,*.pdf,*.docx,*.xlsx,*.png

" > Better Completion
" . -> Scan the current buffer
" w -> Scan buffers from other windows
" b -> Scan buffers from the buffer list
" u -> Scan buffers that have been unloaded from the buffer list
" t -> Tag completion
" i -> Scan the current and included files
set complete=.,w,b,u,t,i

" > Turn on word completion by spelling
set complete+=k

" > Popup menu doesn't select the first completion item
" it inserts the longest common text of all matches
" and the menu will come up even if there's only one match
set completeopt=longest,menuone

" }}}

" ------------------------------------------------- "
" USER INTERFACE {{{
" ------------------------------------------------- "

" > Show the filename in the window titlebar
set title
set titleold="Terminal"
set titlestring=%F

" > Show the (partial) command as it’s being typed
set showcmd
set cmdheight=2

" > No need to use showmode due to using custom statusline
set noshowmode

" > Always show status line
set laststatus=2

" > Show line numbers
set number

" > Show the cursor position
set ruler

" > Set Highlight current line
set cursorline
" Only show the cursor line in the active buffer.
augroup CursorLine
  au!
  au VimEnter,WinEnter,BufWinEnter * setlocal cursorline
  au WinLeave * setlocal nocursorline
augroup END

" > Different Cursor types for each mode
" Cursor settings:
"  1 -> blinking block
"  2 -> solid block
"  3 -> blinking underscore
"  4 -> solid underscore
"  5 -> blinking vertical bar
"  6 -> solid vertical bar
" Mode settings:
"  &t_SI -> INSERT mode
"  &t_SR -> REPLACE mode
"  &t_EI -> NORMAL mode (ELSE)
if exists('$TMUX')
  let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>[1 q\<Esc>\\"
  let &t_SR = "\<Esc>Ptmux;\<Esc>\<Esc>[1 q\<Esc>\\"
  let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>[2 q\<Esc>\\"
else
  let &t_SI = "\<Esc>[1 q"
  let &t_SR = "\<Esc>[1 q"
  let &t_EI = "\<Esc>[2 q"
endif

set t_Co=256
set background=dark

if empty('$TMUX')
  if (has("nvim"))
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
endif

if exists('+termguicolors')
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  set termguicolors
endif

" > Force transparent background
" highlight Normal ctermbg=NONE guibg=NONE

" }}}

" ------------------------------------------------- "
" SEARCH {{{
" ------------------------------------------------- "

" > Shows the match while typing
set incsearch

" > Highlight found searches
set hlsearch

" > Search case insensitive...
set ignorecase

" > ... but not when search pattern contains upper case characters
set smartcase
set showmatch

" > Switch to ripgrep for vim file searching
" Requires: RipGrep
" https://github.com/BurntSushi/ripgrep
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m
endif

" }}}

" ------------------------------------------------- "
" FOLDING {{{
" ------------------------------------------------- "

" ====================
" Default Shortcuts:
" zM -> Close all folds
" zR -> Open all folds
" zA
" zm -> Close by level
" zr -> Open by level
" za
" ====================

" > Enable folding
set foldenable

" > Open most folds by default
set foldlevelstart=10

" > {n} nested fold max
set foldnestmax=10

" > Fold methods: syntax, indent, marker
set foldmethod=syntax

" > Remove the never-ending dashes
set fillchars=fold:\  " Preserve whitespace

" > It's not possible to have two active foldmethods at the same time
" Use a toggle to switch between 'syntax' and 'marker'
function! s:ToggleFold()
  if &foldmethod == 'marker'
    let &l:foldmethod = 'syntax'
  else
    let &l:foldmethod = 'marker'
  endif
  echo 'foldmethod is now ' . &l:foldmethod
endfunction
nmap <Leader>ff :call <SID>ToggleFold()<CR>

" }}}

" ------------------------------------------------- "
" TERMINAL {{{
" ------------------------------------------------- "

" ====================
" (:term[inal]):
" Alt+t: opens 20 rows height split with terminal
" at the bottom, and minimizes it if it already open
" ====================
if has('nvim')
  let s:term_buf = 0
  let s:term_win = 0
  function! TermToggle(height)
    if win_gotoid(s:term_win)
      hide
    else
      new terminal
      exec "resize ".a:height
      try
        exec "buffer ".s:term_buf
        exec "bd terminal"
      catch
        call termopen($SHELL, {"detach": 0})
        let s:term_buf = bufnr("")
        setlocal nonu nornu scl=no nocul
      endtry
      startinsert!
      let s:term_win = win_getid()
    endif
  endfunction
  " > Toggle terminal on/off (neovim)
  nnoremap <silent> <A-t> :call TermToggle(20)<CR>
  inoremap <silent> <A-t> <Esc>:call TermToggle(20)<CR>
  tnoremap <silent> <A-t> <C-\><C-n>:call TermToggle(20)<CR>
  " > Close Terminai directly
  tnoremap <silent> <A-q> <C-\><C-n>:q!<CR>
endif

" > Focus on the buffer running Terminal
tnoremap <Esc> <C-\><C-n>

" > Easier moving between splits in Terminals
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
tnoremap <C-h> <C-\><C-n><C-w>h

" > Let you change a word and then to change
" the next occurrence of it by pressing "."
nnoremap <leader>x *``cgn

" }}}

" ------------------------------------------------- "
" FUNCTIONS/HELPERS {{{
" ------------------------------------------------- "

" > Toggle [c]onceal [l]evel
function! ToggleConceal()
  if &conceallevel == 0
    setlocal conceallevel=2
  else
    setlocal conceallevel=0
  endif
endfunction
command! ToggleConceal :call ToggleConceal()
nnoremap <leader>cl :ToggleConceal<CR>

" > [t]rim all trailing [w]hitespaces while preserve cursor position
" A simple non-preserve cursor position solution:
" nnoremap <leader>ss :%s/\s\+$//<cr>:let @/=''<CR>
function! TrimWhitespace(line1,line2)
  let l:save_cursor = getpos(".")
  silent! execute ':' . a:line1 . ',' . a:line2 . 's/\\\@<!\s\+$//'
  call setpos('.', l:save_cursor)
endfunction
command! -range=% TrimWhitespace call TrimWhitespace(<line1>,<line2>)
nnoremap <leader>tw :TrimWhitespace<CR>

" > Wipe out inactive buffers (:Wipe)
function! WipeOut()
  let tablist = []
  for i in range(tabpagenr('$'))
    call extend(tablist, tabpagebuflist(i + 1))
  endfor
  let nWipeouts = 0
  for i in range(1, bufnr('$'))
    if bufexists(i) && !getbufvar(i,"&mod") && index(tablist, i) == -1
      silent exec 'bwipeout' i
      let nWipeouts = nWipeouts + 1
    endif
  endfor
  echomsg nWipeouts . ' buffer(s) wiped out'
endfunction
command! Wipe :call WipeOut()

" > Toggle between number and [r]elative[n]umber
function! ToggleNumber()
  if(&relativenumber == 1)
    set norelativenumber
    set number
  else
    set relativenumber
  endif
endfunction
nnoremap <leader>rn :call ToggleNumber()<CR>

" > Close pane using <C-w> just like in the browsers
" As I don't use the <C-w> mappings anyway
function! CloseBuffer()
  if &ft !=? 'netrw' | bdelete | endif
endfunction
nnoremap <silent> <C-w> :call CloseBuffer()<Cr>

" > Automatically set/unset Vim's paste mode when you paste
" Bracketed Paste Mode
if has('patch-8.0.0238')
  if &term =~ "screen"
    let &t_BE = "\e[?2004h"
    let &t_BD = "\e[?2004l"
    exec "set t_PS=\e[200~"
    exec "set t_PE=\e[201~"
  endif
else
  if has('patch-8.0.0210')
    set t_BE=
  endif

  if &term =~ "xterm" || &term =~ "screen"
    function XTermPasteBegin(ret)
      set paste
      set pastetoggle=<Esc>[201~
      return a:ret
    endfunction

    let &t_ti .= "\e[?2004h"
    let &t_te .= "\e[?2004l"

    noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
    inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
    vnoremap <special> <expr> <Esc>[200~ XTermPasteBegin("c")
    cnoremap <special> <Esc>[200~ <nop>
    cnoremap <special> <Esc>[201~ <nop>
  endif
endif

" }}}

" ------------------------------------------------- "
" AUTO-CMD {{{
" ------------------------------------------------- "
if has("autocmd")
  " > Treat .json files as .js
  autocmd BufNewFile,BufRead *.json setfiletype json syntax=javascript

  " > Automatically deletes all trailing whitespace on save.
  autocmd BufWritePre * %s/\s\+$//e

  " > When vimrc is edited, reload it
  autocmd! bufwritepost .vimrc source ~/.vimrc

  " > Make panes resize when host window is resized
  autocmd VimResized * wincmd =
endif

augroup vimStartup
  autocmd!
  " > When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid, when inside an event handler
  autocmd BufReadPost *
    \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
    \ |   exe "normal! g`\""
    \ | endif
augroup END

"}}}
