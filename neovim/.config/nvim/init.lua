---@diagnostic disable: missing-fields

require('vim._core.ui2').enable()

vim.g.mapleader = " "
vim.o.clipboard = "unnamedplus"
vim.o.expandtab = true
vim.o.foldlevelstart = 99
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
vim.o.ignorecase = true
vim.o.number = true
vim.o.shiftwidth = 2
vim.o.signcolumn = "yes"
vim.o.smartcase = true
vim.o.swapfile = false
vim.o.winborder = "rounded"
vim.o.wrap = false

vim.o.guifont = "Berkeley Mono:h16"

local map = vim.keymap.set

map('n', '<leader>w', ':write<cr>')
map('n', '<leader>q', ':quit<cr>')

map("n", "q:", "<nop>")
map("n", "Q", "@q")
map("v", "<", "<gv")
map("v", ">", ">gv")
map("n", "<ESC><ESC>", ":nohlsearch<CR>")

vim.pack.add({
  "https://github.com/echasnovski/mini.nvim",
  "https://github.com/kyoh86/vim-jsonl",
  "https://github.com/mason-org/mason-lspconfig.nvim",
  "https://github.com/mason-org/mason.nvim",
  "https://github.com/neovim/nvim-lspconfig",
  "https://github.com/nvim-treesitter/nvim-treesitter",
  "https://github.com/nvim-treesitter/nvim-treesitter-textobjects",
  "https://github.com/spindi/vim-vcl",
  "https://github.com/stevearc/conform.nvim",
  "https://github.com/stevearc/oil.nvim",
})

require("mason").setup()
vim.cmd.cnoreabbrev("mason", "Mason")

for _, mod in ipairs({ 'align', 'comment', 'extra', 'icons', 'jump2d', 'pairs', 'snippets', 'splitjoin', 'surround' }) do
  require('mini.' .. mod).setup()
end

require('mini.pick').setup()
vim.cmd.cnoreabbrev("pick", "Pick")
map('n', '<leader>d', ":Pick diagnostic<CR>")
map('n', '<leader>b', ":Pick buffers<CR>")
map('n', '<leader>f', ":Pick files<CR>")
map('n', '<leader>g', ":Pick grep_live<CR>")
map('n', '<leader>h', ":Pick help<CR>")

require('mini.trailspace').setup()
map('n', '<leader>t', function()
  MiniTrailspace.trim()
  MiniTrailspace.trim_last_lines()
end)

require("oil").setup()
map('n', '<leader>e', ":Oil<CR>")

require('nvim-treesitter').install({
  "bash", "c", "go", "gomod", "gosum", "gotmpl", "gowork", "lua",
  "markdown", "markdown_inline", "query", "ruby", "vim", "vimdoc",
})

vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    if not pcall(vim.treesitter.start) then
      return
    end
    vim.wo[0][0].foldexpr = 'v:lua.vim.treesitter.foldexpr()'
    vim.wo[0][0].foldmethod = 'expr'
    vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()" -- experimental
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  callback = function(ev)
    local client = vim.lsp.get_client_by_id(ev.data.client_id)
    if client:supports_method('textDocument/completion') then
      vim.lsp.completion.enable(true, client.id, ev.buf, { autotrigger = true })
    end
  end,
})

vim.cmd("set completeopt+=noselect")

vim.lsp.config('*', {
  root_markers = { '.jj', '.git' },
})

vim.lsp.config('lua_ls',{
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'MiniTrailspace', },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
})

vim.lsp.config('cucumber_language_server', {
  settings = {
    cucumber = {
      features = { "**/*.feature" },
      glue = { "**/step_definitions/*.rb" },
    },
  },
})

require("mason-lspconfig").setup()

local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    python = { "isort", "black" },
    rust = { "rustfmt", lsp_format = "fallback" },
    javascript = { "prettierd", "prettier", stop_after_first = true },
    go = { "goimports", lsp_format = "fallback" },
    terraform = { "terraform_fmt" },
  },
})

map('n', 'gd', vim.lsp.buf.definition)
map('n', '<leader>lf', conform.format)

vim.cmd [[
  highlight Normal guibg=none ctermbg=none
  highlight NonText guibg=none ctermbg=none
  highlight statusline ctermbg=NONE guibg=NONE
]]

if vim.g.neovide then
  vim.g.neovide_input_macos_option_key_is_meta = "only_left"
end
