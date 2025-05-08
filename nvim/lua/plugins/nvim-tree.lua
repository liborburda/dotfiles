return {
  {
    "nvim-tree/nvim-web-devicons"
  },
  {
    "nvim-tree/nvim-tree.lua",
    config = function()
      local nvim_tree = require('nvim-tree')
      nvim_tree.setup({
        hijack_cursor = true,
        git = {
          enable = false,
        },
        view = {
          width = 50,
          signcolumn = "no",
        },
        renderer = {
          indent_markers = {
            enable = true,
          },
          icons = {
            show = {
              folder_arrow = false,
            },
          },
        },
        -- update_focused_file = {
        --   enable = true,
        -- }
      })

      -- vim.keymap.set('n', '<F2>', [[<cmd>NvimTreeToggle<CR>]], { noremap = true, silent = true })
      vim.keymap.set("n", "<leader>n", function()
          nvim_tree_api = require("nvim-tree.api")
          if nvim_tree_api.tree.is_visible() then
            nvim_tree_api.tree.close()
          else
            nvim_tree_api.tree.find_file({open = true, focus = true})
          end
        end,
        { noremap = true, silent = true }
      )
    end,
  }
}
