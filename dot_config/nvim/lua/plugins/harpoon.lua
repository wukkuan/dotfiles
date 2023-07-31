local function hui(fn)
  return function(...)
    require('harpoon.ui')[fn](...)
  end
end
local function hmark(fn)
  return function(...)
    require('harpoon.mark')[fn](...)
  end
end

return {
  'ThePrimeagen/harpoon',
  keys = {
    { '<leader>mm', hui('toggle_quick_menu'), desc = 'Quick menu' },
    { '<leader>ma', hmark('add_file'), desc = 'Add file mark' },
    { '<leader>md', hmark('rm_file'), desc = 'Delete file mark' },
    { '<leader>mc', hmark('clear_all'), desc = 'Clear all marks' },
    { '<leader>ml', hui('nav_next'), desc = 'Next' },
    { '<leader>mh', hui('nav_prev'), desc = 'Previous' },
    {
      '<leader>m1',
      function()
        hui('nav_file')(1)
      end,
      desc = 'Navigate to 1',
    },
    {
      '<leader>m2',
      function()
        hui('nav_file')(2)
      end,
      desc = 'Navigate to 2',
    },
    {
      '<leader>m3',
      function()
        hui('nav_file')(3)
      end,
      desc = 'Navigate to 3',
    },
    {
      '<leader>m4',
      function()
        hui('nav_file')(4)
      end,
      desc = 'Navigate to 4',
    },
    {
      '<leader>m5',
      function()
        hui('nav_file')(5)
      end,
      desc = 'Navigate to 5',
    },
  },
}
