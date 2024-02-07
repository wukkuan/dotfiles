local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
  -- bootstrap lazy.nvim
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(vim.env.LAZY or lazypath)

-- Simple pretty printer, global for debugging
if pp == nil then
  function pp(t, n)
    if n == nil then
      n = 'table'
    end

    print(n)
    for k, v in pairs(t) do
      print(' ', k, v)
    end
    print('/' .. n)
  end
else
  print('pp was already defined')
end

-- Naively joins two tables. Assumes a table is either an array or a map, not
-- both.
if wb__table_join == nil then
  function wb__table_join(a, b)
    local retval = {}
    if #a == 0 then
      for k, v in pairs(a) do
        retval[k] = v
      end
      for k, v in pairs(b) do
        retval[k] = v
      end
    else
      for i, v in ipairs(a) do
        table.insert(retval, v)
      end
      for i, v in ipairs(b) do
        table.insert(retval, v)
      end
    end
    return retval
  end
else
  print('wb__table_join was already defined')
end

require('lazy').setup({
  spec = {
    -- add LazyVim and import its plugins
    { 'LazyVim/LazyVim', import = 'lazyvim.plugins' },
    -- import any extras modules here
    { import = 'lazyvim.plugins.extras.lang.typescript' },
    --{ import = 'lazyvim.plugins.extras.lang.json' },
    --{ import = 'lazyvim.plugins.extras.coding.yanky' },
    --{ import = 'lazyvim.plugins.extras.formatting.prettier' },
    --{ import = 'lazyvim.plugins.extras.ui.mini-animate' },

    -- import/override with your plugins
    { import = 'plugins/colorscheme' },
    { import = 'plugins/conform' },
    { import = 'plugins/example' },
    { import = 'plugins/harpoon' },
    { import = 'plugins/noice' },
    { import = 'plugins/nvim-cmp' },
    { import = 'plugins/obsidian' },
    { import = 'plugins/telescope' },
    { import = 'plugins/typescript' },
    { import = 'plugins/which-key' },
    { import = 'plugins/neogit' },
  },
  defaults = {
    -- By default, only LazyVim plugins will be lazy-loaded. Your custom plugins will load during startup.
    -- If you know what you're doing, you can set this to `true` to have all your custom plugins lazy-loaded by default.
    lazy = false,
    -- It's recommended to leave version=false for now, since a lot the plugin that support versioning,
    -- have outdated releases, which may break your Neovim install.
    version = false, -- always use the latest git commit
    -- version = "*", -- try installing the latest stable version for plugins that support semver
  },
  install = { colorscheme = { 'tokyonight', 'habamax' } },
  checker = { enabled = true }, -- automatically check for plugin updates
  performance = {
    rtp = {
      -- disable some rtp plugins
      disabled_plugins = {
        'gzip',
        -- "matchit",
        -- "matchparen",
        -- "netrwPlugin",
        'tarPlugin',
        'tohtml',
        'tutor',
        'zipPlugin',
      },
    },
  },
})
