-- LSP
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'g\\', function()
  vim.cmd('split')
  vim.lsp.buf.definition()
end)
