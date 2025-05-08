--Remap space as leader key
vim.keymap.set('', '<space>', '<nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Split window
vim.keymap.set('n', '<c-l>', '<c-w>l', { noremap = true, silent = true })
vim.keymap.set('n', '<c-h>', '<c-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<c-j>', '<c-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<c-k>', '<c-w>k', { noremap = true, silent = true })

-- Unset the default, this is configured by nvim-cmp
vim.keymap.set('i', '<c-n>', '<nop>', {})
vim.keymap.set('i', '<c-p>', '<nop>', {})

-- indent block and get back to visual mode
vim.keymap.set('v', '<', '<gv', { noremap = true, silent = true })
vim.keymap.set('v', '>', '>gv', { noremap = true, silent = true })

-- clipboard
vim.keymap.set('v', '<leader>y', '"+y', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>p', '"+p', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>P', '"+P', { noremap = true, silent = true })

-- terminal
vim.keymap.set('t', '<esc>', '<c-\\><c-n>', { noremap = true, silent = true })

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
