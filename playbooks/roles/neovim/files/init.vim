""" Vim-Plug
call plug#begin()

Plug 'ggandor/lightspeed.nvim'
Plug 'morhetz/gruvbox'

call plug#end()

""" Disable default x and d behavior.
nnoremap x "_x
nnoremap d "_d
nnoremap D "_D
vnoremap d "_d

nnoremap <leader>d ""d
nnoremap <leader>D ""D
vnoremap <leader>d ""d

" https://github.com/vscode-neovim/vscode-neovim/pull/868#issuecomment-1131963354
" https://github.com/vscode-neovim/vscode-neovim/issues/804#issuecomment-1188595664
hi LightspeedCursor gui=reverse

let mapleader= ","
let g:mapleader = ","


if exists('g:vscode')
else
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
endif

""" System clipboard
set clipboard+=unnamedplus

""" Other keybindings
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa
