return {
  {
    "romgrk/barbar.nvim",
    version = "^1.0.0",
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    init = function()
      vim.g.barbar_auto_setup = true
    end,
  },
}
