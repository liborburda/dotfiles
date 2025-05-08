return {
  {
    "neovim/nvim-lspconfig",
    lazy = false,
    dependencies = { "williamboman/mason.nvim", "williamboman/mason-lspconfig.nvim" },
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local mason_lspconfig = require("mason-lspconfig")
      local lspconfig = require("lspconfig")

      -- Enable all installed LSP servers
      mason_lspconfig.setup_handlers({
        function(server_name)
          lspconfig[server_name].setup {
            capabilities = capabilities,
          }
        end
      })

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<Leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set('n', '<Leader>gi', vim.lsp.buf.implementation, {})
      vim.keymap.set("n", "<Leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<Leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set('n', '<Leader>rn', vim.lsp.buf.rename, {})
    end,
  },
}
