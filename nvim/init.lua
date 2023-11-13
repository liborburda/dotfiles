local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- 'wbthomason/packer.nvim', -- Package manager
  'tpope/vim-fugitive', -- Git commands in nvim
  --use 'tpope/vim-rhubarb' -- Fugitive-companion to interact with github
  --use 'ludovicchabant/vim-gutentags' -- Automatic tags management

  -- UI to select things (files, grep results, open buffers...)
  { 'nvim-telescope/telescope.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' },

  -- Lualine
  'nvim-lualine/lualine.nvim',  -- Fancier statusline

  -- Add indentation guides even on blank lines
  'lukas-reineke/indent-blankline.nvim',

  -- Add git related info in the signs columns and popups
  -- 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' },

  -- Treesitter
  -- Highlight, edit, and navigate code using a fast incremental parsing library
  'nvim-treesitter/nvim-treesitter',
  -- Additional textobjects for treesitter
  'nvim-treesitter/nvim-treesitter-textobjects',

  -- Mason
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',
  'neovim/nvim-lspconfig', -- Collection of configurations for built-in LSP client
  'jose-elias-alvarez/null-ls.nvim', dependencies = { "nvim-lua/plenary.nvim" }, -- Support for linters and formatters

  -- LSP
  'hrsh7th/nvim-cmp', -- Autocompletion plugin
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/cmp-nvim-lsp',
  -- 'hrsh7th/cmp-nvim-lsp-signature-help',
  -- 'saadparwaiz1/cmp_luasnip'
  -- 'L3MON4D3/LuaSnip' } -- Snippets plugin

  "ray-x/lsp_signature.nvim",

  -- Coc.nvim
  -- { 'neoclide/coc.nvim', branch = 'release' },

  -- Nvim-tree
  'nvim-tree/nvim-web-devicons',
  'nvim-tree/nvim-tree.lua',

  -- Terraform
  'hashivim/vim-terraform',

  'catppuccin/nvim',

  'ntpeters/vim-better-whitespace',
})

--Set highlight on search
vim.o.hlsearch = true
vim.opt.showmatch = true

--Make line numbers default
vim.wo.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.colorcolumn = "80"

--Set cursor shape to block; no blinking
vim.cmd [[set guicursor=a:blinkon0]]

--Enable mouse mode
vim.o.mouse = ''

--Enable break indent
vim.o.breakindent = true
vim.wo.wrap = false

--Save undo history
vim.opt.undofile = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.opt.expandtab = true            -- Use spaces instead of tabs
vim.opt.shiftwidth = 2              -- Shift 4 spaces when tab
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.smartindent = true

--Decrease update time
vim.o.updatetime = 250
vim.opt.lazyredraw = true           -- Faster scrolling
vim.wo.signcolumn = 'yes'

--Enable background buffers
vim.opt.hidden = true

--Keep last 5 lines visible at the end of buffer
vim.opt.scrolloff = 5

--Use global status line
vim.opt.laststatus = 3

--Set colorscheme
--vim.o.termguicolors = true
--vim.g.vscode_style = "dark"
--vim.cmd [[colorscheme vscode]]
require("catppuccin").setup({
    flavour = "mocha",

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
vim.cmd [[colorscheme catppuccin]]

-- -- Coc
-- -- Autocomplete
-- function _G.check_back_space()
--     local col = vim.fn.col('.') - 1
--     return col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') ~= nil
-- end
-- 
-- local opts = {silent = true, noremap = true, expr = true, replace_keycodes = false}
-- vim.keymap.set("i", "<C-n>", 'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<C-n>" : coc#refresh()', opts)
-- -- vim.keymap.set("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)
-- 
-- -- Use `[g` and `]g` to navigate diagnostics
-- -- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
-- vim.keymap.set("n", "[g", "<Plug>(coc-diagnostic-prev)", {silent = true})
-- vim.keymap.set("n", "]g", "<Plug>(coc-diagnostic-next)", {silent = true})
-- 
-- -- GoTo code navigation
-- vim.keymap.set("n", "gd", "<Plug>(coc-definition)", {silent = true})
-- vim.keymap.set("n", "gy", "<Plug>(coc-type-definition)", {silent = true})
-- vim.keymap.set("n", "gi", "<Plug>(coc-implementation)", {silent = true})
-- vim.keymap.set("n", "gr", "<Plug>(coc-references)", {silent = true})
-- 
-- -- Use K to show documentation in preview window
-- function _G.show_docs()
--     local cw = vim.fn.expand('<cword>')
--     if vim.fn.index({'vim', 'help'}, vim.bo.filetype) >= 0 then
--         vim.api.nvim_command('h ' .. cw)
--     elseif vim.api.nvim_eval('coc#rpc#ready()') then
--         vim.fn.CocActionAsync('doHover')
--     else
--         vim.api.nvim_command('!' .. vim.o.keywordprg .. ' ' .. cw)
--     end
-- end
-- vim.keymap.set("n", "K", '<CMD>lua _G.show_docs()<CR>', {silent = true})
-- 
-- -- Symbol renaming
-- vim.keymap.set("n", "<leader>rn", "<Plug>(coc-rename)", {silent = true})
-- 
-- -- Highlight the symbol and its references on a CursorHold event(cursor is idle)
-- vim.api.nvim_create_augroup("CocGroup", {})
-- vim.api.nvim_create_autocmd("CursorHold", {
--     group = "CocGroup",
--     command = "silent call CocActionAsync('highlight')",
--     desc = "Highlight symbol under cursor on CursorHold"
-- })
-- 
-- 
-- -- Set completeopt to have a better completion experience
-- vim.o.completeopt = 'menuone,noselect' -- For Coc.nvim
-- 
-- -- Don't auto commenting new lines
-- vim.cmd [[au BufEnter * set fo-=c fo-=r fo-=o]]

--Set statusbar
require('lualine').setup {
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
}

--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Highlight on yank
vim.cmd [[
  augroup YankHighlight
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup end
]]

-- Nvim-tree
require('nvim-tree').setup {
  git = {
    enable = false,
  },
  view = {
    width = 30,
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
}

-- Keyboard mapping
vim.api.nvim_set_keymap('n', '<c-l>', '<c-w>l', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<c-h>', '<c-w>h', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<c-j>', '<c-w>j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<c-k>', '<c-w>k', { noremap = true, silent = true })

vim.api.nvim_set_keymap('i', '<c-n>', '<nop>', {})
vim.api.nvim_set_keymap('i', '<c-p>', '<nop>', {})

-- indent block and get back to visual mode
vim.api.nvim_set_keymap('v', '<', '<gv', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', '>', '>gv', { noremap = true, silent = true })

-- clipboard
vim.api.nvim_set_keymap('v', '<leader>y', '"+y', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>p', '"+p', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>P', '"+P', { noremap = true, silent = true })

-- terminal
vim.api.nvim_set_keymap('t', '<esc>', '<c-\\><c-n>', { noremap = true, silent = true })

-- Fugitive
--nnoremap <Leader>gs  :G<CR>
--nnoremap <Leader>gl  :Gclog!<CR>
--nnoremap <Leader>gd  :Gvdiffsplit!<CR>
--nnoremap <Leader>gcc :Gcommit<CR>
--nnoremap <Leader>gca :Gcommit --amend<CR>
--nnoremap <Leader>gco :Git checkout<Space>
--nnoremap <Leader>gb  :Gblame<CR>
--nnoremap <Leader>ge  :Gedit %<CR>
--nnoremap <Leader>gE  :Gedit<Space>
--nnoremap <Leader>gr  :Gread<CR>
--nnoremap <Leader>gR  :Gread<Space>
--nnoremap <Leader>gw  :Gwrite<CR>
--nnoremap <Leader>gW  :Gwrite!<CR>
--nnoremap <Leader>gp  :Git pull<CR>
--nnoremap <Leader>gP  :Git push -u origin HEAD<CR>
--nnoremap <Leader>gq  :Gwq<CR>
--nnoremap <Leader>gQ  :Gwq!<CR>
--nnoremap <Leader>g+  :Git stash push<CR>
--nnoremap <Leader>g-  :Git stash pop<CR>

vim.api.nvim_set_keymap('n', '<F2>', [[<cmd>NvimTreeToggle<CR>]], { noremap = true, silent = true })

--Map blankline
vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_show_trailing_blankline_indent = false

-- Gitsigns
-- require('gitsigns').setup {
--   signs = {
--     add = { text = '+' },
--     change = { text = '~' },
--     delete = { text = '_' },
--     topdelete = { text = '‾' },
--     changedelete = { text = '~' },
--   },
--   on_attach = function(bufnr)
--     local function map(mode, lhs, rhs, opts)
--         opts = vim.tbl_extend('force', {noremap = true, silent = true}, opts or {})
--         vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts)
--     end
-- 
--     -- Navigation
--     map('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
--     map('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})
-- 
--     -- Actions
--     map('n', '<leader>hs', ':Gitsigns stage_hunk<CR>')
--     map('v', '<leader>hs', ':Gitsigns stage_hunk<CR>')
--     map('n', '<leader>hr', ':Gitsigns reset_hunk<CR>')
--     map('v', '<leader>hr', ':Gitsigns reset_hunk<CR>')
--     map('n', '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>')
--     map('n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>')
--     map('n', '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>')
--     map('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>')
--     map('n', '<leader>hb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
--     map('n', '<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<CR>')
--     map('n', '<leader>hd', '<cmd>Gitsigns diffthis<CR>')
--     map('n', '<leader>hD', '<cmd>lua require"gitsigns".diffthis("~")<CR>')
--     map('n', '<leader>td', '<cmd>Gitsigns toggle_deleted<CR>')
--   end,
-- }

-- TerraformFmt
vim.g.hcl_align = 1
vim.g.terraform_fmt_on_save = 1

-- Telescope
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}

-- Enable telescope fzf native
require('telescope').load_extension('fzf')

--Add leader shortcuts
vim.api.nvim_set_keymap('n', '<leader>fb', [[<cmd>lua require('telescope.builtin').buffers()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>ff', [[<cmd>lua require('telescope.builtin').find_files()<CR>]], { noremap = true, silent = true })
--vim.api.nvim_set_keymap('n', '<leader>sb', [[<cmd>lua require('telescope.builtin').current_buffer_fuzzy_find()<CR>]], { noremap = true, silent = true })
--vim.api.nvim_set_keymap('n', '<leader>sh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]], { noremap = true, silent = true })
--vim.api.nvim_set_keymap('n', '<leader>st', [[<cmd>lua require('telescope.builtin').tags()<CR>]], { noremap = true, silent = true })
--vim.api.nvim_set_keymap('n', '<leader>sd', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>fg', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]], { noremap = true, silent = true })
--vim.api.nvim_set_keymap('n', '<leader>so', [[<cmd>lua require('telescope.builtin').tags{ only_current_buffer = true }<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader><space>', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]], { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>dd', [[<cmd>Telescope diagnostics<CR>]], { noremap = true, silent = true })

-- Treesitter configuration
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      -- init_selection = 'gnn',
      -- node_incremental = 'grn',
      -- scope_incremental = 'grc',
      -- node_decremental = 'grm',
    },
  },
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}

-- Diagnostic config
vim.diagnostic.config({
   -- Disable virtual_text
   virtual_text = false,
   float = {
     border = 'rounded'
   },
   update_in_insert = false,
})

-- Diagnostic keymaps
vim.api.nvim_set_keymap('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', { noremap = true, silent = true })

-- -- null-ls
-- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
-- require("null-ls").setup({
--   sources = {
--     require("null-ls").builtins.formatting.black
--   },
--   -- you can reuse a shared lspconfig on_attach callback here
--   on_attach = function(client, bufnr)
--     if client.supports_method("textDocument/formatting") then
--       vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
--       vim.api.nvim_create_autocmd("BufWritePre", {
--         group = augroup,
--         buffer = bufnr,
--         callback = function()
--           -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
--           vim.lsp.buf.format()
--         end,
--       })
--     end
--   end,
-- })
-- 
-- local callback = function()
--     vim.lsp.buf.format({
--         bufnr = bufnr,
--         filter = function(client)
--             return client.name == "null-ls"
--         end
--     })
-- end,


-- Mason (replacement of nvim-lsp-installer)
require("mason").setup()
require("mason-lspconfig").setup {
  ensure_installed = {"clangd", "pyright", "terraformls", "bashls", "gopls", "ansiblels" },
}

-- lsp_signature
require "lsp_signature".setup {
  hint_enable = false
}

-- LSP settings
local lspconfig = require('lspconfig')
local on_attach = function(_, bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'i', '<C-s>',function() require('lsp_signature').toggle_float_win() end, opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  -- vim.api.nvim_command('command! Format execute 'lua vim.lsp.buf.formatting()' ]]
  vim.api.nvim_create_autocmd('CursorHold', { pattern = '*', command = 'lua vim.diagnostic.open_float(nil, {focus=false})' } )
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Enable the following language servers
local servers = { 'clangd', 'pyright', 'terraformls', 'bashls', 'gopls', 'ansiblels' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

-- -- luasnip setup
-- local luasnip = require 'luasnip'
--
-- nvim-cmp setup
local types = require('cmp.types') -- Required by gopls to make completeopt work correctly
local cmp = require('cmp')
cmp.setup({
  -- snippet = {
  --   expand = function(args)
  --     luasnip.lsp_expand(args.body)
  --   end,
  -- },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  confirmation = {
    completeopt = 'menu,menuone,noselect'
  },
  preselect = types.cmp.PreselectMode.None,
  mapping = cmp.mapping.preset.insert({
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    -- ['<C-Space>'] = cmp.mapping.complete(),
    -- ['<C-e>'] = cmp.mapping.close(),
    --['<CR>'] = cmp.mapping.confirm {
    --  behavior = cmp.ConfirmBehavior.Replace,
    --  select = true,
    --},
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    -- { name = 'luasnip' },
    { name = 'buffer',
      option = {
        get_bufnrs = function()
          return vim.api.nvim_list_bufs()
        end
      },
    },
    { name = 'path' },
    -- { name = 'nvim_lsp_signature_help' },
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
    { name = 'path' }
  },
  {
    { name = 'cmdline' }
  })
})

-- Custom commands
-- Delete all buffers except the active one
vim.api.nvim_create_user_command('BufOnly', 'silent! execute "%bd|e#|bd#"', { nargs = 0 })

-- vim: ts=2 sts=2 sw=2 et
