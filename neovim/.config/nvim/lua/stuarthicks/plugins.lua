-- vi: set ft=lua ts=2 sw=2 expandtab :

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  t})
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { 'RRethy/nvim-align', cmd = 'Align' },
  {
    'akinsho/toggleterm.nvim',
    version = "*",
    opts = {
      start_in_insert = true,
      auto_scroll = true,
      direction = 'float',
    },
    config = function()
      require("toggleterm").setup{}
    end
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim",         -- required
      "nvim-telescope/telescope.nvim", -- required
      "sindrets/diffview.nvim",        -- optional - Diff integration
    },
    config = true
  },
  { 'bronson/vim-trailing-whitespace', cmd = {'FixWhitespace'} },
  { 'jamessan/vim-gnupg' },
  { 'jremmen/vim-ripgrep', cmd = {'Rg'} },
  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    config = function()
      require("nvim-tree").setup({
        sort = {
          sorter = "case_sensitive",
        },
        renderer = {
          group_empty = true,
        },
      })
    end
  },
  { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },
  { 'nvim-treesitter/nvim-treesitter-textobjects' },
  { 'preservim/tagbar', cmd = {'TagbarToggle'} },
  {
    'romgrk/barbar.nvim',
    dependencies = {
      'lewis6991/gitsigns.nvim', -- OPTIONAL: for git status
      'nvim-tree/nvim-web-devicons', -- OPTIONAL: for file icons
    },
    init = function() vim.g.barbar_auto_setup = false end,
    opts = {
      -- lazy.nvim will automatically call setup for you. put your options here, anything missing will use the default:
      -- animation = true,
      -- insert_at_start = true,
      -- …etc.
    },
    version = '^1.0.0', -- optional: only update when a new 1.x version is released
  },
  { 'sheerun/vim-polyglot' },
  -- {
  --   'numToStr/Comment.nvim',
  --   opts = {
  --     -- add any options here
  --   },
  --   lazy = false,
  --   config = function()
  --     require('Comment').setup()
  --   end,
  -- },
  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
        require("nvim-surround").setup({
            -- Configuration here, or leave empty to use defaults
        })
    end
  },
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v2.x',
    dependencies = {
      -- LSP Support
      {'neovim/nvim-lspconfig'},             -- Required
      {'williamboman/mason.nvim'},           -- Optional
      {'williamboman/mason-lspconfig.nvim'}, -- Optional

      -- Autocompletion
      {'hrsh7th/nvim-cmp'},     -- Required
      {'hrsh7th/cmp-nvim-lsp'}, -- Required
      {'L3MON4D3/LuaSnip', build = "make install_jsregexp" },     -- Required
    },
  },
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = { "rafamadriz/friendly-snippets" },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    dependencies = {
      'echasnovski/mini.icons'
    },
    init = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
    end,
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    }
  },
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzy-native.nvim',
    },
    config = function()
      require('telescope').load_extension('fzy_native')
    end
  },
  {
    'ray-x/go.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-treesitter/nvim-treesitter',
      'ray-x/guihua.lua',
    },
    config = function()
      require("go").setup({
        fillstruct = 'gopls',
        max_line_len = 0,
        lsp_cfg = false,
      })
    end,
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'},
    build = ':lua require("go.install").update_all_sync()'
  },
  {
    'glacambre/firenvim',

    -- Lazy load firenvim
    -- Explanation: https://github.com/folke/lazy.nvim/discussions/463#discussioncomment-4819297
    lazy = not vim.g.started_by_firenvim,
    build = ":call firenvim#install(0)",
  },

  {'akinsho/git-conflict.nvim', version = "*", config = true},

  {
    'sontungexpt/url-open',
    event = 'VeryLazy',
    cmd = 'URLOpenUnderCursor',
    config = function()
      local status_ok, url_open = pcall(require, 'url-open')
      if not status_ok then
        return
      end
      url_open.setup ({})
    end,
  },

  {
    'Almo7aya/openingh.nvim'
  },

  {
    'ellisonleao/glow.nvim',
    config = true,
    cmd = "Glow"
  },
  {
    'nvim-orgmode/orgmode',
    event = 'VeryLazy',
    ft = { 'org' },
    config = function()
      -- Setup orgmode
      require('orgmode').setup({
        org_agenda_files = '~/.orgfiles/**/*',
        org_default_notes_file = '~/.orgfiles/refile.org',
      })
    end,
  },

  -- {
  --   "chipsenkbeil/org-roam.nvim",
  --   tag = "0.1.0",
  --   dependencies = {
  --     {
  --       "nvim-orgmode/orgmode",
  --       tag = "0.3.4",
  --     },
  --   },
  --   config = function()
  --     require("org-roam").setup({
  --       directory = "~/.orgfiles/roam",
  --     })
  --   end
  -- },

  -- Themes
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
  },
})
