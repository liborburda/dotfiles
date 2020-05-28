syntax on
filetype plugin on

set incsearch
set hlsearch
set ignorecase
set smartcase
set showmatch

set title
set nocompatible 
set showmode

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set autoindent

set foldenable          " enable folding
set foldmethod=indent
set foldlevel=99
set backspace=indent,eol,start
set hidden

" disable auto line breaking
set wrap
set linebreak
set textwidth=0
set wrapmargin=0

set backupdir=~/.config/nvim/tmp/backup
set directory=~/.config/nvim/tmp/swap//
set undodir=~/.config/nvim/tmp/undo//
set history=200
set undolevels=200

set number
" set relativenumber

set encoding=utf-8
set fileencoding=utf-8

"set mouse=n
set clipboard=unnamed

set cursorline
" set cursorcolumn
set colorcolumn=80

"set wildmenu
"set wildmode=list:longest,full

set tags=./tags;/

set laststatus=2

set statusline=
set statusline=%F         " Path to the file
set statusline+=%=        " Switch to the right side
set statusline+=[%{strlen(&fenc)?&fenc:'none'}] "file encoding
set statusline+=[%l        " Current line
set statusline+=/         " Separator
set statusline+=%L]        " Total lines

set listchars=tab:>-,trail:.,precedes:<,extends:>,eol:$

" Disable cursor styling in neovim
set guicursor=a:blinkon0

"""""""""""""""""""""""
" dont set <leader> to ",", otherwise ,b mapped to CtrlP will be delayed due to
" mapping <leader>bug
"""""""""""""""""""""""

call plug#begin('~/.config/nvim/plugged')

    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'scrooloose/nerdtree'
    Plug 'jistr/vim-nerdtree-tabs'
    Plug 'sjl/gundo.vim'
    Plug 'majutsushi/tagbar'
    Plug 'dhruvasagar/vim-table-mode'
    Plug 'tpope/vim-fugitive'

"    Plug 'camspiers/animate.vim'
"    Plug 'camspiers/lens.vim'

    Plug 'neoclide/coc.nvim', {'branch': 'release'}

call plug#end()

" prefer python3 (Gundo uses python2.7 by default)
let g:gundo_prefer_python3 = 1

" enable using regexp in ctrlp
let g:ctrlp_regexp=1

" <Tab> settings for Makefiles
autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0
autocmd FileType yaml set autoindent tabstop=2 shiftwidth=2 expandtab
autocmd FileType yml set autoindent tabstop=2 shiftwidth=2 expandtab

let base16colorspace=256
set background=dark
colorscheme base16-tomorrow-night

map <F2> :NERDTreeToggle<CR>
map <F3> :NERDTreeFocusToggle<CR>
map <F4> :GundoToggle<CR>
map <F5> :TagbarToggle<CR>

" CtrlP config mapping
nnoremap ,f :CtrlP<CR>
nnoremap ,b :CtrlPBuffer<CR>
nnoremap ,t :CtrlPTag<CR>

noremap j gj
noremap k gk
"noremap <C-m> gt
"noremap <C-n> gT
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k

" indent block and get back to visual mode
vnoremap < <gv
vnoremap > >gv

inoremap {<CR> {<CR>}<Esc>ko

" clipboard
vnoremap  ,y  "+y
nnoremap  ,y  "+y

nnoremap ,p "+p
nnoremap ,P "+P
vnoremap ,p "+p
vnoremap ,P "+P

" terminal
tnoremap <Esc> <C-\><C-n>

"""""""""""""""""""""""""
" coc                   "
"                       "
"""""""""""""""""""""""""
set completeopt=noinsert,menuone,noselect

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <C-n>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<C-n>" :
      \ coc#refresh()

