return {
  {
    'jose-elias-alvarez/null-ls.nvim',
    opts = function()
      -- the built-in null-ls opts includes too many sources
      -- this may not be necessary, I can't tell if it overrides the original opts or not
      local lsp_plugins = require('lazyvim.plugins.lsp')
      for _, plugin in ipairs(lsp_plugins) do
        if plugin[1] == 'neovim/nvim-lspconfig' then
          local super_opts = plugin.opts
          local nls = require('null-ls')
          return vim.tbl_extend('force', super_opts, {
            sources = {
              nls.builtins.formatting.stylua,
            },
          })
        end
      end
      print('Something went wrong in null-ls, cant find original plugin')
    end,
  },
}
