-- Diagnostic config
vim.diagnostic.config({
   -- Disable virtual_text
   virtual_text = false,
   float = {
     border = 'rounded'
   },
   update_in_insert = false,
})

-- Diagnostic keymaps
vim.keymap.set('n', '<Leader>e', function () vim.diagnostic.open_float() end, { noremap = true, silent = true })
-- vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
-- vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
-- vim.keymap.set('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', { noremap = true, silent = true })
