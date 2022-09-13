local status_ok, comment = pcall(require, 'Comment')
if not status_ok then
  vim.notify('comment broke')
  return
end

comment.setup({
  pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
})

local opts = { noremap = true, silent = true }
-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--vim.api.nvim_command('nunmap gc')
--vim.api.nvim_command('nunmap gcc')
--keymap("n", "gcc", ":lua require('Comment.api').toggle_current_linewise(cfg)", opts)
