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
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  { 'RRethy/nvim-align', cmd = 'Align' },
  { 'bronson/vim-trailing-whitespace', cmd = {'FixWhitespace'} },
  { 'folke/neodev.nvim' },
  { 'imsnif/kdl.vim', ft = {'kdl'} },
  { 'jamessan/vim-gnupg', ft = {'asc'} },
  { 'jremmen/vim-ripgrep', cmd = {'Rg'} },
  { 'mhartington/formatter.nvim' },
  { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },
  { 'preservim/nerdtree', cmd = {'NERDTreeToggle'} },
  { 'preservim/tagbar', cmd = {'TagbarToggle'} },
  { 'sheerun/vim-polyglot' },
  { 'tomtom/tcomment_vim' },
  { 'tpope/vim-fugitive' },
  { 'tpope/vim-repeat' },
  { 'tpope/vim-surround' },
  {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    opts = {},
  },
  {
    'folke/zen-mode.nvim',
    opts = {},
  },
  {
    "folke/twilight.nvim",
    opts = {},
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
      {'L3MON4D3/LuaSnip'},     -- Required
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
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
    'mfussenegger/nvim-lint',
    config = function()
      require('lint').linters_by_ft = {
        terraform = { 'tfsec',}
      }
    end
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
      'mfussenegger/nvim-dap' ,
      'neovim/nvim-lspconfig',
      'nvim-telescope/telescope-dap.nvim' ,
      'nvim-treesitter/nvim-treesitter',
      'ray-x/guihua.lua',
      'rcarriga/nvim-dap-ui' ,
      'theHamsta/nvim-dap-virtual-text' ,
    },
    config = function()
      require("go").setup({
        fillstruct = 'gopls',
        max_line_len = 1000,
        lsp_cfg = false,
      })
    end,
    event = {"CmdlineEnter"},
    ft = {"go", 'gomod'},
    build = ':lua require("go.install").update_all_sync()'
  },
})
