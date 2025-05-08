return {
  {
    "ray-x/lsp_signature.nvim",
    config = function()
      local lsp_signature = require("lsp_signature")
      lsp_signature.setup({
        bind = true,
        handler_opts = {
          border = "rounded"
        },
        hint_enable = false,
      })

      vim.keymap.set({ 'n' }, '<C-s>', lsp_signature.toggle_float_win, { silent = true, noremap = true, desc = 'toggle signature' })
      vim.keymap.set({ 'i' }, '<C-s>', lsp_signature.toggle_float_win, { silent = true, noremap = true, desc = 'toggle signature' })
    end,
  }
}
