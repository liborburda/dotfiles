return {
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
    config = function()
      local flash = require("flash")
      flash.setup({
        modes = {
          search = {
            enabled = false
          },
        }
      })

      -- vim.keymap.set('n', '<leader>t', function () require("flash").treesitter() end, { noremap = true, silent = true })
      vim.keymap.set('n', 's', function() require("flash").jump() end, {noremap = true, silent = true })
      vim.keymap.set('x', 's', function() require("flash").jump() end, {noremap = true, silent = true })
      vim.keymap.set('o', 's', function() require("flash").jump() end, {noremap = true, silent = true })
      vim.keymap.set('n', 'S', function() require("flash").treesitter() end, {noremap = true, silent = true })
      vim.keymap.set('x', 'S', function() require("flash").treesitter() end, {noremap = true, silent = true })
      vim.keymap.set('o', 'S', function() require("flash").treesitter() end, {noremap = true, silent = true })
    end,
  }
}
