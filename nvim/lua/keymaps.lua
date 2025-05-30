--Remap space as leader key
vim.keymap.set('', '<space>', '<nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Split window
vim.keymap.set('n', '<C-l>', '<C-w>l', { noremap = true, silent = true })
vim.keymap.set('n', '<C-h>', '<C-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<C-j>', '<C-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<C-k>', '<C-w>k', { noremap = true, silent = true })

-- Unset the default, this is configured by nvim-cmp
vim.keymap.set('i', '<C-n>', '<nop>', {})
vim.keymap.set('i', '<C-p>', '<nop>', {})

-- indent block and get back to visual mode
vim.keymap.set('v', '<', '<gv', { noremap = true, silent = true })
vim.keymap.set('v', '>', '>gv', { noremap = true, silent = true })

-- clipboard
vim.keymap.set('v', '<leader>y', '"+y', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>p', '"+p', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>P', '"+P', { noremap = true, silent = true })

-- terminal
vim.keymap.set('t', '<esc>', '<C-\\><C-n>', { noremap = true, silent = true })
-- vim.keymap.set('t', 'jk', '<C-\\><C-n>', { buffer = 0 })
vim.keymap.set({'t', 'i'}, '<C-h>', '<C-\\><C-N><C-w>h', { silent = true })
--vim.keymap.set('t', '<C-h>', vim.cmd.wincmd("h"), { buffer = 0 })
vim.keymap.set('t', '<C-j>', '<C-\\><C-N><C-w>j', { silent = true })
vim.keymap.set('t', '<C-k>', '<C-\\><C-N><C-w>k', { silent = true })
vim.keymap.set('t', '<C-l>', '<C-\\><C-N><C-w>l', { silent = true })
-- I map these binds to both terminal and insert mode like:

-- Close all floating windows
vim.keymap.set('n', '<esc>',
  function ()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local config = vim.api.nvim_win_get_config(win)
      if config.relative ~= "" then
        vim.api.nvim_win_close(win, false)
      end
    end
  end,
  { noremap = true, silent = true }
)
