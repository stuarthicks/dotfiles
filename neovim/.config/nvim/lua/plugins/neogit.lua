return {
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration
      "folke/snacks.nvim",
    },
    config = function()
      local neogit = require("neogit")
    end,
  },
}
