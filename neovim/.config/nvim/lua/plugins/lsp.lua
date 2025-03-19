return {

   'neovim/nvim-lspconfig',

   'hrsh7th/cmp-nvim-lsp',
   'hrsh7th/nvim-cmp',

  {
    'williamboman/mason.nvim',
    config = function()
      require("mason").setup()
    end
  },
  {
   'williamboman/mason-lspconfig.nvim',
    config = function()
      require("mason-lspconfig").setup()
    end
  },

  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "ray-x/navigator.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",

      -- For debugging
      'mfussenegger/nvim-dap',
      'nvim-neotest/nvim-nio',
      'rcarriga/nvim-dap-ui',
      'theHamsta/nvim-dap-virtual-text',
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

  { 'github/copilot.vim' },

}
