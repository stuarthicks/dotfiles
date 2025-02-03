return {
  {
    'romgrk/barbar.nvim',
    version = '^1.0.0',
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    init = function()
      vim.g.barbar_auto_setup = true
    end,
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

  { 'jamessan/vim-gnupg', ft = 'asc' },

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
    'Almo7aya/openingh.nvim',
    cmd = {'OpenInGHRepo', 'OpenInGHFile', 'OpenInGHFileLines'},
  },
}
