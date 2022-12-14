local status_ok, configs = pcall(require, 'nvim-treesitter.configs')
if not status_ok then
  return
end

configs.setup({
  ensure_installed = { 'javascript', 'lua', 'query', 'typescript' }, -- one of "all", or a list of languages
  ignore_install = { 'phpdoc' }, -- List of parsers to ignore installing
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { '' }, -- list of language that will be disabled
    additional_vim_regex_highlighting = {},
  },
  indent = { enable = true, disable = { 'yaml' } },
  context_commentstring = {
    enable = true,
    enable_autocmd = false,
  },
})

vim.opt.foldmethod = 'expr'
vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevel = 99999

require('treesitter-context').setup({
  mode = 'topline',
})
