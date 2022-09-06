-- Required to get neoformat to use project local prettier
vim.g.neoformat_try_node_exe = 1

-- Run the following to stay up to date
-- npm update -g @fsouza/prettierd
vim.cmd([[
  autocmd BufWritePre *.js Neoformat prettierd
  autocmd BufWritePre *.lua Neoformat stylua
]])
