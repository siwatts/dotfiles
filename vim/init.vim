" Transitioning from Vim                                           *nvim-from-vim*

"1. To start the transition, create your |init.vim| (user config) file:

"    :call mkdir(stdpath('config'), 'p')
"    :exe 'edit '.stdpath('config').'/init.vim'

"2. Add these contents to the file:

set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc
