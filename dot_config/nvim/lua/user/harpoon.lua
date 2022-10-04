local h = require('harpoon')
require('telescope').load_extension('harpoon')
h.setup({
  menu = {
    width = vim.api.nvim_win_get_width(0) - 4,
  },
})

local hui = require('harpoon.ui')
local hmark = require('harpoon.mark')

local wk = require('which-key')
wk.register({
  m = {
    name = 'Harpoon',
    m = { hui.toggle_quick_menu, 'Quick Menu' },
    a = { hmark.add_file, 'Add file mark' },
    d = { hmark.rm_file, 'Delete file mark' },
    c = { hmark.clear_all, 'Clear all marks' },
    l = { hui.nav_next, 'Next' },
    h = { hui.nav_next, 'Previous' },
    ['1'] = {
      function()
        hui.nav_file(1)
      end,
      'Navigate to 1',
    },
    ['2'] = {
      function()
        hui.nav_file(2)
      end,
      'Navigate to 2',
    },
    ['3'] = {
      function()
        hui.nav_file(3)
      end,
      'Navigate to 3',
    },
    ['4'] = {
      function()
        hui.nav_file(4)
      end,
      'Navigate to 4',
    },
    ['5'] = {
      function()
        hui.nav_file(5)
      end,
      'Navigate to 5',
    },
  },
}, { prefix = '<leader>' })
