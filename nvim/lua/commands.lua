-- Custom commands
-- Delete all buffers except the active one
vim.api.nvim_create_user_command('BufOnly', 'silent! execute "%bd|e#|bd#"', { nargs = 0 })
