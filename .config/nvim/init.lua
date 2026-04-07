if vim.fn.filereadable(vim.fn.expand('~/.vim/vimrc')) == 1 then
  vim.cmd('source ~/.vim/vimrc')
end

-- Separate from vim's viminfofile
vim.o.shadafile = ''

-- Always block
vim.o.guicursor = 'a:block'

-- Use normal vim highlighting for markdown files
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'markdown',
  callback = function()
    vim.treesitter.stop()
  end,
})

-- LSP
vim.lsp.config('pylsp', {
  settings = {
    pylsp = {
      plugins = {
        autopep8 = { enabled = false },
        mccabe = { enabled = false },
        pycodestyle = { enabled = false },
        pyflakes = { enabled = false },
        yapf = { enabled = false },
      },
    },
  },
})
vim.lsp.enable('pylsp')
