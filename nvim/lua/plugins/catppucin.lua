return {
  {
    "catppuccin/nvim",
    lazy = false,
    name = "catppuccin",
    priority = 1000,
    config = function()
      local catppuccin = require("catppuccin")
      catppuccin.setup({
          flavour = "macchiato",

          integrations = {
              cmp = true,
              gitsigns = true,
              nvimtree = true,
              treesitter = true,
              notify = false,
              mini = {
                  enabled = true,
                  indentscope_color = "",
              },
          }
      })

      vim.cmd.colorscheme "catppuccin"
    end
  }
}
