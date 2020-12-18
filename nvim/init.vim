syntax on
filetype plugin on

set incsearch
set hlsearch
set ignorecase
set smartcase
set showmatch

set updatetime=100

set title
set nocompatible
set showmode

set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4
set shiftround
set autoindent

set backspace=indent,eol,start
set hidden

" disable auto line breaking
set nowrap

set undofile
set history=500
set undolevels=500

set number
set relativenumber

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

    Plug 'neoclide/coc.nvim', {'branch': 'release'}

    Plug 'morhetz/gruvbox'
call plug#end()

"""""""""""""""""""""""""
" Theme + colors        "
"""""""""""""""""""""""""
set termguicolors
set background=dark
let g:gruvbox_termcolors=256
colorscheme gruvbox

" Show trailing whitepace and spaces before a tab
highlight ExtraWhitespace ctermbg=darkred guibg=#880000
match ExtraWhitespace /\s\+$\| \+\ze\t/

"""""""""""""""""""""""""
" coc                   "
"""""""""""""""""""""""""
"let g:coc_global_extensions = [
"            \ 'coc-go',
"            \ 'coc-java',
"            \ 'coc-java-lombok',
"            \ 'coc-sh',
"            \ 'coc-json',
"            \ 'coc-yaml',
"            \ 'coc-python',
"            \ 'coc-clangd'
"            \ ]

set completeopt=noinsert,menuone,noselect

" Do not split words by dash (aka. word containing dash will be treated as one word
set iskeyword+=-

" use <tab> for trigger completion and navigate to the next complete item
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <C-n>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<C-n>" :
            \ coc#refresh()

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
map <F3> :NERDTreeFocusToggle<CR>
set pastetoggle=<F4>
map <F5> :UndotreeToggle<CR>

" Close buffer without closing split
nmap <Leader>q :ene<CR>:bd #<CR>

" fzf mapping
if executable('fzf')
    nnoremap <Leader>f :CocCommand fzf-preview.DirectoryFiles<CR>
    nnoremap <Leader>b :CocCommand fzf-preview.Buffers<CR>
    nnoremap <Leader>t :CocCommand fzf-preview.BufferTags<CR>
    nnoremap <Leader>m :CocCommand fzf-preview.Marks<CR>
    "nnoremap <Leader>fc :<CR>
    "nnoremap <Leader>fj :CocCommand fzf-preview.Jumps<CR>
end

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

inoremap {<CR> {<CR>}<Esc>ko

" clipboard
vnoremap <Leader>y "+y
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P

" terminal
tnoremap <Esc> <c-\><c-n>

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <Leader>cd <Plug>(coc-definition)
nmap <Leader>cy <Plug>(coc-type-definition)
nmap <Leader>ci <Plug>(coc-implementation)
nmap <Leader>cr <Plug>(coc-references)
" Symbol renaming.
nmap <Leader>cn <Plug>(coc-rename)
" CocAction
nmap <Leader>ca :CocAction<CR>
" Formatting selected code.
xmap <Leader>cf <Plug>(coc-format-selected)
nmap <Leader>cf <Plug>(coc-format-selected)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" CocSearch
nmap <Leader>cs :CocSearch<Space>

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap <C-f> and <C-b> for scroll float windows/popups.
nnoremap <expr><C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <expr><C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <expr><C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<Right>"
inoremap <expr><C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<Left>"

" Fugitive
function! ToggleGStatus()
    if buflisted(bufname('.git/index'))
        bd .git/index
    else
        Gstatus
    endif
endfunction
command! ToggleGStatus :call ToggleGStatus()

nnoremap _ :ToggleGStatus<CR>
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

