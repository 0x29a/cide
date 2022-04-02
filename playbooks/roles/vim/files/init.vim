""" Vim-Plug
call plug#begin()
Plug 'morhetz/gruvbox'
call plug#end()

""" Main
filetype plugin indent on
set tabstop=4 softtabstop=4 shiftwidth=4 expandtab smarttab autoindent
set incsearch ignorecase smartcase hlsearch
set wildmode=longest,list,full wildmenu
set ruler laststatus=2 showcmd showmode
set list listchars=trail:»,tab:»-
set fillchars+=vert:\ 
set wrap breakindent
set encoding=utf-8
set textwidth=0
set hidden
set number
set title

""" Coloring
syntax on
autocmd vimenter * ++nested colorscheme gruvbox
