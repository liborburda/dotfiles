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

      vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
        vim.lsp.handlers['signature_help'], {
          border = 'rounded',
          close_events = {"CursorMoved", "BufHidden", "InsertCharPre"},
        }
      )

      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "<leader>gd", vim.lsp.buf.definition, {})
      vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation, {})
      vim.keymap.set("n", "<leader>gr", vim.lsp.buf.references, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})
      vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
      vim.keymap.set('i', '<c-s>',      vim.lsp.buf.signature_help, {})
      vim.keymap.set('n', '<c-s>',      vim.lsp.buf.signature_help, {})
    end,
  },
}
