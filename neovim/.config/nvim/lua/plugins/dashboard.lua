local header
if vim.g.neovide then
  header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗██████╗ ███████╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║██╔══██╗██╔════╝
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██║  ██║█████╗
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║  ██║██╔══╝
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██████╔╝███████╗
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═════╝ ╚══════╝
  ]]
else
  header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝
  ]]
end

return {
  {
    "folke/snacks.nvim",
    optional = true,
    opts = {
      dashboard = {
        width = 50,
        preset = {
          header = header,
          -- stylua: ignore
          ---@type snacks.dashboard.Item[]
          keys = {
            { icon = " ", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')", key = "f" },
            { icon = " ", desc = "New File", action = ":ene | startinsert", key = "n" },
            ---@diagnostic disable-next-line: missing-fields
            { icon = " ", desc = "Explorer", action = function() Snacks.explorer({ cwd = LazyVim.root() }) end , key = "e" },
            { icon = " ", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')", key = "r" },
            { icon = " ", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')", key = "g" },
            { icon = " ", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})", key = "c" },
            { icon = "󰦛 ", key = "s", desc = "Restore Session", section = "session" },
            { icon = "󰁯 ", action = function() require("persistence").load({ last = true }) end, desc = "Restore Last Session", key = "S" },
            { icon = " ", desc = "Lazy Extras", action = ":LazyExtras", key = "x" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = 1 },
          { section = "startup" },
        },
      },
    },
  },
}
