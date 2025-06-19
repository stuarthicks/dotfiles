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
map("n", "<A-,>", "<Cmd>BufferPrevious<CR>", { silent = true })
map("n", "<A-.>", "<Cmd>BufferNext<CR>", { silent = true })

-- Re-order to previous/next
map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", { silent = true })
map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", { silent = true })

-- Goto buffer in position...
map("n", "<A-1>", "<Cmd>BufferGoto 1<CR>", { silent = true })
map("n", "<A-2>", "<Cmd>BufferGoto 2<CR>", { silent = true })
map("n", "<A-3>", "<Cmd>BufferGoto 3<CR>", { silent = true })
map("n", "<A-4>", "<Cmd>BufferGoto 4<CR>", { silent = true })
map("n", "<A-5>", "<Cmd>BufferGoto 5<CR>", { silent = true })
map("n", "<A-6>", "<Cmd>BufferGoto 6<CR>", { silent = true })
map("n", "<A-7>", "<Cmd>BufferGoto 7<CR>", { silent = true })
map("n", "<A-8>", "<Cmd>BufferGoto 8<CR>", { silent = true })
map("n", "<A-9>", "<Cmd>BufferGoto 9<CR>", { silent = true })
map("n", "<A-0>", "<Cmd>BufferLast<CR>", { silent = true })

-- Pin/unpin buffer
map("n", "<A-p>", "<Cmd>BufferPin<CR>", { silent = true })

-- Close buffer
map("n", "<A-c>", "<Cmd>BufferClose<CR>", { silent = true })

-- Wipeout buffer
-- :BufferWipeout

-- Close commands
-- :BufferCloseAllButCurrent
-- :BufferCloseAllButPinned
-- :BufferCloseAllButCurrentOrPinned
-- :BufferCloseBuffersLeft
-- :BufferCloseBuffersRight

-- Magic buffer-picking mode
map("n", "<C-p>", "<Cmd>BufferPick<CR>", { silent = true })

-- Sort automatically by...
map("n", "<Leader>bb", "<Cmd>BufferOrderByBufferNumber<CR>", { silent = true })
map("n", "<Leader>bn", "<Cmd>BufferOrderByName<CR>", { silent = true })
map("n", "<Leader>bd", "<Cmd>BufferOrderByDirectory<CR>", { silent = true })
map("n", "<Leader>bl", "<Cmd>BufferOrderByLanguage<CR>", { silent = true })
map("n", "<Leader>bw", "<Cmd>BufferOrderByWindowNumber<CR>", { silent = true })

map("n", ";", ":")
map("n", "q:", "<nop>")
map("n", "Q", "@q")
map("t", "<ESC>", "<C-\\><C-n>")
map("v", "<", "<gv")
map("v", ">", ">gv")

map("n", "<leader>st", ":TodoTelescope keywords=TODO,FIX,FIXME<cr>")
map("n", "<leader>sT", ":Trouble todo filter = {tag = {TODO,FIX,FIXME}}<cr>")
map("n", "<leader>o", "<esc>:URLOpenUnderCursor<cr>")

map("n", "<leader>c", ":Copilot<space>")

map("n", "<leader>lm", ":CompilerOpen<cr>")

vim.cmd.cnoreabbrev("conflicts", "GitConflictListQf")
vim.cmd.cnoreabbrev("git", "Git")
vim.cmd.cnoreabbrev("glow", "Glow")
vim.cmd.cnoreabbrev("goupdatebinaries", "GoUpdateBinaries")
vim.cmd.cnoreabbrev("lazy", "Lazy")
vim.cmd.cnoreabbrev("mason", "Mason")
vim.cmd.cnoreabbrev("neogit", "Neogit")
vim.cmd.cnoreabbrev("tsupdatesync", "TSUpdateSync")
vim.cmd.cnoreabbrev("health", "checkhealth")
vim.cmd.cnoreabbrev("hc", "checkhealth")
vim.cmd.cnoreabbrev("ch", "checkhealth")
vim.cmd.cnoreabbrev("copilot", "Copilot")
