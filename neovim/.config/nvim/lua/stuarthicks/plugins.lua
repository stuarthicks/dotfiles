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
    { 'folke/tokyonight.nvim' },
    { 'imsnif/kdl.vim', ft = {'kdl'} },
    { 'jamessan/vim-gnupg', ft = {'asc'} },
    { 'jremmen/vim-ripgrep', cmd = {'Rg'} },
    { 'neovim/nvim-lspconfig' },
    { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' },
    { 'preservim/nerdtree', cmd = {'NERDTreeToggle'} },
    { 'sheerun/vim-polyglot' },
    { 'tomtom/tcomment_vim' },
    { 'tpope/vim-fugitive' },
    { 'tpope/vim-repeat' },
    { 'tpope/vim-surround' },
    {
      'folke/neoconf.nvim',
      cmd = "Neoconf",
      config = function()
        require("neoconf").setup({
            -- override any of the default settings here
          })
      end
    },
    {
      'folke/which-key.nvim',
      config = function()
        local wk = require('which-key')
      end
    },
    {
      'williamboman/nvim-lsp-installer',
      config = function()
        require("nvim-lsp-installer").setup({})
      end
    },
    {
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
    },
    {
      'nvim-telescope/telescope.nvim',
      branch = '0.1.x',
      dependencies = { 'nvim-lua/plenary.nvim' },
      config = function()
        require('telescope').load_extension('fzf')
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
