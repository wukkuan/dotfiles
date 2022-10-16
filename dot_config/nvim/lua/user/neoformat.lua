--TODO: Neoformat can probably be removed after setting up stylua in null-ls
-- Be sure to set up the autocmd though

-- Run the following to stay up to date
-- npm update -g @fsouza/prettierd
vim.cmd([[
  autocmd BufWritePre *.lua Neoformat stylua
]])
