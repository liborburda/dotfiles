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

  'tpope/vim-eunuch', -- Vim sugar for UNIX shell commands

  -- UI to select things (files, grep results, open buffers...)
  { 'nvim-telescope/telescope.nvim', dependencies = { 'nvim-lua/plenary.nvim' } },
  -- { 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' },

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

  -- flash.nvim
  {
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {},
  },

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
  'hrsh7th/cmp-emoji',
  'hrsh7th/cmp-path',
  'hrsh7th/cmp-calc',
  'hrsh7th/cmp-cmdline',
  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-nvim-lsp-signature-help',
  'hrsh7th/cmp-nvim-lsp-document-symbol',
  'SergioRibera/cmp-dotenv',

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
vim.opt.guicursor = "a:blinkon0,i-ci-ve:ver25-iCursor"

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

-- Disable swapfile
vim.opt.swapfile = false

-- Set maximum completion menu height
vim.o.pumheight = 15

--Set colorscheme
require("catppuccin").setup({
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
vim.cmd.colorscheme('catppuccin')


-- filetype
vim.bo.filetype = 'on'

vim.filetype.add({
  extension = {
    tf = "terraform",
    tfvars = "terraform",
    tfstate = "json",
  },
})

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
vim.keymap.set('', '<space>', '<nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Nvim-tree
require('nvim-tree').setup {
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
}

-- vim.keymap.set('n', '<F2>', [[<cmd>NvimTreeToggle<CR>]], { noremap = true, silent = true })
vim.keymap.set('n', '<leader>n', function()
    nvim_tree_api = require('nvim-tree.api')
    if nvim_tree_api.tree.is_visible() then
      nvim_tree_api.tree.close()
    else
      nvim_tree_api.tree.find_file({open = true, focus = true})
    end
  end,
  { noremap = true, silent = true }
)

-- Keyboard mapping
vim.keymap.set('n', '<c-l>', '<c-w>l', { noremap = true, silent = true })
vim.keymap.set('n', '<c-h>', '<c-w>h', { noremap = true, silent = true })
vim.keymap.set('n', '<c-j>', '<c-w>j', { noremap = true, silent = true })
vim.keymap.set('n', '<c-k>', '<c-w>k', { noremap = true, silent = true })

vim.keymap.set('i', '<c-n>', '<nop>', {})
vim.keymap.set('i', '<c-p>', '<nop>', {})

-- indent block and get back to visual mode
vim.keymap.set('v', '<', '<gv', { noremap = true, silent = true })
vim.keymap.set('v', '>', '>gv', { noremap = true, silent = true })

-- clipboard
vim.keymap.set('v', '<leader>y', '"+y', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>p', '"+p', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>P', '"+P', { noremap = true, silent = true })

-- terminal
vim.keymap.set('t', '<esc>', '<c-\\><c-n>', { noremap = true, silent = true })

-- Close all floating windows
vim.keymap.set('n', '<esc>',
  function ()
    for _, win in ipairs(vim.api.nvim_list_wins()) do
      local config = vim.api.nvim_win_get_config(win)
      if config.relative ~= "" then
        vim.api.nvim_win_close(win, false)
      end
    end
  end,
  { noremap = true, silent = true }
)


-- Fugitive
--nnoremap <leader>gs  :G<CR>
--nnoremap <leader>gl  :Gclog!<CR>
--nnoremap <leader>gd  :Gvdiffsplit!<CR>
--nnoremap <leader>gcc :Gcommit<CR>
--nnoremap <leader>gca :Gcommit --amend<CR>
--nnoremap <leader>gco :Git checkout<Space>
--nnoremap <leader>gb  :Gblame<CR>
--nnoremap <leader>ge  :Gedit %<CR>
--nnoremap <leader>gE  :Gedit<Space>
--nnoremap <leader>gr  :Gread<CR>
--nnoremap <leader>gR  :Gread<Space>
--nnoremap <leader>gw  :Gwrite<CR>
--nnoremap <leader>gW  :Gwrite!<CR>
--nnoremap <leader>gp  :Git pull<CR>
--nnoremap <leader>gP  :Git push -u origin HEAD<CR>
--nnoremap <leader>gq  :Gwq<CR>
--nnoremap <leader>gQ  :Gwq!<CR>
--nnoremap <leader>g+  :Git stash push<CR>
--nnoremap <leader>g-  :Git stash pop<CR>

--Map blankline
vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_show_trailing_blankline_indent = false

-- Gitsigns
--require('gitsigns').setup {
--  signs = {
--    add = { text = '+' },
--    change = { text = '~' },
--    delete = { text = '_' },
--    topdelete = { text = '‾' },
--    changedelete = { text = '~' },
--  },
--  on_attach = function(bufnr)
--    opts = { buffer = bufnr, noremap = true, silent = true }
--
--    -- Navigation
--    -- vim.keymap.set('n', ']c', "&diff ? ']c' : '<cmd>Gitsigns next_hunk<CR>'", {expr=true})
--    -- vim.keymap.set('n', '[c', "&diff ? '[c' : '<cmd>Gitsigns prev_hunk<CR>'", {expr=true})
--
--    -- Actions
--    vim.keymap.set('n', '<leader>hs', ':Gitsigns stage_hunk<CR>', opts)
--    vim.keymap.set('v', '<leader>hs', ':Gitsigns stage_hunk<CR>', opts)
--    vim.keymap.set('n', '<leader>hr', ':Gitsigns reset_hunk<CR>', opts)
--    vim.keymap.set('v', '<leader>hr', ':Gitsigns reset_hunk<CR>', opts)
--    -- vim.keymap.set('n', '<leader>hS', '<cmd>Gitsigns stage_buffer<CR>')
--    vim.keymap.set('n', '<leader>hu', '<cmd>Gitsigns undo_stage_hunk<CR>', opts)
--    -- vim.keymap.set('n', '<leader>hR', '<cmd>Gitsigns reset_buffer<CR>')
--    vim.keymap.set('n', '<leader>hp', '<cmd>Gitsigns preview_hunk<CR>', opts)
--    -- vim.keymap.set('n', '<leader>hb', '<cmd>lua require"gitsigns".blame_line{full=true}<CR>')
--    -- vim.keymap.set('n', '<leader>tb', '<cmd>Gitsigns toggle_current_line_blame<CR>')
--    -- vim.keymap.set('n', '<leader>hd', '<cmd>Gitsigns diffthis<CR>')
--    -- vim.keymap.set('n', '<leader>hD', '<cmd>lua require"gitsigns".diffthis("~")<CR>')
--    -- vim.keymap.set('n', '<leader>td', '<cmd>Gitsigns toggle_deleted<CR>')
--  end,
--}

-- Telescope
require('telescope').setup {
  defaults = {
    preview = false,
  },
}

-- Enable telescope fzf native
-- require('telescope').load_extension('fzf')

--Add leader shortcuts
vim.keymap.set('n', '<leader>fb', function () require('telescope.builtin').buffers() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>ff', function () require('telescope.builtin').find_files() end, { noremap = true, silent = true })
--vim.keymap.set('n', '<leader>sb', function () require('telescope.builtin').current_buffer_fuzzy_find() end, { noremap = true, silent = true })
--vim.keymap.set('n', '<leader>sh', function () require('telescope.builtin').help_tags() end, { noremap = true, silent = true })
--vim.keymap.set('n', '<leader>st', function () require('telescope.builtin').tags() end, { noremap = true, silent = true })
--vim.keymap.set('n', '<leader>sd', function () require('telescope.builtin').grep_string() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fg', function () require('telescope.builtin').live_grep() end, { noremap = true, silent = true })
--vim.keymap.set('n', '<leader>so', function () require('telescope.builtin').tags{ only_current_buffer = true } end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader><Space>', function () require('telescope.builtin').oldfiles() end, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>fd', function () require('telescope.builtin').diagnostics() end, { noremap = true, silent = true })


-- flash.nvim
require('flash').setup {
  modes = {
    search = {
      enabled = false
    },
  }
}

-- vim.keymap.set('n', '<leader>t', function () require("flash").treesitter() end, { noremap = true, silent = true })
vim.keymap.set('n', 's', function() require("flash").jump() end, {noremap = true, silent = true })
vim.keymap.set('x', 's', function() require("flash").jump() end, {noremap = true, silent = true })
vim.keymap.set('o', 's', function() require("flash").jump() end, {noremap = true, silent = true })
vim.keymap.set('n', 'S', function() require("flash").treesitter() end, {noremap = true, silent = true })
vim.keymap.set('x', 'S', function() require("flash").treesitter() end, {noremap = true, silent = true })
vim.keymap.set('o', 'S', function() require("flash").treesitter() end, {noremap = true, silent = true })


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
vim.keymap.set('n', '<leader>e', function () vim.diagnostic.open_float() end, { noremap = true, silent = true })
-- vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { noremap = true, silent = true })
-- vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', { noremap = true, silent = true })
-- vim.keymap.set('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', { noremap = true, silent = true })


-- null-ls
require("mason-null-ls").setup({
    ensure_installed = { 'goimports', 'black', 'terraformls' }
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


-- Mason (replacement of nvim-lsp-installer)
local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local lspconfig = require('lspconfig')

mason.setup()

mason_lspconfig.setup {
  ensure_installed = {
    "clangd",
    "pyright",
    "terraformls",
    "bashls",
    "gopls",
    "ansiblels",
  }
}


-- LSP settings
local on_attach = function(_, bufnr)
  local opts = { buffer = bufnr, noremap = true, silent = true }
  vim.keymap.set('n', 'gD', function () vim.lsp.buf.declaration() end, opts)
  vim.keymap.set('n', 'gd', function () vim.lsp.buf.definition() end, opts)
  vim.keymap.set('n', 'K', function () vim.lsp.buf.hover() end, opts)
  vim.keymap.set('n', 'gi', function () vim.lsp.buf.implementation() end, opts)
  vim.keymap.set('i', '<c-s>', function () vim.lsp.buf.signature_help() end, opts)
  vim.keymap.set('n', '<c-s>', function () vim.lsp.buf.signature_help() end, opts)
  -- vim.keymap.set('n', '<leader>wa', function () vim.lsp.buf.add_workspace_folder() end, opts)
  -- vim.keymap.set('n', '<leader>wr', function () vim.lsp.buf.remove_workspace_folder() end, opts)
  -- vim.keymap.set('n', '<leader>wl', function () print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, opts)
  vim.keymap.set('n', '<leader>D', function () vim.lsp.buf.type_definition() end, opts)
  vim.keymap.set('n', '<leader>rn', function () vim.lsp.buf.rename() end, opts)
  vim.keymap.set('n', 'gr', function () vim.lsp.buf.references() end, opts)
  vim.keymap.set('n', '<leader>ca', function () vim.lsp.buf.code_action() end, opts)
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Enable all installed LSP servers
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

-- nvim-cmp setup
local types = require('cmp.types') -- Required by gopls to make completeopt work correctly
local cmp = require('cmp')
cmp.setup({
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  confirmation = {
    completeopt = 'menu,menuone,noselect'
  },
  preselect = types.cmp.PreselectMode.None,
  mapping = cmp.mapping.preset.insert({
    ['<c-n>'] = cmp.mapping.select_next_item(),
    ['<c-p>'] = cmp.mapping.select_prev_item(),
    ['<c-d>'] = cmp.mapping.scroll_docs(-4),
    ['<c-f>'] = cmp.mapping.scroll_docs(4),
    --['<esc>'] = cmp.mapping.abort(),
  }),
  sources = cmp.config.sources({
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
    { name = 'buffer' },
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
