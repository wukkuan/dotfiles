-- TypeScript's Tree-Sitter grammar works fairly well for Flow.
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '*.js' },
  callback = function()
    vim.cmd('set filetype=tsx')
  end,
})
