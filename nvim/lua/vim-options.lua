--Set highlight on search
vim.o.hlsearch = true
vim.opt.showmatch = true

--Make line numbers default
vim.wo.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

--Set cursor shape to block; no blinking
vim.opt.guicursor = "a:blinkon0"

--Enable mouse mode
vim.o.mouse = ''

--Enable break indent
vim.o.breakindent = true
vim.wo.wrap = false

--Save undo history
vim.opt.undofile = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.opt.expandtab = true            -- Use spaces instead of tabs
vim.opt.shiftwidth = 2              -- Shift 4 spaces when tab
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.smartindent = true

--Decrease update time
vim.o.updatetime = 250
vim.opt.lazyredraw = true           -- Faster scrolling
vim.wo.signcolumn = 'yes'

--Enable background buffers
vim.opt.hidden = true

--Keep last 5 lines visible at the end of buffer
vim.opt.scrolloff = 5

--Use global status line
vim.opt.laststatus = 3

-- Disable swapfile
vim.opt.swapfile = false

-- Set maximum completion menu height
vim.o.pumheight = 15

-- filetype
vim.bo.filetype = 'on'

vim.filetype.add({
  extension = {
    tf = "terraform",
    tfvars = "terraform",
    tfstate = "json",
  },
})

vim.filetype.add({
  extension = {
    gotmpl = 'gotmpl',
  },
  pattern = {
    [".*/templates/.*%.tpl"] = "helm",
    [".*/templates/.*%.ya?ml"] = "helm",
    ["helmfile.*%.ya?ml"] = "helm",
  },
})
