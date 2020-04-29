" vim: set foldmethod=marker foldlevel=0 nomodeline:
" ================================================= "
" NEOVIM SETTINGS                                   "
" ================================================= "

" > Add the existing paths and ~/.vimrc file from vim to nvim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath=&runtimepath
source ~/.vimrc
