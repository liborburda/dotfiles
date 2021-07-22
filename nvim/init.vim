syntax on
filetype plugin on

set incsearch
set hlsearch
set ignorecase
set smartcase
set showmatch

"set updatetime=100

set title
set nocompatible
set showmode

set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround

set backspace=indent,eol,start
set hidden

" disable auto line breaking
set nowrap

set undofile
set history=500
set undolevels=500

set number
set relativenumber

set scrolloff=5
set signcolumn=yes

set encoding=utf-8
set fileencoding=utf-8

set mouse=
set clipboard=unnamedplus

set cursorline
"set cursorcolumn
set colorcolumn=80

set tags=./tags;/

set laststatus=2

set listchars=tab:>-,trail:.,precedes:<,extends:>,eol:$

" Disable cursor styling in neovim
set guicursor=a:blinkon0

call plug#begin('~/.config/nvim/plugged')
    Plug 'preservim/nerdtree'
    Plug 'mbbill/undotree'
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    Plug 'sheerun/vim-polyglot'

    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'

    Plug 'neovim/nvim-lspconfig'
    Plug 'hrsh7th/nvim-compe'

    Plug 'morhetz/gruvbox'
call plug#end()

"""""""""""""""""""""""""
" Theme + colors        "
"""""""""""""""""""""""""
"set termguicolors
set background=dark
let g:gruvbox_termcolors=256
"let g:gruvbox_contrast_dark="hard"
colorscheme gruvbox

" Show trailing whitepace and spaces before a tab
highlight ExtraWhitespace ctermbg=darkred guibg=#880000
match ExtraWhitespace /\s\+$\| \+\ze\t/

"""""""""""""""""""""""""""""
" Terminal                  "
"""""""""""""""""""""""""""""
let s:term_buf = 0
let s:term_win = 0

function! TermToggle(height)
    if win_gotoid(s:term_win)
        hide
    else
        new terminal
        exec "resize ".a:height
        try
            exec "buffer ".s:term_buf
            exec "bd terminal"
        catch
            call termopen($SHELL, {"detach": 0})
            let s:term_buf = bufnr("")
            setlocal nonu nornu scl=no nocul
        endtry
        startinsert!
        let s:term_win = win_getid()
    endif
endfunction

nnoremap <silent><F8> :call TermToggle(12)<CR>
inoremap <silent><F8> <Esc>:call TermToggle(12)<CR>
tnoremap <silent><F8> <C-\><C-n>:call TermToggle(12)<CR>

"""""""""""""""""""""""""""""
" Fugitive                  "
"""""""""""""""""""""""""""""
" Autoclean buffers
autocmd BufReadPost fugitive://* set bufhidden=delete

"""""""""""""""""""""""""""""
" Keyboard mapping          "
"""""""""""""""""""""""""""""
let mapleader=" "

map <F2> :NERDTreeToggle<CR>
set pastetoggle=<F4>
map <F5> :UndotreeToggle<CR>

noremap j gj
noremap k gk
"noremap <C-m> gt
"noremap <C-n> gT
nnoremap <C-l> <C-w>l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k

" indent block and get back to visual mode
vnoremap < <gv
vnoremap > >gv

" clipboard
vnoremap <Leader>y "+y
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P

" terminal
tnoremap <Esc> <c-\><c-n>

" Fugitive
nnoremap <Leader>gs  :G<CR>
nnoremap <Leader>gl  :Gclog!<CR>
nnoremap <Leader>gd  :Gvdiffsplit!<CR>
nnoremap <Leader>gcc :Gcommit<CR>
nnoremap <Leader>gca :Gcommit --amend<CR>
nnoremap <Leader>gco :Git checkout<Space>
nnoremap <Leader>gb  :Gblame<CR>
nnoremap <Leader>ge  :Gedit %<CR>
nnoremap <Leader>gE  :Gedit<Space>
nnoremap <Leader>gr  :Gread<CR>
nnoremap <Leader>gR  :Gread<Space>
nnoremap <Leader>gw  :Gwrite<CR>
nnoremap <Leader>gW  :Gwrite!<CR>
nnoremap <Leader>gp  :Git pull<CR>
nnoremap <Leader>gP  :Git push -u origin HEAD<CR>
nnoremap <Leader>gq  :Gwq<CR>
nnoremap <Leader>gQ  :Gwq!<CR>
nnoremap <Leader>g+  :Git stash push<CR>
nnoremap <Leader>g-  :Git stash pop<CR>

"""""""""""""""""""""""""""""""
" Git-gutter                  "
"""""""""""""""""""""""""""""""
nnoremap <Leader>ghs :GitGutterStageHunk<CR>
nnoremap <Leader>ghu :GitGutterUndoHunk<CR>
nnoremap <Leader>ghp :GitGutterPreviewHunk<CR>

"""""""""""""""""""""""""""""""
" Compe                       "
"""""""""""""""""""""""""""""""
set completeopt=menuone,noselect

let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'disable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:true

"""""""""""""""""""""""""""""""
" LSP                         "
"""""""""""""""""""""""""""""""
lua << EOF
require'lspconfig'.gopls.setup{}
require'lspconfig'.jedi_language_server.setup{}
require'lspconfig'.bashls.setup{}
EOF

"""""""""""""""""""""""""""""""
" Telescope                   "
"""""""""""""""""""""""""""""""
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

