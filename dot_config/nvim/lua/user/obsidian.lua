local obsidian = require('obsidian')

obsidian.setup({
  dir = "~/Documents/Sigma Notes",
  completion = {
    nvim_cmp = true,
  },
  daily_notes = {
    folder = "daily-notes",
  },
  disable_frontmatter = true,

  note_id_func = function(title)
    return title
  end,

  -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
  -- URL it will be ignored but you can customize this behavior here.
  follow_url_func = function(url)
    -- Open the URL in the default web browser.
    vim.fn.jobstart({"open", url})  -- Mac OS
  end,
})

vim.keymap.set(
  "n",
  "gd",
  function()
    if obsidian.util.cursor_on_markdown_link() then
      return "<cmd>ObsidianFollowLink<CR>"
    else
      return "gd"
    end
  end,
  { noremap = false, expr = true }
)

local wk = require('which-key')
wk.register({
  o = {
    name = 'Obsidian',
    o = { '<cmd>ObsidianQuickSwitch<cr>', 'Quick Switch' },
    t = { '<cmd>ObsidianToday<cr>', 'Today\'s Daily Note' },
  },
}, { prefix = '<leader>' })
