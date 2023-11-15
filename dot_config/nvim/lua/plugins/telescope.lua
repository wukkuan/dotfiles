return {
  'nvim-telescope/telescope.nvim',
  keys = {
    {
      '<leader>fw',
      function()
        require('telescope.builtin').find_files({
          search_dirs = { 'src/platform/engsec/technical-privacy' },
          layout_strategy = 'vertical',
        })
      end,
      desc = 'Noice (messages)',
    },
  },
}
