return {
  {
    'echasnovski/mini.nvim',
    version = '*',
    config = function()
      require('mini.ai').setup()
      require('mini.align').setup()
      require('mini.comment').setup()
      require('mini.move').setup()
      require('mini.operators').setup()
      require('mini.pairs').setup()
      require('mini.surround').setup()
      require('mini.jump').setup()

      require('mini.trailspace').setup()
      vim.keymap.set('n', '<leader>mt', ':lua MiniTrailspace.trim()<cr>')

      require('mini.files').setup()
      vim.keymap.set('n', '<leader>mf', ':lua MiniFiles.open()<cr>')
    end
  },

  {
    'nvim-tree/nvim-tree.lua',
    dependencies = {
      'nvim-tree/nvim-web-devicons'
    },
    cmd = 'NvimTreeToggle',
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
}
