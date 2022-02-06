-- vi: set ft=lua ts=2 sw=2 expandtab :

local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerCompile
  augroup end
]])

return require('packer').startup({function(use)
  use 'wbthomason/packer.nvim'

  use 'dense-analysis/ale'
  use 'junegunn/vim-easy-align'
  use 'neovim/nvim-lspconfig'
  use 'ntk148v/vim-horizon'
  use 'sheerun/vim-polyglot'
  use 'tomtom/tcomment_vim'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'williamboman/nvim-lsp-installer'
  use { 'bronson/vim-trailing-whitespace', cmd ={'FixWhitespace'} }
  use { 'jamessan/vim-gnupg', cmd = {'asc'} }
  use { 'jremmen/vim-ripgrep', cmd = {'Rg'} }
  use { 'kyazdani42/nvim-web-devicons' }
  use { 'nvim-telescope/telescope.nvim', requires = { {'nvim-lua/plenary.nvim'} } }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'preservim/nerdtree', cmd = {'NERDTreeToggle'} }
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }

  if packer_bootstrap then
    require('packer').sync()
  end
end,
  config = {
    profile = {
      enable = true,
      threshold = 1, -- ms
    },
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single', style = 'minimal' })
      end
    }
  },
})
