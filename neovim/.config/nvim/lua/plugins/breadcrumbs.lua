local M = {
  "LunarVim/breadcrumbs.nvim",
  dependencies = {
    {"SmiteshP/nvim-navic"},
  },
}

function M.config()
  require("nvim-navic").setup {
    lsp = {
      auto_attach = true,
    },
  }
  require("breadcrumbs").setup()
  vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
end

return M
