local trouble = require('trouble')

trouble.setup({
  auto_close = true,
})

local wk = require('which-key')
wk.register({
  p = {
    q = { '<cmd>Trouble<cr>', 'Trouble' },
  },
}, { prefix = '<leader>' })
