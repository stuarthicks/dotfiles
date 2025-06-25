local spec = { -- the default when not invoked by the browser addon
  "glacambre/firenvim",
  build = function()
    vim.fn["firenvim#install"](0)
  end,
  module = false, -- prevent other code to require("firenvim")
  lazy = true, -- never load, except when lazy.nvim is building the plugin
}

if vim.g.started_by_firenvim == true then
  spec = {
    { "noice.nvim", cond = false }, -- can't work with gui having ext_cmdline
    { "lualine.nvim", cond = false }, -- not useful in the browser
    vim.tbl_extend("force", spec, {
      lazy = false, -- must load at start in browser
      opts = {
        globalSettings = { alt = "all" },
        localSettings = {
          [".*"] = {
            -- In firefox, Manage Extension Shortcuts, configure alt-n,
            -- because the markdown editor on github already uses ctrl-e
            takeover = "never", -- security: activate with ctrl-e
            cmdline = "firenvim",
          },
        },
      },
      config = function(_, opts)
        if type(opts) == "table" and (opts.localSettings or opts.globalSettings) then
          vim.g.firenvim_config = opts
        end
      end,
    }),
  }
end

return spec
