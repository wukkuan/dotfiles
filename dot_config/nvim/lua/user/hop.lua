require('hop').setup({})

local wk = require('which-key')
wk.register({
  h = {
    name = 'Hop',
    h = { '<cmd>HopChar2<cr>', 'HopChar2' },
    j = { '<cmd>HopChar1<cr>', 'HopChar1' },
    a = { '<cmd>HopAnywhere<cr>', 'HopAnywhere' },
    l = { '<cmd>HopLine<cr>', 'HopLine' },
    v = { '<cmd>HopVertical<cr>', 'HopVertical' },
    ['/'] = { '<cmd>HopPattern<cr>', 'HopPattern' },
    w = { '<cmd>HopWord<cr>', 'HopWord' },
  },
}, { prefix = '<leader>' })
