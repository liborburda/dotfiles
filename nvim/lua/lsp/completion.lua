local lspconfig = require 'lspconfig'
local cmp = require 'cmp'
-- local luasnip = require 'luasnip'

-- define capabilities for language servers
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.preselectSupport = true
capabilities.textDocument.completion.completionItem.insertReplaceSupport = true
capabilities.textDocument.completion.completionItem.labelDetailsSupport = true
capabilities.textDocument.completion.completionItem.deprecatedSupport = true
capabilities.textDocument.completion.completionItem.commitCharactersSupport = true
capabilities.textDocument.completion.completionItem.tagSupport = {
  valueSet = { 1 },
}
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = { 'documentation', 'detail', 'additionalTextEdits' },
}

vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(
	vim.lsp.diagnostic.on_publish_diagnostics,
	{ virtual_text = true, signs = true, update_in_insert = true }
)

-- individually configure all language servers
lspconfig.bashls.setup {
  cmd = { "bash-language-server", "start" },
  filetypes = { "sh", "bash", "zsh" },
}

lspconfig.terraformls.setup {
  cmd = { "terraform-ls", "serve" },
  filetypes = { "terraform" },
}

lspconfig.gopls.setup {}
lspconfig.pyright.setup {}
lspconfig.clangd.setup {}

-- setup nvim-cmp for completion
cmp.setup {
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
  },

  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    -- { name = 'calc' },
  },

  documentation = {
    border = "single"
  },
}

-- bindings for non-completion related LSP features
vim.api.nvim_set_keymap('n', ']d', 'vim.lsp.diagnostic.goto_next', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[d', 'vim.lsp.diagnostic.goto_prev', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gD', 'vim.lsp.buf.declaration', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gd', 'vim.lsp.buf.definition', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gr', 'vim.lsp.buf.references', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gs', 'vim.lsp.buf.signature_help', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>af', 'vim.lsp.buf.code_action', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gi', 'vim.lsp.buf.implementation', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'gt', 'vim.lsp.buf.type_definition', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>rn', 'vim.lsp.buf.rename', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>f', 'vim.lsp.buf.formatting', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'H', 'vim.lsp.diagnostic.show_line_diagnostics', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', 'L', 'vim.lsp.buf.hover', { noremap = true, silent = true })
