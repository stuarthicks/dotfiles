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

-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { silent=true }
vim.keymap.set('n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
vim.keymap.set('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.keymap.set('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
vim.keymap.set('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)

-- This is where you enable features that only work
-- if there is a language server active in the file
vim.api.nvim_create_autocmd('LspAttach', {
  desc = 'LSP actions',
  callback = function(event)
    local opts = {buffer = event.buf}

    vim.keymap.set('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<leader>lD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
    vim.keymap.set('n', '<leader>lR', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
    vim.keymap.set('n', '<leader>la', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
    vim.keymap.set('n', '<leader>ld', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
    vim.keymap.set('n', '<leader>li', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
    vim.keymap.set('n', '<leader>lr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
    vim.keymap.set('n', '<leader>ls', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
    vim.keymap.set('n', '<leader>lt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
    vim.keymap.set({'n', 'x'}, '<leader>lf', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
    vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)

    -- Debugging
    vim.keymap.set('n', '<leader>lxn', ':GoDebug -n<cr>', opts) -- debug nearest test
    vim.keymap.set('n', '<leader>lxs', ':GoDebug -s<cr>', opts) -- stop debugging
    vim.keymap.set('n', '<F5>', ':GoDbgContinue<cr>', opts)
    vim.keymap.set('n', '<F9>', ':GoDebug -b<cr>', opts) -- toggle breakpoint
  end,
})

local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimports()
  end,
  group = format_sync_grp,
})

vim.lsp.inlay_hint.enable()

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
require('mason-lspconfig').setup_handlers {
  function (server_name) -- default handler (optional)
    require('lspconfig')[server_name].setup {}
  end,

  ['pylsp'] = function ()
    require('lspconfig').pylsp.setup({
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
  end,

  ['lua_ls'] = function()
    require('lspconfig').lua_ls.setup {
      on_init = function(client)
        if client.workspace_folders then
          local path = client.workspace_folders[1].name
          if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
            return
          end
        end

        client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
          runtime = {
            version = 'LuaJIT'
          },
          -- Make the server aware of Neovim runtime files
          workspace = {
            checkThirdParty = false,
            library = {
              vim.env.VIMRUNTIME
            }
          }
        })
      end,
      settings = {
        Lua = {}
      }
    }
  end
}

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
