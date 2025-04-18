return {
  {
    'echasnovski/mini.nvim',
    version = '*',
    config = function()
      require('mini.ai').setup()
      require('mini.align').setup()
      require('mini.comment').setup()
      require('mini.move').setup()
      require('mini.pairs').setup()
      require('mini.surround').setup()
      require('mini.jump').setup()

      -- delay trailspace package so that it doesn't highlight trailing whitespace
      -- when neovim loads the snacks.nvim dashboard when opened with no files
      vim.schedule(function()
        require('mini.trailspace').setup()
        vim.keymap.set('n', '<leader>ms', ':lua MiniTrailspace.trim()<cr>')
      end)
    end
  },
}
