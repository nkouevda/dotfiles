-- LSP
vim.keymap.set('n', 'gd', vim.lsp.buf.type_definition)
vim.keymap.set('n', 'g\\', function()
  vim.cmd('split')
  vim.lsp.buf.type_definition()
end)
