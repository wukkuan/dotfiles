return {
  'epwalsh/obsidian.nvim',
  opts = {
    dir = '~/obsidian-notes',
    completion = {
      nvim_cmp = true,
    },
    daily_notes = {
      folder = 'daily-notes',
    },
    disable_frontmatter = true,

    note_id_func = function(title)
      return title
    end,

    -- Optional, by default when you use `:ObsidianFollowLink` on a link to an external
    -- URL it will be ignored but you can customize this behavior here.
    follow_url_func = function(url)
      -- Open the URL in the default web browser.
      vim.fn.jobstart({ 'open', url }) -- Mac OS
    end,
  },
  keys = {
    { '<leader>oo', '<cmd>ObsidianQuickSwitch<cr>', desc = 'Quick switch' },
    { '<leader>ot', '<cmd>ObsidianToday<cr>', desc = "Today's daily note" },
    {
      'gd',
      function()
        if require('obsidian').util.cursor_on_markdown_link() then
          return '<cmd>ObsidianFollowLink<CR>'
        else
          return 'gd'
        end
      end,
      noremap = false,
      expr = true,
    },
  },
}
