return{
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.5",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local telescope = require("telescope")
      telescope.setup({
        defaults = {
          preview = false,
          layout_config = {
            prompt_position = 'top',
          },
          sorting_strategy = 'ascending',
        },
      })

      local builtin = require("telescope.builtin")
      --Add leader shortcuts
      vim.keymap.set('n', '<leader>fb', builtin.buffers, { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>ff', builtin.find_files, { noremap = true, silent = true })
      --vim.keymap.set('n', '<leader>sb', builtin.current_buffer_fuzzy_find(), { noremap = true, silent = true })
      --vim.keymap.set('n', '<leader>sh', builtin.help_tags(), { noremap = true, silent = true })
      --vim.keymap.set('n', '<leader>st', builtin.tags(), { noremap = true, silent = true })
      --vim.keymap.set('n', '<leader>sd', builtin.grep_string(), { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>fg', builtin.live_grep, { noremap = true, silent = true })
      --vim.keymap.set('n', '<leader>so', builtin.tags{ only_current_buffer = true }, { noremap = true, silent = true })
      vim.keymap.set('n', '<leader><Space>', builtin.oldfiles, { noremap = true, silent = true })
      vim.keymap.set('n', '<leader>fd', builtin.diagnostics, { noremap = true, silent = true })
    end,
  }
}
