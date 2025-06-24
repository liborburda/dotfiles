return {
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local null_ls = require("null-ls")
      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.terraform_fmt,
          null_ls.builtins.formatting.gofmt,
          null_ls.builtins.formatting.goimports,
          null_ls.builtins.formatting.black.with({
            extra_args = {"--line-length", "120"},
          }),
        },
      })

      vim.keymap.set("n", "<leader>gf", vim.lsp.buf.format, {})
    end,
  },

  {
    "jay-babu/mason-null-ls.nvim",
    dependencies = {"williamboman/mason.nvim", 'nvimtools/none-ls.nvim'},
    config = function()
      local mason_null_ls = require("mason-null-ls")
      mason_null_ls.setup({
        ensure_installed = {
          'goimports',
          'black',
          'terraformls',
          'lua-language-server',
          'yaml-language-server',
        }
      })
    end,
  },
}
