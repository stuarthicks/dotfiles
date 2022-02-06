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

vim.cmd([[
  augroup godev
    autocmd!
    autocmd FileType go lua require('go').setup({goimport = 'gopls', gofmt = 'gopls', dap_debug = true})
    autocmd FileType go lua require('go.format').goimport()
    autocmd FileType go lua require('navigator').setup()
    autocmd BufWritePre *.go :silent! lua require('go.format').goimport()
  augroup end
]])

return require('packer').startup({function(use)
  use 'wbthomason/packer.nvim'

  use 'dense-analysis/ale'
  use 'folke/tokyonight.nvim'
  use 'neovim/nvim-lspconfig'
  use 'sheerun/vim-polyglot'
  use 'tomtom/tcomment_vim'
  use 'tpope/vim-fugitive'
  use 'tpope/vim-repeat'
  use 'tpope/vim-surround'
  use 'williamboman/nvim-lsp-installer'
  use { 'RRethy/nvim-align', cmd = 'Align' }
  use { 'bronson/vim-trailing-whitespace', cmd = {'FixWhitespace'} }
  use { 'jamessan/vim-gnupg', ft = {'asc'} }
  use { 'jremmen/vim-ripgrep', cmd = {'Rg'} }
  use { 'kyazdani42/nvim-web-devicons' }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use { 'nvim-telescope/telescope.nvim', requires = { {'nvim-lua/plenary.nvim'} } }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'preservim/nerdtree', cmd = {'NERDTreeToggle'} }

  -- use 'ntk148v/vim-horizon'

  -- SLOW
  use 'ray-x/go.nvim'
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'
  use 'theHamsta/nvim-dap-virtual-text'

  use { 'ray-x/navigator.lua', requires = {'ray-x/guihua.lua', run = 'cd lua/fzy && make' }}

  if packer_bootstrap then
    require('packer').sync()
  end


  require'nvim-web-devicons'.setup {
   default = true;
  }

end,
  config = {
    profile = {
      enable = true,
      threshold = 0, -- ms
    },
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single', style = 'minimal' })
      end
    }
  },
})
