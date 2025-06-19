return {
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      -- Override lazyvim's config which enables ugly powerline separaters
      opts.options.component_separators = { left = "", right = "" }
      opts.options.section_separators = { left = "", right = "" }
    end,
  },
}
