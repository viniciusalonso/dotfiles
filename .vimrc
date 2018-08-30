call plug#begin('~/.vim/plugged')
  Plug 'scrooloose/nerdtree'
  Plug 'Xuyuanp/nerdtree-git-plugin'
  Plug 'junegunn/fzf'
  Plug 'dyng/ctrlsf.vim'
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-commentary'
  Plug 'bling/vim-airline'
  Plug 'valloric/youcompleteme'
  Plug 'ntpeters/vim-better-whitespace'
  Plug 'majutsushi/tagbar'
  Plug 'rhysd/open-pdf.vim'
  Plug 'tmhedberg/matchit'
  Plug 'godlygeek/tabular'
  Plug 'plasticboy/vim-markdown'
  Plug 'mileszs/ack.vim'
  Plug 'tpope/vim-dispatch'             "| Optional
  Plug 'tpope/vim-projectionist'        "|
  Plug 'ncm2/ncm2'  "|
  Plug 'noahfrederick/vim-composer'     "|
  Plug 'noahfrederick/vim-laravel'
  Plug 'kana/vim-textobj-user'
  Plug 'airblade/vim-gitgutter'
  Plug 'Yggdroot/indentLine'
  Plug 'w0rp/ale'
  Plug 'jiangmiao/auto-pairs'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'sheerun/vim-polyglot'
call plug#end()

syntax on
colorscheme onedark

set number
set tabstop=4
set expandtab
set shiftwidth=4
set autoindent
set hlsearch
set novisualbell
set cursorline
set splitbelow
set nobackup
set wildmenu
set wildmode=full

let g:indentLine_setColors = 1
let g:ale_completion_enabled = 1
let g:vue_disable_pre_processors = 1

autocmd FileType vue syntax sync fromstart

map <c-p> <ESC>:FZF<CR>
map <SPACE><SPACE> <ESC>:w<CR>
noremap <C-c> <ESC>:q!<CR>
map <c-r> <ESC>:NERDTreeFind<CR>
map <c-Left> gT
map <c-Right> gt
map <c-T> <ESC>:tabnew<CR>
map <C-l>  <ESC>:NERDTreeToggle<CR>
map mm <ESC>:noh<CR>
map <c-k> <ESC>:TagbarToggle<CR>

noremap <Up> <NOP>
noremap <Down> <NOP>
noremap <Left> <NOP>
noremap <Right> <NOP>

nmap ]h <Plug>GitGutterNextHunk
nmap [h <Plug>GitGutterPrevHunk

imap <Up> <NOP>
imap <Down> <NOP>
imap <Left> <NOP>
imap <Right> <NOP>

call textobj#user#plugin('line', {
\   '-': {
\     'select-a-function': 'CurrentLineA',
\     'select-a': 'al',
\     'select-i-function': 'CurrentLineI',
\     'select-i': 'il',
\   },
\ })

function! CurrentLineA()
    normal! 0
    let head_pos = getpos('.')
    normal! $
    let tail_pos = getpos('.')
    return ['v', head_pos, tail_pos]
endfunction

function! CurrentLineI()
    normal! ^
    let head_pos = getpos('.')
    normal! g_
    let tail_pos = getpos('.')
    let non_blank_char_exists_p = getline('.')[head_pos[2] - 1] !~# '\s'
    return
                \ non_blank_char_exists_p
                \ ? ['v', head_pos, tail_pos]
                \ : 0
endfunction
