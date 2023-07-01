local trouble = require('trouble')

trouble.setup({
  auto_close = true,
  severity = 1, -- Hide hints and whatnot that are generally useless
})

local wk = require('which-key')
wk.register({
  p = {
    q = { '<cmd>Trouble<cr>', 'Trouble' },
  },
}, { prefix = '<leader>' })
