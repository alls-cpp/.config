require("mason").setup()
require("mason-lspconfig").setup()

local bufopts = { noremap=true, silent=true, buffer=bufnr }
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, bufopts)
  vim.keymap.set('n', '<leader>j', vim.diagnostic.goto_next, bufopts)
  vim.keymap.set('n', '<leader>k', vim.diagnostic.goto_prev, bufopts)

require("lspconfig")["clangd"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
})

require("lspconfig")["pyright"].setup({
    on_attach = on_attach,
    capabilities = capabilities,
})