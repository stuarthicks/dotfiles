-- vi: set ft=lua ts=2 sw=2 expandtab :

vim.api.nvim_set_keymap("", "<D-v>", "+p<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("!", "<D-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("t", "<D-v>", "<C-R>+", { noremap = true, silent = true })
vim.api.nvim_set_keymap("v", "<D-v>", "<C-R>+", { noremap = true, silent = true })

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = "github.com_*.txt",
  command = "set filetype=markdown",
})

local map = vim.keymap.set

-- Move to previous/next
map("n", "<A-,>", "<Cmd>BufferLineCyclePrev<CR>", { silent = true })
map("n", "<A-.>", "<Cmd>BufferLineCycleNext<CR>", { silent = true })

map("n", "<A-c>", "<Cmd>Bdelete<CR>", { silent = true })

-- Magic buffer-picking mode
map("n", "<C-p>", "<Cmd>BufferLinePick<CR>", { silent = true })

map("n", ";", ":")
map("n", "q:", "<nop>")
map("n", "Q", "@q")
map("t", "<ESC>", "<C-\\><C-n>")
map("v", "<", "<gv")
map("v", ">", ">gv")

map("n", "<leader>sT", ":Trouble todo filter = {tag = {TODO,FIX,FIXME}}<cr>")
map("n", "<leader>o", "<esc>:URLOpenUnderCursor<cr>")

vim.cmd.cnoreabbrev("conflicts", "GitConflictListQf")
vim.cmd.cnoreabbrev("git", "Git")
vim.cmd.cnoreabbrev("glow", "Glow")
vim.cmd.cnoreabbrev("gobin", "GoUpdateBinaries")
vim.cmd.cnoreabbrev("lazy", "Lazy")
vim.cmd.cnoreabbrev("mason", "Mason")
vim.cmd.cnoreabbrev("neogit", "Neogit")
vim.cmd.cnoreabbrev("tsupdatesync", "TSUpdateSync")
vim.cmd.cnoreabbrev("health", "checkhealth")
vim.cmd.cnoreabbrev("hc", "checkhealth")
vim.cmd.cnoreabbrev("ch", "checkhealth")
