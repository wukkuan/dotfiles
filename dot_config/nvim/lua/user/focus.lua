local focus = require('focus')

focus.setup({
  width=80
})

vim.api.nvim_set_keymap('n', '<c-l>', ':FocusSplitNicely<CR>', { silent = true })


