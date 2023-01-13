-- vi: set ft=lua ts=2 sw=2 expandtab :

require('stuarthicks.plugins')
require('stuarthicks.treesitter')
require('stuarthicks.lsp')

vim.o.background = 'dark'
vim.cmd [[
  colorscheme horizon
  highlight Normal guibg=NONE ctermbg=NONE
  highlight LineNr guibg=NONE ctermbg=NONE
  highlight SignColumn guibg=NONE ctermbg=NONE
  highlight EndOfBuffer guibg=NONE ctermbg=NONE
]]

local term_program = os.getenv('TERM_PROGRAM')
vim.o.termguicolors = true
if term_program == 'Apple_Terminal' then
  vim.o.termguicolors = false
  vim.cmd 'colorscheme default'
end

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

vim.keymap.set('n', ';', ':')
vim.keymap.set('n', 'q:', '<nop>')
vim.keymap.set('n', 'Q', '@q')
vim.keymap.set('t', '<ESC>', '<C-\\><C-n>')
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

vim.keymap.set('n', '<Leader><space>', ':nohlsearch<cr>')
vim.keymap.set('n', '<leader>h', ':vertical help<space>')
vim.keymap.set('n', '<leader>t', ':split +term<cr>')

vim.keymap.set('n', '<leader>p', ':NERDTreeToggle<cr>')
vim.keymap.set('n', '<leader>o', ':SymbolsOutline<cr>')
vim.keymap.set('n', '<leader>r', ':Rg<space>')

vim.keymap.set('n', '<leader>ff', '<cmd>lua require(\'telescope.builtin\').find_files()<cr>')
vim.keymap.set('n', '<leader>fg', '<cmd>lua require(\'telescope.builtin\').live_grep()<cr>')
vim.keymap.set('n', '<leader>fb', '<cmd>lua require(\'telescope.builtin\').buffers()<cr>')
vim.keymap.set('n', '<leader>fh', '<cmd>lua require(\'telescope.builtin\').help_tags()<cr>')

vim.keymap.set("n", "<leader>fml", "<cmd>CellularAutomaton make_it_rain<CR>")

vim.cmd([[
  augroup hls
    autocmd!
    autocmd BufRead *.m3u8 setfiletype hlsplaylist
  augroup end
]])
