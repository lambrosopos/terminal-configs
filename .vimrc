" language options
set langmenu=en_US
let $LANG='en_US.UTF-8'

set nocompatible

" Auto save auto read
set autoread
set autowrite

" Enable folding
set foldmethod=indent
set foldlevel=99

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4

filetype indent on
set autoindent
set smartindent

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
Plugin 'mattn/emmet-vim'
Plugin 'tpope/vim-obsession'
Plugin 'dense-analysis/ale'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'prettier/vim-prettier', {
            \ 'do': 'yarn install',
            \ 'for': ['javascript', 'css', 'html', 'json']
            \ }
Plugin 'tpope/vim-surround'
Plugin 'adelarsq/vim-matchit'

call vundle#end()

set background=dark
let g:gruvbox_termcolors=256
colorscheme gruvbox

let g:highlightedyank_highlight_duration = 500

filetype plugin on
packadd! matchit

"key mappings
let mapleader = ' '

" Fix with ALE
nnoremap <leader>F :ALELint<CR> :ALEFix<CR>

nnoremap <leader>h <C-w>h <CR>
nnoremap <leader>j <C-w>j <CR>
nnoremap <leader>k <C-w>k <CR>
nnoremap <leader>l <C-w>l <CR>

nnoremap <C-k> O<Esc>
nnoremap <C-j> o<Esc>k

" set up fugitive
nnoremap <leader>gs :Git<CR>

" set up Ycm subcommands
nnoremap <leader>gd :YcmCompleter GoTo<CR>
nnoremap <leader>gi :YcmCompleter GetDoc<CR>

"set copy/paste easier
vmap <leader>y "*y
nmap <leader>p "*p
nmap <leader>u :UndotreeToggle <CR>

nmap <leader>pv :NERDTreeToggle<CR>

nmap <Esc><Esc> :noh<CR>

if has("persistent_undo")
    set undodir=$HOME."/.undodir"
    set undofile
endif

let g:ycm_autoclose_preview_window_after_insertion = 1

let g:ale_lint_on_insert_leave = 0
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_enter = 0
let g:ale_lint_on_save = 0
let g:ale_fix_on_save = 0


let g:ale_linters = {
\   'html':[
\       'tidy',
\       'prettier',
\       'html-beautify',
\    ],
\   'python':[
\       'flake8',
\       'pylint',
\       'pyright',
\   ]
\}

let g:ale_fixers = {
\   '*':[
\       'remove_trailing_lines',
\       'trim_whitespace'
\   ],
\   'html':[
\       'tidy',
\       'prettier',
\       'html-beautify',
\    ],
\   'python':[
\       'autopep8',
\       'black',
\       'isort',
\       'reorder-python-imports',
\       'yapf',
\    ]
\}

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
au BufNewFile,BufRead *.html setf html
   \ set tabstop=2 |
   \ set softtabstop=2 |
   \ set shiftwidth=2

au BufNewFile,BufRead *.js, *.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2
