local status_ok, notify = pcall(require, 'notify')
if not status_ok then
  return
end

notify.setup({
  render = 'compact',
})

vim.notify = notify

-- Dismiss all notifications if hitting escape in normal mode
vim.api.nvim_set_keymap(
  'n',
  '<esc>',
  '<cmd>lua require("notify").dismiss()<cr><esc>',
  { noremap = true, silent = true }
)
