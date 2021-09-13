-- space bar is leader key
vim.g.mapleader = ' '

-- quicker update
vim.opt.updatetime = 100

-- don't wrap lines
vim.opt.wrap = false

-- 2 character wide tab for indentation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 2
vim.opt.autoindent = true
vim.opt.expandtab = true

-- buffers
vim.opt.hidden = true		-- buffer switching without saving

-- search options
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.showmatch = true
vim.opt.wrapscan = false

-- ui
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = 'yes'
vim.opt.termguicolors = true
vim.opt.colorcolumn = {80}
vim.cmd('colorscheme gruvbox')
vim.opt.guicursor = 'a:blinkon0'

-- navigation
vim.opt.scrolloff = 5
vim.opt.sidescrolloff = 5

-- copy and paste with OS clipboard
vim.opt.clipboard = 'unnamedplus'

-- completion style
vim.opt.completeopt = 'menuone,noselect'

-- undo & history
vim.opt.undofile = true
vim.opt.undolevels = 500
vim.opt.history = 500

-- whitespace characters
vim.opt.listchars =
	'tab:→ ,space:·,nbsp:␣,trail:•,eol:¶,precedes:«,extends:»'

