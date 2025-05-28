return {
  { "hrsh7th/cmp-nvim-lsp" },
  { 'hrsh7th/cmp-buffer', },
  { 'hrsh7th/cmp-emoji' },
  { 'hrsh7th/cmp-path' },
  { 'hrsh7th/cmp-calc' },
  { 'hrsh7th/cmp-cmdline' },
  { 'hrsh7th/cmp-nvim-lsp' },
  --{ 'hrsh7th/cmp-nvim-lsp-signature-help' },
  { 'hrsh7th/cmp-nvim-lsp-document-symbol' },
  { 'SergioRibera/cmp-dotenv' },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
    --config = function()
    --  local luasnip = require("luasnip")

    --  vim.keymap.set({"i"}, "<C-K>", function() luasnip.expand() end, {silent = true})
    --  vim.keymap.set({"i", "s"}, "<Tab>", function() luasnip.jump( 1) end, {silent = true})
    --  vim.keymap.set({"i", "s"}, "<S-Tab>", function() luasnip.jump(-1) end, {silent = true})

    --  vim.keymap.set({"i", "s"}, "<C-E>", function()
    --    if luasnip.choice_active() then
    --      luasnip.change_choice(1)
    --    end
    --  end, {silent = true})
    --end,
  },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      local types = require("cmp.types") -- Required by gopls to make completeopt work correctly
      local luasnip = require("luasnip")
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        confirmation = {
          completeopt = 'menu,menuone,noselect'
        },
        preselect = types.cmp.PreselectMode.None,
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<CR>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              if luasnip.expandable() then
                luasnip.expand()
              else
                vim.api.nvim_input("<NL>")
              end
            else
              fallback()
            end
          end),

          ["<Tab>"] = cmp.mapping(function(fallback)
            if luasnip.locally_jumpable(1) then
              luasnip.jump(1)
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip.locally_jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          --["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          --["<CR>"] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = "luasnip" }, -- For luasnip users.
          { name = 'nvim_lsp' },
          { name = 'buffer',
            option = {
              get_bufnrs = function()
                return vim.api.nvim_list_bufs()
              end
            },
          },
          { name = 'path' },
          { name = 'nvim_lsp_signature_help' },
          { name = 'emoji', option = { insert = true } },
          { name = 'calc' },
          { name = 'dotenv' },
        }),
      })

      -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = 'path' },
          { name = 'cmdline' },
        })
      })

    end,
  },
}
