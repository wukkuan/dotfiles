local status_ok, null_ls = pcall(require, 'null-ls')
if not status_ok then
  return
end

local prettierd = null_ls.builtins.formatting.prettierd
-- table.insert(prettierd.filetypes, 'tsx')
-- table.insert(prettierd.filetypes, 'ts')

-- local eslintd = null_ls.builtins.formatting.eslint_d
-- table.insert(eslintd.filetypes, 'tsx')
-- table.insert(eslintd.filetypes, 'ts')

null_ls.setup({
  sources = {
    prettierd,
    -- eslintd,
  },
})
-- vim.cmd([[
--   autocmd BufWritePre *.js lua vim.lsp.buf.formatting_sync()
--   autocmd BufWritePre *.ts lua vim.lsp.buf.formatting_sync()
-- ]])

local prettierd_group = vim.api.nvim_create_augroup('Prettierd', {})
vim.api.nvim_create_autocmd('BufWritePre', {
  pattern = { '*.js', '*.ts', '*.tsx' },
  group = prettierd_group,
  callback = function()
    vim.lsp.buf.format()
  end,
})
