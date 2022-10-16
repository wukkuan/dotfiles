local status_ok, null_ls = pcall(require, 'null-ls')
if not status_ok then
  return
end

local prettierd = null_ls.builtins.formatting.prettierd
table.insert(prettierd.filetypes, 'tsx')

local eslintd = null_ls.builtins.formatting.eslint_d
table.insert(eslintd.filetypes, 'tsx')

null_ls.setup({
  sources = {
    prettierd,
    eslintd,
  },
})
vim.cmd([[
  autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync()
]])
