---@diagnostic disable: missing-fields
vim.g.mapleader = " "
vim.o.clipboard = "unnamedplus"
vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
vim.o.ignorecase = true
vim.o.number = true
vim.o.shiftwidth = 2
vim.o.signcolumn = "yes"
vim.o.smartcase = true
vim.o.swapfile = false
vim.o.termguicolors = true
vim.o.winborder = "rounded"
vim.o.wrap = false

vim.g.neovide_input_macos_option_key_is_meta = "only_left"
vim.o.guifont = "Berkeley Mono:h16"

local map = vim.keymap.set

map('n', '<leader>w', ':write<cr>')
map('n', '<leader>q', ':quit<cr>')

map({'n', 'v', 'x'}, ';', ':')
map("n", "q:", "<nop>")
map("n", "Q", "@q")
map("v", "<", "<gv")
map("v", ">", ">gv")
map("t", "<ESC>", "<C-\\><C-n>")
map("n", "<ESC><ESC>", ":set nohlsearch<CR>")

map({ 'n', 'v', 'x' }, '<leader>y', '"+y<CR>')
map({ 'n', 'v', 'x' }, '<leader>d', '"+d<CR>')

vim.pack.add({
  { src = "https://github.com/NicolasGB/jj.nvim" },
  { src = "https://github.com/echasnovski/mini.nvim" },
  { src = "https://github.com/folke/tokyonight.nvim" },
  { src = "https://github.com/jamessan/vim-gnupg" },
  { src = "https://github.com/kyoh86/vim-jsonl" },
  { src = "https://github.com/mason-org/mason-lspconfig.nvim" },
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/neovim/nvim-lspconfig" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects" },
  { src = "https://github.com/spindi/vim-vcl" },
  { src = "https://github.com/stevearc/conform.nvim" },
  { src = "https://github.com/stevearc/oil.nvim" },
  { src = "https://github.com/coder/claudecode.nvim" },
})

require("jj").setup({})
vim.cmd.cnoreabbrev("j", "J")
map('n', '<leader>j', ":J ")

require("mason").setup()
vim.cmd.cnoreabbrev("mason", "Mason")

require('mini.align').setup()
require('mini.comment').setup()
require('mini.completion').setup()
require('mini.extra').setup()
require('mini.icons').setup()
require('mini.pairs').setup()
require('mini.snippets').setup()
require('mini.splitjoin').setup()
require('mini.surround').setup()

require('mini.files').setup()
map('n', '<leader>F', MiniFiles.open)

require('mini.pick').setup()
vim.cmd.cnoreabbrev("pick", "Pick")
map('n', '<leader>d', ":Pick diagnostic<CR>")
map('n', '<leader>b', ":Pick buffers<CR>")
map('n', '<leader>f', ":Pick files<CR>")
map('n', '<leader>g', ":Pick grep_live<CR>")
map('n', '<leader>h', ":Pick help<CR>")

require('mini.trailspace').setup()
map('n', '<leader>t', MiniTrailspace.trim)
map('n', '<leader>tl', MiniTrailspace.trim_last_lines)

require("oil").setup()
map('n', '<leader>e', ":Oil<CR>")

require('nvim-treesitter.configs').setup({
  ensure_installed = {
    "bash",
    "c",
    "go",
    "gomod",
    "gosum",
    "gotmpl",
    "gowork",
    "lua",
    "markdown",
    "markdown_inline",
    "query",
    "ruby",
    "vim",
    "vimdoc",
  },

  auto_install = true,

  textobjects = {
    lsp_interop = {
      enable = true,
      border = 'none',
      floating_preview_opts = {},
      peek_definition_code = {
        ["<leader>df"] = "@function.outer",
        ["<leader>dF"] = "@class.outer",
      },
    },
  },
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

local lspconfig = require('lspconfig')

lspconfig.lua_ls.setup({
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
      },
      diagnostics = {
        globals = { 'vim', 'require', 'MiniTrailspace', },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
})

lspconfig.cucumber_language_server.setup({
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
    lua = {
      "stylua"
    },
    python = {
      "isort",
      "black"
    },
    rust = {
      "rustfmt",
      lsp_format = "fallback"
    },
    javascript = {
      "prettierd",
      "prettier",
      stop_after_first = true
    },
    go = {
      "goimports",
      lsp_format = "fallback"
    },
    terraform = {
      "terraform_fmt"
    },
  },
})

-- https://neovim.io/doc/user/lsp.html
map('n', 'gd', vim.lsp.buf.definition)
map('n', 'gD', vim.diagnostic.open_float)
map('n', '<leader>lf', conform.format)

require("claudecode").setup()
map('n', '<leader>ac', '<cmd>ClaudeCode<cr>')
map('n', '<leader>af', '<cmd>ClaudeCodeFocus<cr>')
map('n', '<leader>ar', '<cmd>ClaudeCode --resume<cr>')
map('n', '<leader>aC', '<cmd>ClaudeCode --continue<cr>')
map('n', '<leader>am', '<cmd>ClaudeCodeSelectModel<cr>')
map('n', '<leader>ab', '<cmd>ClaudeCodeAdd %<cr>')
map('v', '<leader>as', '<cmd>ClaudeCodeSend<cr>')
map('n', '<leader>aa', '<cmd>ClaudeCodeDiffAccept<cr>')
map('n', '<leader>ad', '<cmd>ClaudeCodeDiffDeny<cr>')

vim.api.nvim_create_autocmd('FileType', {
	pattern = 'oil',
	group = vim.api.nvim_create_augroup('claudecode_tree_add', { clear = true }),
	callback = function ()
    map('n', '<leader>as', '<cmd>ClaudeCodeTreeAdd<cr>')
	end,
})

vim.cmd [[
  colorscheme tokyonight-night
  highlight Normal guibg=none ctermbg=none
  highlight NonText guibg=none ctermbg=none
  highlight statusline ctermbg=NONE guibg=NONE
]]

