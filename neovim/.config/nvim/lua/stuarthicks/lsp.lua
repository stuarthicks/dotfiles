-- vi: set ft=lua ts=2 sw=2 expandtab :

vim.opt.signcolumn = 'yes'

-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}

    vim.keymap.set('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', '<leader>gR', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set('n', '<leader>ga', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    vim.keymap.set('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', '<leader>go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
    vim.keymap.set('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', '<leader>gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.keymap.set({'n', 'x'}, '<leader>gx', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)

    -- Debugging
    vim.keymap.set('n', '<leader>d', ':GoDebug -n<cr>', opts) -- debug nearest test
    vim.keymap.set('n', '<leader>D', ':GoDebug -s<cr>', opts) -- stop debugging
    vim.keymap.set('n', '<F5>', ':GoDbgContinue<cr>', opts)
    vim.keymap.set('n', '<F9>', ':GoDebug -b<cr>', opts) -- toggle breakpoint
  end,
})

vim.cmd([[
  augroup godev
    autocmd!
    autocmd FileType go lua require('go').setup({goimport = 'gopls', gofmt = 'gopls', dap_debug = true})
    autocmd FileType go lua require('go.format').goimport()
    autocmd FileType go lua require('navigator').setup()
    autocmd BufWritePre *.go :silent! lua require('go.format').goimport()
  augroup end
]])

vim.lsp.inlay_hint.enable()

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
require('lspconfig').gopls.setup({})
require('lspconfig').ruby_lsp.setup({})
require('lspconfig').bashls.setup({})
require('lspconfig').jsonls.setup({})
require('lspconfig').yamlls.setup({})
require('lspconfig').terraformls.setup({})

require'lspconfig'.pylsp.setup({
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          -- ignore = {'W391'},
          -- maxLineLength = 100
        }
      }
    }
  }
})

local cmp = require('cmp')

cmp.setup({
  sources = {
    { name = 'nvim_lsp' },
  },
  snippet = {
    expand = function(args)
      -- You need Neovim v0.10 to use vim.snippet
      vim.snippet.expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({}),
})
