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

set nobackup
set nowritebackup
set noswapfile

set number
" set relativenumber

set undofile
set undodir=~/.vim/tmp/undo//
set history=200
set undolevels=200

set encoding=utf-8
set fileencoding=utf-8

"set mouse=n
set clipboard=unnamed

set cursorline
" set cursorcolumn
set colorcolumn=80

set wildmenu
set wildmode=list:longest,full

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

"""""""""""""""""""""""
" dont set <leader> to ",", otherwise ,b mapped to CtrlP will be delayed due to
" mapping <leader>bug
"""""""""""""""""""""""

" <Tab> settings for Makefiles
autocmd FileType make set noexpandtab shiftwidth=8 softtabstop=0
autocmd FileType yaml set autoindent tabstop=2 shiftwidth=2 expandtab
autocmd FileType yml set autoindent tabstop=2 shiftwidth=2 expandtab

colorscheme base16-tomorrow-night
set background=dark
"let base16colorspace=256


call plug#begin('~/.vim/plugged')
    Plug 'ctrlpvim/ctrlp.vim'
    Plug 'scrooloose/nerdtree'
    Plug 'jistr/vim-nerdtree-tabs'
    Plug 'sjl/gundo.vim'
    Plug 'majutsushi/tagbar'
    Plug 'dhruvasagar/vim-table-mode'

    Plug 'prabirshrestha/async.vim'
    Plug 'prabirshrestha/vim-lsp'
    Plug 'prabirshrestha/asyncomplete.vim'
    Plug 'prabirshrestha/asyncomplete-lsp.vim'
    Plug 'prabirshrestha/asyncomplete-buffer.vim'
    Plug 'prabirshrestha/asyncomplete-file.vim'
"    Plug 'yami-beta/asyncomplete-omni.vim'
"    Plug 'prabirshrestha/asyncomplete-tags.vim'
"    Plug 'ludovicchabant/vim-gutentags'
"
call plug#end()

" enable using regexp in ctrlp
let g:ctrlp_regexp=1


let g:asyncomplete_auto_popup = 1
let g:asyncomplete_popup_delay = 5

let g:asyncomplete_remove_duplicates = 1
let g:asyncomplete_smart_completion = 1
"let g:asyncomplete_log = '/home/libor/asyncomplete.log'

"call asyncomplete#register_source(asyncomplete#sources#omni#get_source_options({
"    \ 'name': 'omni',
"    \ 'whitelist': ['*'],
"    \ 'blacklist': ['c', 'cpp', 'html'],
"    \ 'completor': function('asyncomplete#sources#omni#completor')
"    \  }))

call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'whitelist': ['*'],
    \ 'blacklist': ['go', 'c', 'cpp', 'python'],
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ 'config': {
    \    'max_buffer_size': 5000000,
    \  },
    \ }))

call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'whitelist': ['*'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#file#completor')
    \ }))

"call asyncomplete#register_source(asyncomplete#sources#tags#get_source_options({
"    \ 'name': 'tags',
"    \ 'whitelist': ['c'],
"    \ 'completor': function('asyncomplete#sources#tags#completor'),
"    \ 'config': {
"    \    'max_file_size': 50000000,
"    \  },
"    \ }))

if executable('gopls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'gopls',
        \ 'cmd': {server_info->['gopls', '-mode', 'stdio']},
        \ 'whitelist': ['go'],
        \ })
    autocmd BufWritePre *.go LspDocumentFormatSync
endif

if executable('pyls')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'whitelist': ['python'],
        \ })
endif

if executable('clangd')
    au User lsp_setup call lsp#register_server({
        \ 'name': 'clangd',
        \ 'cmd': {server_info->['clangd', '-background-index']},
        \ 'whitelist': ['c', 'cpp', 'objc', 'objcpp'],
        \ })
endif

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
noremap <C-m> gt
noremap <C-n> gT
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k

" indent block and get back to visual mode
vnoremap < <gv
vnoremap > >gv

inoremap {<CR> {<CR>}<Esc>ko

" clipboard
vnoremap  <leader>y  "+y
nnoremap  <leader>y  "+y

nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

