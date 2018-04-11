call plug#begin('~/.vim/plugged')
  Plug 'scrooloose/nerdtree'
  Plug 'junegunn/fzf'
  Plug 'dyng/ctrlsf.vim'
call plug#end()

syntax on
colorscheme Light

set number
set tabstop=4
set expandtab
set shiftwidth=4
set autoindent
set hlsearch

map <c-p> <ESC>:FZF<CR>
