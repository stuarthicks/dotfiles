-- vi: set ft=lua ts=2 sw=2 expandtab :

vim.opt.clipboard:append({ "unnamed", "unnamedplus" })

vim.g.netrw_altv = 1
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 4
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 20

-- vim.o.path += '**'
-- vim.o.shortmess += 'c'
vim.o.backspace = table.concat({
  "indent",
  "eol",
  "start",
}, ",")
vim.o.backup = false
vim.o.completeopt = table.concat({
  "longest",
  "menuone",
  "noselect",
}, ",")
vim.opt.conceallevel = 2
vim.opt.concealcursor = "nc"
vim.o.expandtab = true
vim.o.foldlevelstart = 20
vim.o.foldmethod = "syntax"
vim.o.ignorecase = true
vim.o.linebreak = true
vim.o.mouse = "a"
vim.o.number = true
vim.o.relativenumber = false
vim.o.scrolloff = 5
vim.o.shiftwidth = 2
vim.o.sidescrolloff = 5
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.tabstop = 2
vim.o.timeoutlen = 300
vim.o.updatetime = 300
vim.o.wildignore = table.concat({
  "*/.idea/*",
  "*/.git/*",
  "*/.svn/*",
  "*/vendor/*",
  "*/node_modules/*",
}, ",")
vim.o.wildmode = "longest,list"
vim.o.winborder = "rounded"
vim.o.winhighlight = "Normal:None"
vim.o.wrap = false
vim.o.writebackup = false

if vim.g.started_by_firenvim == true then
  vim.o.laststatus = 0
  vim.o.showtabline = 0
  vim.o.wrap = true
  vim.keymap.set("n", "zz", ":set lines=20<cr>", { silent = true })
end

vim.g.snacks_animate = false
