" vim: set foldmethod=marker foldlevel=0 nomodeline:
" ================================================= "
" VIM SETTINGS                                      "
" ================================================= "

" > Use Vim settings, rather than Vi settings
set nocompatible

" > Enable file type detection, use the default filetype settings
" so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc...
filetype plugin indent on

" > Set <Leader> key for using extra key combinations
let mapleader      = ' '
let maplocalleader = ' '

" > Load Plugins
if !empty(glob('~/dotfiles/vim/plugins.vim'))
  source ~/dotfiles/vim/plugins.vim
endif

" > Load Base Settings
if !empty(glob('~/dotfiles/vim/base.vim'))
  source ~/dotfiles/vim/base.vim
endif
