" language options
set langmenu=en_US
let $LANG='en_US.UTF-8'

set nocompatible

" Auto save auto read set autoread
set autowrite


filetype indent on
set autoindent
set smartindent

" Enable folding
set foldmethod=syntax
set foldlevel=2
set foldnestmax=10
set foldenable

set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4


set hlsearch
set incsearch
set smartcase
set ignorecase

set lazyredraw
set display+=lastline
set linebreak

set encoding=utf-8
"set term=screen-256color

syntax enable
set ruler
set number

set backspace=indent,eol,start

set backup
set backupdir=~/.cache/vim/backup/
set undodir=~/.cache/vim/undo/
set directory=~/.cache/vim/swap/

set hidden
set history=1000

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
 
Plugin 'sickill/vim-pasta'
Plugin 'VundleVim/Vundle.vim'
Plugin 'neoclide/coc.nvim', {'do': { -> coc#util#install()}}
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
Plugin 'sillybun/vim-repl'
Plugin 'junegunn/fzf', { 'do': { -> fzf#install() } }

call vundle#end()

set background=dark
let g:gruvbox_termcolors=256
colorscheme gruvbox

let g:highlightedyank_highlight_duration = 500

" ===================
" airline config
" ===================

let g:airline_powerline_fonts = 1
"let g:airline_section_z = '%t'

filetype plugin on
packadd! matchit

"key mappings
let mapleader = ' '

" Fuzzy Finder
nnoremap <leader>F :FZF<CR>

let g:fzf_preview_window = ['right:50%', 'ctrl-/']

" Fix with ALE
"nnoremap <leader>A :ALELint<CR> :ALEFix<CR>

nnoremap <leader>h <C-w>h <CR>
nnoremap <leader>j <C-w>j <CR>
nnoremap <leader>k <C-w>k <CR>
nnoremap <leader>l <C-w>l <CR>

nnoremap <C-k> O<Esc>
nnoremap <C-j> o<Esc>k

" set up fugitive
nnoremap <leader>gs :Git<CR>

"set copy/paste easier
vmap <leader>y "*y
nmap <leader>p "*p
nmap <leader>u :UndotreeToggle <CR>

nmap <leader>pv :NERDTreeToggle<CR>

nmap <Esc><Esc> :noh<CR>

if has("persistent_undo")
    set undodir="$HOME/.undodir"
    set undofile
endif

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
\       'pylint'
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

" ======================
" coc configs (for c++)
" ======================
set signcolumn=yes
set updatetime=300

set nobackup
set nowritebackup

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-z> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[c` and `]c` to navigate diagnostics
nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
nnoremap <leader>fa  :call CocAction('format')<cr>

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use <tab> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <TAB> <Plug>(coc-range-select)
xmap <silent> <S-TAB> <Plug>(coc-range-select-backword)

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols

" ======================
"python settings 
" ======================

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

au BufNewFile,BufRead *.css
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2

" c++ settings
au BufNewFile,BufRead *.cpp
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set expandtab |
    \ set autoindent

" yml settings
au BufNewFile,BufRead *.yml, *.yaml
    \ set tabstop=2 |
    \ set softtabstop=2 |
    \ set shiftwidth=2
