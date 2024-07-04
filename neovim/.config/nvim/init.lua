-- vi: set ft=lua ts=2 sw=2 expandtab :

require('stuarthicks.plugins')
require('stuarthicks.snippets')
require('stuarthicks.treesitter')
require('stuarthicks.lsp')

vim.cmd [[ colorscheme tokyonight-night ]]

if os.getenv('TERM_PROGRAM') == 'Apple_Terminal' then
  vim.o.termguicolors = false
  vim.cmd [[ colorscheme default ]]
end

if vim.g.neovide then
  vim.opt.guifont = 'BerkeleyMono Nerd Font:h13'
else
  vim.cmd [[
    highlight Normal guibg=NONE ctermbg=NONE
    highlight LineNr guibg=NONE ctermbg=NONE
    highlight SignColumn guibg=NONE ctermbg=NONE
    highlight EndOfBuffer guibg=NONE ctermbg=NONE
  ]]
end

vim.opt.clipboard:append { 'unnamed', 'unnamedplus' }

vim.g.mapleader = ' '
vim.g.maplocalleader = ','

vim.g.netrw_altv = 1
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 4
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 20

vim.g.did_load_filetypes = 0
vim.g.do_filetype_lua = 1

-- vim.o.clipboard ^= {'unnamed','unnamedplus'}
-- vim.o.path += '**'
-- vim.o.shortmess += 'c'
vim.o.backspace = table.concat({
  'indent',
  'eol',
  'start',
}, ',')
vim.o.backup = false
vim.o.completeopt = table.concat({
  'longest',
  'menuone',
}, ',')
vim.o.expandtab = true
vim.o.foldlevelstart = 20
vim.o.foldmethod = 'syntax'
vim.o.ignorecase = true
vim.o.linebreak = true
vim.o.mouse = 'a'
vim.o.number = true
vim.o.scrolloff = 5
vim.o.shiftwidth = 2
vim.o.sidescrolloff = 5
vim.o.signcolumn = 'number'
vim.o.smartcase = true
vim.o.smartindent = true
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.swapfile = false
vim.o.tabstop = 2
vim.o.timeoutlen = 300
vim.o.updatetime = 300
vim.o.wildignore = table.concat({
  '*/.idea/*',
  '*/.git/*',
  '*/.svn/*',
  '*/vendor/*',
  '*/node_modules/*',
}, ',')
vim.o.wildmode = 'longest,list'
vim.o.winhighlight = 'Normal:None'
vim.o.wrap = false
vim.o.writebackup = false

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

if vim.g.started_by_firenvim == true then
  vim.o.laststatus = 0
  vim.o.showtabline = 0
  vim.o.wrap = true
  map('n', 'zz', ':set lines=10<cr>', opts)
end

-- Move to previous/next
map('n', '<A-,>', '<Cmd>BufferPrevious<CR>', opts)
map('n', '<A-.>', '<Cmd>BufferNext<CR>', opts)

-- Re-order to previous/next
map('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', opts)
map('n', '<A->>', '<Cmd>BufferMoveNext<CR>', opts)

-- Goto buffer in position...
map('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', opts)
map('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', opts)
map('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', opts)
map('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', opts)
map('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', opts)
map('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', opts)
map('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', opts)
map('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', opts)
map('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', opts)
map('n', '<A-0>', '<Cmd>BufferLast<CR>', opts)

-- Pin/unpin buffer
map('n', '<A-p>', '<Cmd>BufferPin<CR>', opts)

-- Close buffer
map('n', '<A-c>', '<Cmd>BufferClose<CR>', opts)

-- Wipeout buffer
--                 :BufferWipeout

-- Close commands
--                 :BufferCloseAllButCurrent
--                 :BufferCloseAllButPinned
--                 :BufferCloseAllButCurrentOrPinned
--                 :BufferCloseBuffersLeft
--                 :BufferCloseBuffersRight

-- Magic buffer-picking mode
map('n', '<C-p>', '<Cmd>BufferPick<CR>', opts)

-- Sort automatically by...
map('n', '<Space>bb', '<Cmd>BufferOrderByBufferNumber<CR>', opts)
map('n', '<Space>bn', '<Cmd>BufferOrderByName<CR>', opts)
map('n', '<Space>bd', '<Cmd>BufferOrderByDirectory<CR>', opts)
map('n', '<Space>bl', '<Cmd>BufferOrderByLanguage<CR>', opts)
map('n', '<Space>bw', '<Cmd>BufferOrderByWindowNumber<CR>', opts)

-- Other:
-- :BarbarEnable - enables barbar (enabled by default)
-- :BarbarDisable - very bad command, should never be used

vim.keymap.set('n', ';', ':')
vim.keymap.set('n', 'q:', '<nop>')
vim.keymap.set('n', 'Q', '@q')
vim.keymap.set('t', '<ESC>', '<C-\\><C-n>')
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

vim.keymap.set('n', '<Leader><space>', ':nohlsearch<cr>')
vim.keymap.set('n', '<leader>h', ':vertical help<space>')
-- vim.keymap.set('n', '<leader>t', ':split +term<cr>')

vim.keymap.set('n', '<leader>p', ':NvimTreeToggle<cr>')
vim.keymap.set('n', '<leader>r', ':Rg<space>')
vim.keymap.set('n', '<leader>s', ':TagbarToggle<cr>')

vim.keymap.set('n', '<leader>ff', '<cmd>lua require(\'telescope.builtin\').find_files({hidden = true})<cr>')
vim.keymap.set('n', '<leader>fg', '<cmd>lua require(\'telescope.builtin\').live_grep()<cr>')
vim.keymap.set('n', '<leader>fb', '<cmd>lua require(\'telescope.builtin\').buffers()<cr>')
vim.keymap.set('n', '<leader>fh', '<cmd>lua require(\'telescope.builtin\').help_tags()<cr>')

vim.cmd.cnoreabbrev('git', 'Git')
vim.cmd.cnoreabbrev('goupdatebinaries', 'GoUpdateBinaries')
vim.cmd.cnoreabbrev('lazy', 'Lazy')
vim.cmd.cnoreabbrev('mason', 'Mason')
vim.cmd.cnoreabbrev('neogit', 'Neogit')
vim.cmd.cnoreabbrev('tsupdatesync', 'TSUpdateSync')
vim.cmd.cnoreabbrev('conflicts', 'GitConflictListQf')

vim.keymap.set("n", "<leader>o", "<esc>:URLOpenUnderCursor<cr>")

-- for repository page
vim.api.nvim_set_keymap("n", "<leader>gr", ":OpenInGHRepo <CR>", { silent = true, noremap = true })

-- for current file page
vim.api.nvim_set_keymap("n", "<leader>gf", ":OpenInGHFile <CR>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("v", "<leader>gl", ":OpenInGHFileLines <CR>", { silent = true, noremap = true })

local wk = require("which-key")

wk.register({
  b = {
    name = 'Tab bar'
  },
  c = {
    name = 'Code Actions'
  },
  f = {
    name = "Find",
    b = "Buffers",
    f = "Files",
    g = "Live Grep",
    h = "Help Tags",
  },
  o = {
    name = "Open Link in Browser",
  },
  g = {
    name = "GitHub",
    r = "Open Repository",
    f = "Open File",
  },
}, { prefix = "<leader>" })

wk.register({
  g = {
    name = 'GitHub',
    l = 'Open Selected Lines',
  },
}, { prefix = "<leader>", mode = 'v' })

vim.cmd([[
  augroup hls
    autocmd!
    autocmd BufRead *.m3u8 setfiletype hlsplaylist
  augroup end
]])

vim.cmd([[
  autocmd TermEnter term://*toggleterm#*
        \ tnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>

  nnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm direction=float"<CR>
  inoremap <silent><c-t> <Esc><Cmd>exe v:count1 . "ToggleTerm direction=float"<CR>
]])
