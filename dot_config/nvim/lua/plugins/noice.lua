if true then
  return {}
end

return {
  'folke/noice.nvim',
  keys = {
    { '<leader>xm', '<cmd>Noice<cr>', desc = 'Noice (messages)' },
  },
}
