return {
  {
    'williamboman/mason.nvim',
    config = function()
      require("mason").setup()
    end
  },

  {
    "ray-x/go.nvim",
    dependencies = {
      "ray-x/guihua.lua",
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
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
    build = ':lua require("go.install").update_all_sync()' -- if you need to install/update all binaries
  },

  {
    'VPavliashvili/json-nvim',
    ft = 'json',
  },

  { 'kyoh86/vim-jsonl' },

}
