return {
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local config = require("nvim-treesitter.configs")
      config.setup({
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        incremental_selection = { enable = true },
      })
    end
  }
}
