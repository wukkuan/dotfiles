-- Possibly required for luarocks
vim.fn.setenv('MACOSX_DEPLOYMENT_TARGET', '12.5')

local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system({
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  })
  print('Installing packer close and reopen Neovim...')
  vim.cmd([[packadd packer.nvim]])
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

-- Use a protected call so we don't error out on first use
local status_ok, packer = pcall(require, 'packer')
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init({
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'rounded' })
    end,
  },
  luarocks = {
    -- macOS uses `python3` instead of `python`
    python_cmd = 'python3',
  },
})

-- Install your plugins here
return packer.startup(function(use)
  -- My plugins here
  use('wbthomason/packer.nvim') -- Have packer manage itself
  use('nvim-lua/popup.nvim') -- An implementation of the Popup API from vim in Neovim
  use('nvim-lua/plenary.nvim') -- Useful lua functions used ny lots of plugins
  use('numToStr/Comment.nvim') -- Easily comment stuff
  use('kyazdani42/nvim-web-devicons')
  use('kyazdani42/nvim-tree.lua')
  use('sbdchd/neoformat')
  --use "akinsho/bufferline.nvim"
  use('moll/vim-bbye')
  use('nvim-lualine/lualine.nvim')
  --use "akinsho/toggleterm.nvim"
  --use "ahmedkhalf/project.nvim"

  use('lewis6991/impatient.nvim')

  --use "goolord/alpha-nvim"
  --use "antoinemadec/FixCursorHold.nvim" -- This is needed to fix lsp doc highlight
  use('folke/which-key.nvim')

  -- Colorschemes
  use('folke/tokyonight.nvim')
  use({ 'catppuccin/nvim', as = 'catppuccin' })

  use('lukas-reineke/indent-blankline.nvim')

  -- cmp plugins
  use('hrsh7th/nvim-cmp') -- The completion plugin
  use('hrsh7th/cmp-buffer') -- buffer completions
  use('hrsh7th/cmp-path') -- path completions
  -- use "hrsh7th/cmp-cmdline" -- cmdline completions
  --use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use('hrsh7th/cmp-nvim-lsp')
  use('hrsh7th/cmp-nvim-lua')

  -- snippets
  use({ 'L3MON4D3/LuaSnip', run = 'make install_jsregexp', tag = 'v1.*' })
  --use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- LSP
  use('neovim/nvim-lspconfig') -- enable LSP
  --use "williamboman/nvim-lsp-installer" -- simple to use language server installer
  --use "tamago324/nlsp-settings.nvim" -- language server settings defined in json for
  use('jose-elias-alvarez/null-ls.nvim') -- for formatters and linters

  -- Telescope
  use('nvim-telescope/telescope.nvim')
  use({
    'camspiers/snap',
    rocks = { 'fzy' },
  })

  -- Harpoon
  use('ThePrimeagen/harpoon')

  -- Diffview
  use({ 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' })

  -- Treesitter
  use({
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
  })
  use('nvim-treesitter/playground')
  use('nvim-treesitter/nvim-treesitter-context')
  use('JoosepAlviste/nvim-ts-context-commentstring')
  use('tpope/vim-unimpaired')

  use('folke/trouble.nvim')

  use('phaazon/hop.nvim')

  use('j-hui/fidget.nvim')

  use({
    'akinsho/bufferline.nvim',
    tag = 'v2.*',
    requires = 'kyazdani42/nvim-web-devicons',
  })

  use({
    'glacambre/firenvim',
    run = function()
      vim.fn['firenvim#install'](0)
    end,
  })

  -- Git
  use({ 'TimUntersberger/neogit', requires = 'nvim-lua/plenary.nvim' })
  use('lewis6991/gitsigns.nvim')
  use({
    'ruifm/gitlinker.nvim',
    requires = 'nvim-lua/plenary.nvim',
  })

  use('https://git.sr.ht/~whynothugo/lsp_lines.nvim')

  use({
    'luukvbaal/stabilize.nvim',
    config = function()
      require('stabilize').setup()
    end,
  })

  use('chentoast/marks.nvim')

  use('RRethy/vim-illuminate')

  use('epwalsh/obsidian.nvim')

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require('packer').sync()
  end
end)
