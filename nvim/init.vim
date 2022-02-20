syntax on
filetype plugin on

set incsearch
set hlsearch
set ignorecase
set smartcase
set showmatch

set title
set nocompatible
set noshowmode

set expandtab
set tabstop=2
set softtabstop=2
set shiftwidth=2
set shiftround
set autoindent
set smartindent
set smarttab

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
set colorcolumn=80

set tags=./tags;/

set laststatus=2

set listchars=tab:>-,trail:.,precedes:<,extends:>,eol:$

" Disable cursor styling in neovim
set guicursor=a:blinkon0

let mapleader = " "

call plug#begin('~/.config/nvim/plugged')
    "Plug 'preservim/nerdtree'
    Plug 'mbbill/undotree'
    Plug 'tpope/vim-fugitive'
    Plug 'airblade/vim-gitgutter'
    "Plug 'sheerun/vim-polyglot'
    "Plug 'ntpeters/vim-better-whitespace'
    "Plug 'editorconfig/editorconfig-vim'
    Plug 'hashivim/vim-terraform'
    "Plug 'itchyny/lightline.vim'
    Plug 'nvim-lualine/lualine.nvim'
    Plug 'kyazdani42/nvim-web-devicons'
    "Plug 'jiangmiao/auto-pairs'
    Plug 'neoclide/coc.nvim', {'branch': 'master', 'do': 'yarn install --frozen-lockfile'}
    "Plug 'dense-analysis/ale'
    Plug 'nvim-lua/popup.nvim'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'nvim-telescope/telescope.nvim'
    "Plug 'morhetz/gruvbox'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    "Plug 'gruvbox-community/gruvbox'
    Plug 'Mofiqul/vscode.nvim'
    Plug 'kyazdani42/nvim-tree.lua'
call plug#end()

"""""""""""""""""""""""""""""
" TreeSitter                "
"""""""""""""""""""""""""""""
lua require('nvim-treesitter.configs').setup { highlight = { enable = true }, incremental_selection = { enable = true }, textobjects = { enable = true }}

"""""""""""""""""""""""""""""
" NvimTree                  "
"""""""""""""""""""""""""""""
lua require('nvim-tree').setup()

"""""""""""""""""""""""""""""
" Lualine                   "
"""""""""""""""""""""""""""""
lua require('lualine').setup { options = { theme = 'vscode', section_separators = '', component_separators = '' } }

"""""""""""""""""""""""""
" Theme + colors        "
"""""""""""""""""""""""""
"set termguicolors
"set background=dark
"let g:gruvbox_termcolors=256
"let g:gruvbox_contrast_dark="hard"
let g:vscode_style = "dark"
set background=dark
colorscheme vscode

"""""""""""""""""""""""""""""
" Lightline                 "
"""""""""""""""""""""""""""""
"let g:lightline = {
"        \ 'colorscheme': 'wombat',
"        \ 'active': {
"        \     'left': [ [ 'mode', 'paste' ],
"        \             [ 'readonly', 'filename', 'gitbranch', 'modified' ] ]
"        \ },
"        \ 'component_function': {
"        \     'gitbranch': 'FugitiveHead'
"        \ },
"        \ }
"
"""""""""""""""""""""""""""""
" ALE                       "
"""""""""""""""""""""""""""""
"let g:ale_disable_lsp = 1
"let g:ale_sign_column_always = 1
"let g:airline#extensions#ale#enabled = 1

"""""""""""""""""""""""""""""
" Terraform                 "
"""""""""""""""""""""""""""""
let g:hcl_align = 1
let g:terraform_fmt_on_save = 1

"""""""""""""""""""""""""
" coc                   "
"""""""""""""""""""""""""
"let g:coc_global_extensions = [
"            \ 'coc-go',
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

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nnoremap <silent> [g <Plug>(coc-diagnostic-prev)
nnoremap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nnoremap <Leader>cd <Plug>(coc-definition)
nnoremap <Leader>cy <Plug>(coc-type-definition)
nnoremap <Leader>ci <Plug>(coc-implementation)
nnoremap <Leader>cr <Plug>(coc-references)
" Symbol renaming.
nmap <Leader>cn <Plug>(coc-rename)
" CocAction
nnoremap <Leader>ca :CocAction<CR>
" Formatting selected code.
xnoremap <Leader>cf <Plug>(coc-format-selected)
nnoremap <Leader>cf <Plug>(coc-format-selected)

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap <C-f> and <C-b> for scroll float windows/popups.
nnoremap <expr><C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <expr><C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <expr><C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<Right>"
inoremap <expr><C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<Left>"

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
" EditorConfig              "
"""""""""""""""""""""""""""""
"let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

"""""""""""""""""""""""""""""
" Keyboard mapping          "
"""""""""""""""""""""""""""""
map <F2> :NvimTreeToggle<CR>
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
" Telescope                   "
"""""""""""""""""""""""""""""""
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

"""""""""""""""""""""""""""""""
" Misc                        "
"""""""""""""""""""""""""""""""
" Close all buffers except current one
command BufOnly silent! execute "%bd|e#|bd#"

" When editing a file, always jump to the last cursor position
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif

