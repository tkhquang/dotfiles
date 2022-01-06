" vim: set foldmethod=marker foldlevel=0 nomodeline:
" ================================================= "
" PLUGINS                                           "
" ================================================= "

" > Automatic installation for vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

silent! if plug#begin('~/.vim/plugged')

Plug 'sheerun/vim-polyglot'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" ------------------------------------------------- "
" junegunn/fzf.vim {{{
" ------------------------------------------------- "

" > Open in a floating or popup window
if has("nvim-0.4.0") || has("patch-8.2.0191")
  let g:fzf_layout = {
    \ 'window': {
    \   'width': 0.9,
    \   'height': 0.7,
    \   'highlight': 'Comment',
    \   'rounded': v:false
    \ } }
else
  let g:fzf_layout = {
    \   'window': 'silent botright 16split enew'
    \ }
endif

" > Escape inside a FZF terminal window should exit the terminal window
" rather than going into the terminal's normal mode
if has("nvim")
  autocmd FileType fzf tnoremap <buffer> <Esc> <Esc>
endif

let g:fzf_colors = {
  \ 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment']
  \ }

let g:fzf_action = {
  \ 'ctrl-s': 'split',
  \ 'ctrl-v': 'vsplit'
  \ }

" > Open the fuzzy finder just for the directory
" containing the currently edited file (Sibling files)
nnoremap <silent> <Leader>. :Files <C-r>=expand("%:h")<CR>/<CR>

" > Open the nearest outter .git project directory
function! s:fzf_root()
  let path = finddir(".git", expand("%:p:h").";")
  return fnamemodify(substitute(path, ".git", "", ""), ":p:h")
endfunction
nnoremap <silent> <C-p> :exe 'Files ' . <SID>fzf_root()<CR>

nnoremap <Leader>rg :Rg<Space>

" }}}

Plug 'neoclide/coc.nvim', {'branch': 'release'}
" ------------------------------------------------- "
" neoclide/coc.nvim {{{
" ------------------------------------------------- "

let g:coc_global_extensions = [
    \ 'coc-git',
    \ 'coc-json',
    \ 'coc-html',
    \ 'coc-emmet',
    \ 'coc-css',
    \ 'coc-python',
    \ 'coc-tsserver',
    \ 'coc-prettier',
    \ 'coc-eslint',
    \ 'coc-styled-components'
  \]
" if isdirectory('./node_modules') && isdirectory('./node_modules/prettier')
"   let g:coc_global_extensions += ['coc-prettier']
" endif

" if isdirectory('./node_modules') && isdirectory('./node_modules/eslint')
"   let g:coc_global_extensions += ['coc-eslint']
" endif

" > Use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction
inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" > Use <cr> to confirm completion,
" <C-g>u means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" > Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" > Add `:Fold` command to fold current buffer.
command! -nargs=? Fold   :call CocAction('fold', <f-args>)

" > Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR     :call CocAction('runCommand', 'editor.action.organizeImport')

nmap <Leader>F :Format<CR>

" }}}

Plug 'dense-analysis/ale'
" ------------------------------------------------- "
" dense-analysis/ale {{{
" ------------------------------------------------- "

let g:ale_linters = {
\  'css':        ['csslint'],
\  'javascript': ['prettier', 'eslint'],
\  'javascriptreact': ['prettier', 'eslint'],
\  'typescript': ['prettier', 'eslint'],
\  'typescriptreact': ['prettier', 'eslint'],
\  'json':       ['jsonlint'],
\  'ruby':       ['standardrb'],
\  'scss':       ['sasslint'],
\  'yaml':       ['yamllint']
\}

let g:ale_fixers = {
\  'css':        ['prettier'],
\  'javascript': ['prettier', 'eslint'],
\  'javascriptreact': ['prettier', 'eslint'],
\  'typescript': ['prettier', 'eslint'],
\  'typescriptreact': ['prettier', 'eslint'],
\  'json':       ['prettier'],
\  'ruby':       ['standardrb'],
\  'scss':       ['prettier'],
\  'yml':        ['prettier']
\}

let g:ale_sign_error = '✗\ '
let g:ale_sign_warning = '⚠\ '

let g:ale_linters_explicit = 1
let g:ale_open_list        = 1

let g:ale_lint_on_enter            = 0
let g:ale_lint_on_filetype_changed = 0
let g:ale_lint_on_insert_leave     = 0
let g:ale_lint_on_save             = 1
let g:ale_lint_on_text_changed     = 'never'

nmap <Leader>aL    <Plug>(ale_lint)
nmap <Leader>aF    <Plug>(ale_fix)
nmap <Leader><BS> <Plug>(ale_reset_buffer)

" }}}

Plug 'tpope/vim-fugitive'
" ------------------------------------------------- "
" tpope/vim-fugitive {{{
" ------------------------------------------------- "

let g:fzf_commits_log_options = '--graph --color=always
  \ --format="%C(yellow)%h%C(red)%d%C(reset)
  \ - %C(bold green)(%ar)%C(reset) %s %C(blue)<%an>%C(reset)"'
set diffopt+=vertical
nnoremap <silent> <Leader>b  :Git blame<CR>
nnoremap <silent> <Leader>d  :Gdiff<CR>
nnoremap <silent> <Leader>c  :Commits<CR>
nnoremap <silent> <Leader>bc :BCommits<CR>

" }}}

Plug 'airblade/vim-gitgutter'
" ------------------------------------------------- "
" airblade/vim-gitgutter {{{
" ------------------------------------------------- "

let g:gitgutter_override_sign_column_highlight = 0
let g:gitgutter_sign_added                     = '┃'
let g:gitgutter_sign_modified                  = '┃'
let g:gitgutter_sign_removed                   = '┃'
let g:gitgutter_sign_removed_first_line        = '┃'
let g:gitgutter_sign_modified_removed          = '┃'

" }}}

Plug 'lambdalisue/vim-manpager'
Plug 'lambdalisue/vim-pager'
Plug 'powerman/vim-plugin-AnsiEsc'

Plug 'luochen1990/rainbow'
" ------------------------------------------------- "
" luochen1990/rainbow {{{
" ------------------------------------------------- "

let g:rainbow_active = 1

" }}}

Plug 'Yggdroot/indentLine'
" ------------------------------------------------- "
" Yggdroot/indentLine {{{
" ------------------------------------------------- "

let g:indentLine_faster = 1
let g:indentLine_first_char = '┊'
let g:indentLine_char = '┊'
let g:indentLine_showFirstIndentLevel = 1

autocmd! User indentLine doautocmd indentLine Syntax

" }}}

Plug 'mbbill/undotree'
" ------------------------------------------------- "
" mbbill/undotree {{{
" ------------------------------------------------- "

" > Toggle Undo Tree
nnoremap <Leader>u :UndotreeToggle<cr>
" > Map (:earlier) and  (:later) to F9 and F10
nnoremap <F9> g-
nnoremap <F10> g+

" }}}

Plug 'tpope/vim-unimpaired'
" ------------------------------------------------- "
" tpope/vim-unimpaired {{{
" ------------------------------------------------- "

" > Bubble single line, similar to Eclipse
nmap <C-Up>   [e
nmap <C-Down> ]e

" > Bubble multiple lines, similar to Eclipse
vmap <C-Up>   [egv
vmap <C-Down> ]egv

" }}}

Plug 'christoomey/vim-tmux-navigator'
Plug 'preservim/nerdtree'
" ------------------------------------------------- "
" preservim/nerdtree {{{
" ------------------------------------------------- "

let NERDTreeShowHidden = 1
let NERDTreeIgnore = [
  \ '\.DS_Store$',
  \ '\.pyc$',
  \ '__pycache__',
  \ '.git$'
  \ ]

" > Automatically delete the buffer of the file you just deleted with NerdTree
let NERDTreeAutoDeleteBuffer = 1

" > Automatically close NerdTree on file open
let NERDTreeQuitOnOpen = 1

" > Making it prettier
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" > Don't open NerdTree on Netrw
let g:NERDTreeHijackNetrw=0

" > Automatically close a tab if the only remaining window is NerdTree
autocmd bufenter *
  \ if (winnr("$") == 1
  \ && exists("b:NERDTree")
  \ && b:NERDTree.isTabTree())
  \ | q |
  \ endif

map <C-n> :NERDTreeToggle<CR>

" }}}

Plug 'mattn/emmet-vim'
" ------------------------------------------------- "
" mattn/emmet-vim {{{
" ------------------------------------------------- "

" > Make emmet behave well with JSX in JS and TS files
let g:user_emmet_settings = {
\  'javascript' : {
\      'extends' : 'jsx',
\  },
\  'typescript' : {
\      'extends' : 'tsx',
\  },
\}

" }}}

Plug 'lambdalisue/suda.vim'
" ------------------------------------------------- "
" lambdalisue/suda.vim {{{
" ------------------------------------------------- "

" > Allow saving of files as sudo
" when I forgot to start Vim using sudo (:w!!)
cmap w!! w suda://%<CR>

" }}}

Plug 'ryanoasis/vim-devicons'
" ------------------------------------------------- "
" ryanoasis/vim-devicons {{{
" ------------------------------------------------- "

" }}}

Plug 'sgur/vim-editorconfig'

Plug 'drewtempelmeyer/palenight.vim'
" ------------------------------------------------- "
" drewtempelmeyer/palenight.vim {{{
" ------------------------------------------------- "

let g:palenight_terminal_italics = 1

" }}}
Plug 'joshdick/onedark.vim'
" ------------------------------------------------- "
" joshdick/onedark.vim {{{
" ------------------------------------------------- "

let g:onedark_terminal_italics = 1

" > Customize individual aspects of existing highlight groups
" overriding only the keys provided
if (has("autocmd"))
  augroup colorextend
    autocmd!
    " Make `Function`s bold in GUI mode
    autocmd ColorScheme * call onedark#extend_highlight("Function", { "gui": "bold" })
  augroup END
endif

" > Allows to completely redefine/override highlight groups
if (has("autocmd") && !has("gui_running"))
  augroup colorset
    autocmd!
    " > Force transparent background
    autocmd ColorScheme *
      \ call onedark#set_highlight("Normal", {
      \ "fg": {
      \   "gui": "#ABB2BF", "cterm": "145", "cterm16" : "7"
      \ } })
    autocmd ColorScheme *
      \ call onedark#extend_highlight("NonText", {
      \ "fg": {
      \   "gui": "#626262", "cterm": "241", "cterm16" : "2"
      \ } })
  augroup END
endif

" }}}

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" ------------------------------------------------- "
" vim-airline/vim-airline {{{
" ------------------------------------------------- "

let g:airline_powerline_fonts = 1
let g:airline_theme='onedark'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#bufferline#enabled = 1
" let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
" let g:airline_right_sep = ''

" }}}

Plug 'tjdevries/overlength.vim'
" ------------------------------------------------- "
" tjdevries/overlength.vim {{{
" ------------------------------------------------- "

" > Highlight lines longer than `textwidth` size
let overlength#default_to_textwidth = &textwidth+2

" > Set to not enable by default
autocmd BufEnter * call overlength#disable()
autocmd BufWinEnter *.*{@@/*,} call overlength#enable()

" }}}

call plug#end()
endif

colorscheme onedark
