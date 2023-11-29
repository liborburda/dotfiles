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
  { 'nvimtools/none-ls.nvim', dependencies = { "nvim-lua/plenary.nvim" } }, -- Support for linters and formatters
  { 'jay-babu/mason-null-ls.nvim', dependencies = {'williamboman/mason.nvim', 'nvimtools/none-ls.nvim'} },
  -- { 'stevearc/conform.nvim', opts = {}, },

  -- LSP
  'hrsh7th/nvim-cmp', -- Autocompletion plugin
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-nvim-lsp-signature-help',
  -- 'saadparwaiz1/cmp_luasnip'
  -- 'L3MON4D3/LuaSnip' } -- Snippets plugin

  -- Do not use; The LSP window overlap with nvim-cmp window
  -- "ray-x/lsp_signature.nvim",

  -- Nvim-tree
  'nvim-tree/nvim-web-devicons',
  'nvim-tree/nvim-tree.lua',

  'catppuccin/nvim',

  'ntpeters/vim-better-whitespace',

  -- GitHub Copilot
  'github/copilot.vim'
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
vim.cmd.colorscheme('catppuccin')

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

-- Temporary workaround for https://github.com/neovim/neovim/issues/23184
-- Remove after 0.9.5 is released
vim.cmd [[ au BufRead,BufNewFile *.tfvars set filetype=terraform ]]

-- Nvim-tree
require('nvim-tree').setup {
  git = {
    enable = false,
  },
  view = {
    width = 60,
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
vim.api.nvim_set_keymap('n', '<Leader>t', [[<cmd>NvimTreeFindFile<CR>]], { noremap = true, silent = true })

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

-- Telescope
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },

    preview = false,
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
  },
  indent = {
    enable = true,
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

-- null-ls
require("mason-null-ls").setup({
    ensure_installed = { 'goimports', 'black' }
})

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local null_ls = require("null-ls")

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.terraform_fmt,
    null_ls.builtins.formatting.gofmt,
    null_ls.builtins.formatting.goimports,
    null_ls.builtins.formatting.black,
  },

  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          -- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
          -- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
          vim.lsp.buf.format({ async = false })
        end,
      })
    end
  end,
})

-- Conform
-- require("conform").setup({
--   formatters_by_ft = {
--     python = { "black" },
-- 
--     -- Terraform
--     terraform = { "terraform_fmt" },
--     tf = { "terraform_fmt" },
--     ["terraform-vars"] = { "terraform_fmt" },
-- 
--     -- Golang
--     go = { "goimports", "gofmt" },
--   },
-- })
-- 
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*",
--   callback = function(args)
--     require("conform").format({ bufnr = args.buf })
--   end,
-- })

-- Mason (replacement of nvim-lsp-installer)
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require('lspconfig')

mason.setup()

mason_lspconfig.setup {
  ensure_installed = {
    "clangd",
    "pyright",
    -- "terraformls",
    "bashls",
    "gopls",
    "ansiblels",
  }
}

-- LSP settings
local on_attach = function(_, bufnr)
  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'i', '<C-h>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  -- vim.api.nvim_command('command! Format execute 'lua vim.lsp.buf.formatting()' ]]
  vim.api.nvim_create_autocmd('CursorHold', { pattern = '*', command = 'lua vim.diagnostic.open_float(nil, {focus=false})' } )
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- -- Enable the following language servers
-- local servers = require("mason-lspconfig").get_installed_servers()
-- -- local servers = { 'clangd', 'pyright', 'terraformls', 'bashls', 'gopls', 'ansiblels' }
-- for _, lsp in ipairs(servers) do
--   lspconfig[lsp].setup {
--     on_attach = on_attach,
--     capabilities = capabilities,
--   }
-- end

mason_lspconfig.setup_handlers({
  function(server_name)
    lspconfig[server_name].setup {
      on_attach = on_attach,
      capabilities = capabilities,
    }
  end
})

vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(
    vim.lsp.handlers['signature_help'], {
        border = 'rounded',
        close_events = {"CursorMoved", "BufHidden", "InsertCharPre"},
    }
)

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
    { name = 'nvim_lsp_signature_help' },
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
