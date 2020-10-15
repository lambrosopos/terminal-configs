" language options
set langmenu=en_US
let $LANG='en_US.UTF-8'

set nocompatible
filetype off

" Enable folding
set foldmethod=indent
set foldlevel=99

set autoindent
set expandtab
set shiftwidth=4
set smarttab
set tabstop=4

set hlsearch
set incsearch
set smartcase
set ignorecase

set lazyredraw
set display+=lastline
set linebreak

set encoding=utf-8
set term=screen-256color

syntax enable
set ruler
set number

set foldmethod=indent
set backspace=indent,eol,start
set backupdir=~/.cache/vim
set dir=~/.cache/vim

set hidden
set history=1000

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
 
Plugin 'sickill/vim-pasta'
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-scripts/indentpython.vim'
Plugin 'preservim/nerdcommenter'
Plugin 'preservim/nerdtree'
Plugin 'morhetz/gruvbox'
Plugin 'vim-airline/vim-airline'
Plugin 'mbbill/undotree'
Plugin 'tpope/vim-fugitive'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'machakann/vim-highlightedyank'
"Plugin 'neoclide/coc.nvim', {'branch': 'release'}

call vundle#end()
filetype plugin indent on

set background=dark
let g:gruvbox_termcolors=256
colorscheme gruvbox

let g:highlightedyank_highlight_duration = 500

filetype plugin on

"key mappings
let mapleader = ' '

nnoremap <leader>h <C-w>h <CR>
nnoremap <leader>j <C-w>j <CR>
nnoremap <leader>k <C-w>k <CR>
nnoremap <leader>l <C-w>l <CR>

nnoremap <C-j> o<Esc>k
nnoremap <C-k> O<Esc>

"set pasting easier
nmap <leader>p "*p
nmap <leader>u :UndotreeToggle <CR>

nmap <leader>pv :NERDTreeToggle<CR>

nmap <Esc><Esc> :noh<CR>

if has("persistent_undo")
    set undodir=$HOME."/.undodir"
    set undofile
endif

"python settings 
au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

"highlight BadWhitespace ctermbg=gray guibg=darkgray
"au BufRead,BufNewFile *.py,*.pyw,*.c,*.h match BadWhitespace /\s\+$/

" js, html, css settings
 au BufNewFile,BufRead *.js, *.html, *.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2
