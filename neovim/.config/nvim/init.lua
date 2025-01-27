-- vi: set ft=lua ts=2 sw=2 expandtab :

vim.g.mapleader = ' '
vim.g.maplocalleader = ','

require('stuarthicks.plugins')
require('stuarthicks.lspconfig')

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

vim.g.netrw_altv = 1
vim.g.netrw_banner = 0
vim.g.netrw_browse_split = 4
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 20

vim.g.did_load_filetypes = 0
vim.g.do_filetype_lua = 1

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
vim.opt.conceallevel = 2
vim.opt.concealcursor = 'nc'
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

if vim.g.started_by_firenvim == true then
  vim.o.laststatus = 0
  vim.o.showtabline = 0
  vim.o.wrap = true
  vim.keymap.set('n', 'zz', ':set lines=10<cr>', { silent = true })
end

vim.g.firenvim_config = {
  globalSettings = { alt = "all" },
  localSettings = {
    [".*"] = {
      cmdline  = "neovim",
      content  = "text",
      selector = "textarea",
      takeover = "always",
      priority = 0,
    }
  }
}

local firenvim_excluded_patterns = {
  "^https://app\\.slack\\.com/",
  "^https://[^/]+\\.atlassian\\.net/",
}

for _, pattern in ipairs(firenvim_excluded_patterns) do
  vim.g.firenvim_config.localSettings[pattern] = {
    takeover = 'never',
    priority = 1,
  }
end

vim.api.nvim_create_autocmd({'BufEnter'}, {
  pattern = "github.com_*.txt",
  command = "set filetype=markdown"
})

-- Move to previous/next
vim.keymap.set('n', '<A-,>', '<Cmd>BufferPrevious<CR>', { silent = true })
vim.keymap.set('n', '<A-.>', '<Cmd>BufferNext<CR>', { silent = true })

-- Re-order to previous/next
vim.keymap.set('n', '<A-<>', '<Cmd>BufferMovePrevious<CR>', { silent = true })
vim.keymap.set('n', '<A->>', '<Cmd>BufferMoveNext<CR>', { silent = true })

-- Goto buffer in position...
vim.keymap.set('n', '<A-1>', '<Cmd>BufferGoto 1<CR>', { silent = true })
vim.keymap.set('n', '<A-2>', '<Cmd>BufferGoto 2<CR>', { silent = true })
vim.keymap.set('n', '<A-3>', '<Cmd>BufferGoto 3<CR>', { silent = true })
vim.keymap.set('n', '<A-4>', '<Cmd>BufferGoto 4<CR>', { silent = true })
vim.keymap.set('n', '<A-5>', '<Cmd>BufferGoto 5<CR>', { silent = true })
vim.keymap.set('n', '<A-6>', '<Cmd>BufferGoto 6<CR>', { silent = true })
vim.keymap.set('n', '<A-7>', '<Cmd>BufferGoto 7<CR>', { silent = true })
vim.keymap.set('n', '<A-8>', '<Cmd>BufferGoto 8<CR>', { silent = true })
vim.keymap.set('n', '<A-9>', '<Cmd>BufferGoto 9<CR>', { silent = true })
vim.keymap.set('n', '<A-0>', '<Cmd>BufferLast<CR>', { silent = true })

-- Pin/unpin buffer
vim.keymap.set('n', '<A-p>', '<Cmd>BufferPin<CR>', { silent = true })

-- Close buffer
vim.keymap.set('n', '<A-c>', '<Cmd>BufferClose<CR>', { silent = true })

-- Wipeout buffer
-- :BufferWipeout

-- Close commands
-- :BufferCloseAllButCurrent
-- :BufferCloseAllButPinned
-- :BufferCloseAllButCurrentOrPinned
-- :BufferCloseBuffersLeft
-- :BufferCloseBuffersRight

-- Magic buffer-picking mode
vim.keymap.set('n', '<C-p>', '<Cmd>BufferPick<CR>', { silent = true })

-- Sort automatically by...
vim.keymap.set('n', '<Leader>bb', '<Cmd>BufferOrderByBufferNumber<CR>', { silent = true })
vim.keymap.set('n', '<Leader>bn', '<Cmd>BufferOrderByName<CR>', { silent = true })
vim.keymap.set('n', '<Leader>bd', '<Cmd>BufferOrderByDirectory<CR>', { silent = true })
vim.keymap.set('n', '<Leader>bl', '<Cmd>BufferOrderByLanguage<CR>', { silent = true })
vim.keymap.set('n', '<Leader>bw', '<Cmd>BufferOrderByWindowNumber<CR>', { silent = true })

vim.keymap.set('n', ';', ':')
vim.keymap.set('n', 'q:', '<nop>')
vim.keymap.set('n', 'Q', '@q')
vim.keymap.set('t', '<ESC>', '<C-\\><C-n>')
vim.keymap.set('v', '<', '<gv')
vim.keymap.set('v', '>', '>gv')

vim.keymap.set('n', '<Leader><space>', ':nohlsearch<cr>')

vim.keymap.set('n', '<c-b>', ':BarbarEnable<cr>')
vim.keymap.set('n', '<leader>p', ':NvimTreeToggle<cr>')
vim.keymap.set('n', '<leader>st', ':TodoTelescope keywords=TODO,FIX,FIXME<cr>')
vim.keymap.set('n', '<leader>sT', ':Trouble todo filter = {tag = {TODO,FIX,FIXME}}<cr>')
vim.keymap.set("n", "<leader>o", "<esc>:URLOpenUnderCursor<cr>")

vim.cmd.cnoreabbrev('conflicts', 'GitConflictListQf')
vim.cmd.cnoreabbrev('git', 'Git')
vim.cmd.cnoreabbrev('glow', 'Glow')
vim.cmd.cnoreabbrev('goupdatebinaries', 'GoUpdateBinaries')
vim.cmd.cnoreabbrev('lazy', 'Lazy')
vim.cmd.cnoreabbrev('mason', 'Mason')
vim.cmd.cnoreabbrev('neogit', 'Neogit')
vim.cmd.cnoreabbrev('tsupdatesync', 'TSUpdateSync')
vim.cmd.cnoreabbrev('health', 'checkhealth')
vim.cmd.cnoreabbrev('hc', 'checkhealth')
vim.cmd.cnoreabbrev('ch', 'checkhealth')


local wk = require("which-key")

wk.add({
  { '<leader>b',  group = 'Tab bar' },
  { '<leader>c',  group = 'Code',         icon = { icon = '\u{f0626}', color = 'green' } },
  { '<leader>f',  group = 'Find / Grep',  icon = { icon = '\u{e68f}',  color = 'blue' } },
  { '<leader>g',  group = 'Git',          icon = { icon = '\u{e702}',  color = 'red' } },
  { '<leader>l',  group = 'LSP',          icon = { icon = '\u{f425}',  color = 'yellow'} },
  { '<leader>lx', group = 'GoDebug',      icon = { icon = '\u{f07d3}', color = 'cyan'} },
  { '<leader>m',  group = 'Mini',         icon = { icon = '\u{f0a06}', color = 'grey' } },
  { '<leader>s',  group = 'Fuzzy Search', icon = { icon = '\u{f0866}', color = 'green' } },
  { '<leader>t',  group = 'Trouble',      icon = { icon = '\u{ea6c}',  color = 'yellow' } },
  { '<leader>u',  group = 'Toggle Flags', icon = { icon = '\u{f11d}',  color = 'white' } },
  { '<leader>w',  group = 'Workspace',    icon = { icon = '\u{f52e}',  color = 'purple' } },

  { '<leader>e', desc = 'Open Diagnostics' },
  { '<leader>o', desc = 'Open URL in Browser', icon = { icon = '\u{f0239}', color = 'orange' } },
  { '<leader>p', desc = 'Toggle Project Drawer', icon = { icon = '\u{ef81}', color = 'blue' } },
  { '<leader>q', desc = 'Open Local List' },
})

vim.cmd([[
  augroup hls
    autocmd!
    autocmd BufRead *.m3u8 setfiletype hlsplaylist
  augroup end
]])

vim.cmd([[
  augroup systemd
    autocmd!
    autocmd BufRead *.service setfiletype systemd
  augroup end
]])
