-- vi: set ft=lua ts=2 sw=2 expandtab :

-- require('lspconfig')['lua_ls'].setup { settings = { Lua = { diagnostics = { globals = {'vim'} } } } }

-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap=true, silent=true }
vim.api.nvim_set_keymap('n', '<space>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.api.nvim_set_keymap('n', '<space>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

local lsp = require('lsp-zero').preset({})

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr}) -- add lsp-zero defaults

  local lsp_opts = {buffer = bufnr}
  local bind = vim.keymap.set

  bind('n', '<leader>r', '<cmd>lua vim.lsp.buf.rename()<cr>', lsp_opts)
  bind('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', lsp_opts)
  bind('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', lsp_opts)
  bind('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', lsp_opts)
  bind('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', lsp_opts)
  bind('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', lsp_opts)
  bind('n', '<space>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', lsp_opts)
  bind('n', '<space>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', lsp_opts)
  bind('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', lsp_opts)
  bind('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', lsp_opts)
  bind('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', lsp_opts)
  bind('n', '<leader>d', ':GoDebug<space>', lsp_opts)

  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  vim.cmd([[
    augroup godev
      autocmd!
      autocmd FileType go lua require('go').setup({goimport = 'gopls', gofmt = 'gopls', dap_debug = true})
      autocmd FileType go lua require('go.format').goimport()
      autocmd FileType go lua require('navigator').setup()
      autocmd BufWritePre *.go :silent! lua require('go.format').goimport()
    augroup end
  ]])
end)

-- require('lspconfig').lua_ls.setup(lsp.nvim_lua_ls())
lsp.setup()
vim.lsp.inlay_hint.enable()
