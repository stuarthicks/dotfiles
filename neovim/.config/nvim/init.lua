-- vi: set ft=lua ts=2 sw=2 expandtab :

vim.g.mapleader = " "
vim.g.maplocalleader = ","

require("config.lazy")
require("config.lsp")

-- vscode-based editors set this var.
-- if using their neovim plugin, this colorscheme won't be available
if vim.g.vscode == nil then
  vim.cmd([[ colorscheme tokyonight-night ]])
end

if os.getenv("TERM_PROGRAM") == "Apple_Terminal" then
  vim.o.termguicolors = false
  vim.cmd([[ colorscheme default ]])
end

if vim.g.neovide then
  vim.opt.guifont = "BerkeleyMono Nerd Font:h15"
  vim.g.neovide_input_macos_option_key_is_meta = "only_left"
  vim.keymap.set("n", "<D-s>", ":w<CR>") -- Save
  vim.keymap.set("v", "<D-c>", '"+y') -- Copy
  vim.keymap.set("n", "<D-v>", '"+P') -- Paste normal mode
  vim.keymap.set("v", "<D-v>", '"+P') -- Paste visual mode
  vim.keymap.set("c", "<D-v>", "<C-R>+") -- Paste command mode
  vim.keymap.set("i", "<D-v>", '<ESC>l"+Pli') -- Paste insert mode
else
  vim.cmd([[
    highlight Normal guibg=NONE ctermbg=NONE
    highlight LineNr guibg=NONE ctermbg=NONE
    highlight SignColumn guibg=NONE ctermbg=NONE
    highlight EndOfBuffer guibg=NONE ctermbg=NONE
  ]])
end
