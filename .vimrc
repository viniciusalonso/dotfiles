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
map <SPACE><SPACE> <ESC>:w<CR>
noremap <C-c> <ESC>:q!<CR>
map <c-r> <ESC>:NERDTreeFind<CR>
map <c-Left> gT
map <c-Right> gt
map <c-T> <ESC>:tabnew<CR>
