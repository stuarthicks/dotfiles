return {
  {
    "iamcco/markdown-preview.nvim",
    enabled = false,
  },
  {
    "drewipson/glowing-vim-markdown-preview",
    init = function()
      local plugin_path = vim.fn.stdpath("data") .. "/lazy/glowing-vim-markdown-preview/markdown-preview.vim"
      vim.cmd.source(plugin_path)
    end,
  },
}
