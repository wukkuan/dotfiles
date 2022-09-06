local status_ok, comment = pcall(require, 'Comment')
if not status_ok then
  vim.notify('comment broke')
  return
end

comment.setup()
--comment.setup {
--  pre_hook = function(ctx)
--    local U = require "Comment.utils"
--
--    local location = nil
--    if ctx.ctype == U.ctype.block then
--      location = require("ts_context_commentstring.utils").get_cursor_location()
--    elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
--      location = require("ts_context_commentstring.utils").get_visual_start_location()
--    end
--
--    return require("ts_context_commentstring.internal").calculate_commentstring {
--      key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
--      location = location,
--    }
--  end,
--}

local opts = { noremap = true, silent = true }
-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--vim.api.nvim_command('nunmap gc')
--vim.api.nvim_command('nunmap gcc')
--keymap("n", "gcc", ":lua require('Comment.api').toggle_current_linewise(cfg)", opts)
