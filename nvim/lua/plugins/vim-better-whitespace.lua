return {
  {
    "ntpeters/vim-better-whitespace",
    config = function()
      vim.api.nvim_set_hl(0, "ExtraWhitespace", { bg = "#ed8796" })
    end
  }
}
