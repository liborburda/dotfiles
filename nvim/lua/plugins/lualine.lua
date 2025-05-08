return {
  {
    "nvim-lualine/lualine.nvim",  -- Fancier statusline
    config = function()
      local lualine = require('lualine')
      lualine.setup({
        options = {
          icons_enabled = false,
          theme = 'auto',
          component_separators = '',
          section_separators = '',
        },
        sections = {
          lualine_c = {
            {
              'filename',
              file_status = true, -- displays file status (readonly status, modified status)
              path = 1 -- 0 = just filename, 1 = relative path, 2 = absolute path
            }
          }
        },
      })
    end,
  }
}
