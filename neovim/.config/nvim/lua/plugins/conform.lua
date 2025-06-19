return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["lua"] = { "stylua" },
        ["javascript"] = { "prettier" },
        ["json"] = { "prettier" },
        ["go"] = { "gofmt" },
      },
    },
  },
}
