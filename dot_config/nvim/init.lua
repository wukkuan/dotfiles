if vim.g.vscode then
  -- VSCode setup
else
  -- bootstrap lazy.nvim, LazyVim and your plugins
  require('config.lazy')
end
