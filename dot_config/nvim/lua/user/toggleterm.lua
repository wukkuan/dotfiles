local status_ok, toggleterm = pcall(require, 'toggleterm')
if not status_ok then
  return
end

toggleterm.setup({
  open_mapping = [[c-`]]
})

local toggleterm_group = vim.api.nvim_create_augroup('Toggleterm', {})
vim.api.nvim_create_autocmd('TermOpen', {
  pattern = { 'term://*' },
  group = toggleterm_group,
  callback = function()
    local opts = {buffer = 0}
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], opts)
    vim.keymap.set('t', '<C-h>', [[<Cmd>wincmd h<CR>]], opts)
    vim.keymap.set('t', '<C-j>', [[<Cmd>wincmd j<CR>]], opts)
    vim.keymap.set('t', '<C-k>', [[<Cmd>wincmd k<CR>]], opts)
    vim.keymap.set('t', '<C-l>', [[<Cmd>wincmd l<CR>]], opts)
    vim.keymap.set('t', '<C-w>', [[<C-\><C-n><C-w>]], opts)
  end,
})

require('which-key').register({
  p = {
    c = { '<cmd>ToggleTerm<cr>', 'Toggle terminal' },
  }
}, require('user.whichkey').opts)
