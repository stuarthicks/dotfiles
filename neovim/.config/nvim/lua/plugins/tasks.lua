return {
  {
    "al1-ce/just.nvim",
    dependencies = {
      'nvim-lua/plenary.nvim', -- async jobs
      'nvim-telescope/telescope.nvim', -- task picker (optional)
      'rcarriga/nvim-notify', -- general notifications (optional)
      'j-hui/fidget.nvim', -- task progress (optional)
      'al1-ce/jsfunc.nvim', -- extension library
    },
    config = true
  },
  {
    "Zeioth/compiler.nvim",
    cmd = {"CompilerOpen", "CompilerToggleResults", "CompilerRedo"},
    dependencies = { "stevearc/overseer.nvim", "nvim-telescope/telescope.nvim" },
    opts = {},
  },
  {
    "stevearc/overseer.nvim",
    commit = "6271cab7ccc4ca840faa93f54440ffae3a3918bd",
    cmd = { "CompilerOpen", "CompilerToggleResults", "CompilerRedo" },
    opts = {
      task_list = {
        direction = "bottom",
        min_height = 25,
        max_height = 25,
        default_detail = 1
      },
    },
  },
}
