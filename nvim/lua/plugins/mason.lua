return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = function()
      require("mason").setup()
    end,
  },

  {
    "williamboman/mason-lspconfig.nvim",
    lazy = false,
     tag = "v1.32.0",
    opts = {
      auto_install = true,
    },
    config = function()
      local mason_lspconfig = require("mason-lspconfig")

      mason_lspconfig.setup({
        ensure_installed = {
          "clangd",
          "pyright",
          "terraformls",
          "bashls",
          "gopls",
          "ansiblels",
        }
      })
    end,
  },
}
