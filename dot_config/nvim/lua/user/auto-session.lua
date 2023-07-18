require('auto-session').setup({})

require("telescope").load_extension("session-lens")

require('which-key').register({
  p = {
    s = { require("auto-session.session-lens").search_session, 'Auto Session' },
  }
})
