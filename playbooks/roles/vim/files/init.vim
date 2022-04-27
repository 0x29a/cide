""" Vim-Plug
call plug#begin()
if exists('g:vscode')
    " VSCode extension
    Plug 'asvetliakov/vim-easymotion'
else
    Plug 'morhetz/gruvbox'
    Plug 'preservim/nerdtree'
    Plug 'takac/vim-hardtime'
    Plug 'easymotion/vim-easymotion'
endif
call plug#end()

""" Disable default x and d behavior.
nnoremap x "_x
nnoremap d "_d
nnoremap D "_D
vnoremap d "_d

nnoremap <leader>d ""d
nnoremap <leader>D ""D
vnoremap <leader>d ""d

let mapleader= ","
let g:mapleader = ","

""" EasyMotion config
let g:EasyMotion_do_mapping = 0 " Disable default mappings

" Jump to anywhere you want with minimal keystrokes, with just one key binding.
" `s{char}{label}`
nmap f <Plug>(easymotion-bd-f)

" Turn on case-insensitive feature
let g:EasyMotion_smartcase = 1

" JK motions: Line motions
map <Leader>j <Plug>(easymotion-j)
map <Leader>k <Plug>(easymotion-k)

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

    " Start NERDTree and put the cursor back in the other window.
    autocmd VimEnter * NERDTree | wincmd p

    " Exit Vim if NERDTree is the only window remaining in the only tab.
    autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

    """ Hardtime
    let g:hardtime_default_on = 1
endif

""" System clipboard
set clipboard+=unnamedplus

""" Other keybindings
vmap <C-c> "+yi
vmap <C-x> "+c
vmap <C-v> c<ESC>"+p
imap <C-v> <ESC>"+pa
