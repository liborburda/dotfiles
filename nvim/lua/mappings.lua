-- better movements
vim.api.nvim_set_keymap('n', 'j', 'gj', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'k', 'gk', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<c-h>', '<c-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<c-j>', '<c-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<c-k>', '<c-w>k', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<c-l>', '<c-w>l', { noremap = true, silent = true })

-- indent block and get back to visual mode
vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true, silent = true })

-- clipboard
vim.api.nvim_set_keymap('v', '<Leader>y', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>p', '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>P', '"+P', { noremap = true, silent = true })

-- telescope
vim.api.nvim_set_keymap('n', '<Leader>ff', '<cmd>Telescope find_files<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fg', '<cmd>Telescope live_grep<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fb', '<cmd>Telescope buffers<cr>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<Leader>fh', '<cmd>Telescope help_tags<cr>', { noremap = true, silent = true })

-- other plugins
vim.api.nvim_set_keymap('n', '<F2>', ':NERDTreeToggle<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<F5>', ':UndotreeToggle<CR>', { noremap = true, silent = true })
