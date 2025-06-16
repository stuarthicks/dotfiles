-- vi: set ft=lua ts=2 sw=2 expandtab :

vim.lsp.inlay_hint.enable()

local opts = { silent = true }
vim.keymap.set("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
vim.keymap.set("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
vim.keymap.set("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
vim.keymap.set("n", "<leader>q", "<cmd>lua vim.diagnostic.setloclist()<CR>", opts)

vim.api.nvim_create_autocmd("LspAttach", {
  desc = "LSP actions",
  callback = function(event)
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client:supports_method("textDocument/completion") then
      vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })
    end

    local opts = { buffer = event.buf }

    vim.keymap.set("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
    vim.keymap.set("n", "<leader>lD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
    vim.keymap.set("n", "<leader>lR", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
    vim.keymap.set("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
    vim.keymap.set("n", "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
    vim.keymap.set("n", "<leader>li", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
    vim.keymap.set("n", "<leader>lr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
    vim.keymap.set("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
    vim.keymap.set("n", "<leader>lt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
    vim.keymap.set({ "n", "x" }, "<leader>lf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)

    -- Debugging
    vim.keymap.set("n", "<leader>lxn", ":GoDebug -n<cr>", opts) -- debug nearest test
    vim.keymap.set("n", "<leader>lxs", ":GoDebug -s<cr>", opts) -- stop debugging
    vim.keymap.set("n", "<F5>", ":GoDbgContinue<cr>", opts)
    vim.keymap.set("n", "<F9>", ":GoDebug -b<cr>", opts) -- toggle breakpoint
  end,
})

local format_sync_grp = vim.api.nvim_create_augroup("GoFormat", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    require("go.format").goimports()
  end,
  group = format_sync_grp,
})

vim.diagnostic.config({
  virtual_text = { current_line = true },
})
