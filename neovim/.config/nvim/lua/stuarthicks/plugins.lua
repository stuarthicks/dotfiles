local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

return require('packer').startup(function(use)
  use { 'bronson/vim-trailing-whitespace', cmd ={'FixWhitespace'} }
  use 'dense-analysis/ale'
  use { 'jamessan/vim-gnupg', cmd = {'asc'} }
  use { 'jremmen/vim-ripgrep', cmd = {'Rg'} }
  use 'junegunn/vim-easy-align'
  use 'ntk148v/vim-horizon'
  use { 'preservim/nerdtree', cmd = {'NERDTreeToggle'} }
  use 'sheerun/vim-polyglot'
  use 'tomtom/tcomment_vim'

  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'tpope/vim-fugitive'

  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'


  if packer_bootstrap then
    require('packer').sync()
  end
end)
