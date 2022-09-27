local status_ok, which_key = pcall(require, 'which-key')
if not status_ok then
  return
end

local mappings = {
  ['b'] = {
    name = 'Buffers',
    b = {
      function()
        require('telescope.builtin').buffers(
          require('telescope.themes').get_dropdown({ previewer = false })
        )
      end,
      'Buffers',
    },
    d = { '<cmd>Bdelete!<CR>', 'Close Buffer' },
  },
  ['q'] = {
    name = 'Macros',
    q = { '<cmd>normal @q<CR>', '@q' },
  },
  z = {
    name = 'Toggles',
    h = { '<cmd>nohlsearch<CR>', 'No Highlight' },
    l = { '<cmd>lua require("lsp_lines").toggle()<CR>', 'LSP Lines' },
  },
  f = {
    name = 'Files',
    y = { '<cmd>let @* = expand("%")<cr>', 'Copy current filename' },
    ['/'] = {
      function()
        require('telescope.builtin').find_files(
          require('telescope.themes').get_dropdown({
            previewer = false,
            path_display = { 'smart' },
          })
        )
      end,
      'Find files',
    },
    f = {
      function()
        local snap = require('snap')
        snap.run({
          producer = snap.get('consumer.fzy')(
            snap.get('producer.ripgrep.file')
          ),
          select = snap.get('select.file').select,
          multiselect = snap.get('select.file').multiselect,
          views = { snap.get('preview.file') },
        })
      end,
      'Find files with snap',
    },
    w = {
      '<cmd>w<cr>',
      'Write',
    },
    s = {
      '<cmd>source %<cr>',
      ':source %',
    },
  },
  t = { '<cmd>Telescope resume<cr>', 'Telescope resume' },

  p = {
    name = 'Packages',

    p = {
      name = 'Packer',
      c = { '<cmd>PackerCompile<cr>', 'Compile' },
      i = { '<cmd>PackerInstall<cr>', 'Install' },
      s = { '<cmd>PackerSync<cr>', 'Sync' },
      S = { '<cmd>PackerStatus<cr>', 'Status' },
      u = { '<cmd>PackerUpdate<cr>', 'Update' },
    },

    t = { '<cmd>NvimTreeToggle<cr>', 'NvimTree' },
  },

  g = {
    name = 'Git',
    s = { '<cmd>Neogit<CR>', 'Neogit status' },
  },

  w = {
    name = 'Window',
    h = { '<C-w>h', 'left' },
    l = { '<C-w>l', 'right' },
    j = { '<C-w>j', 'down' },
    k = { '<C-w>k', 'up' },
    v = { '<C-w>v', 'split vertical ' },
    s = { '<C-w>s', 'split horizontal ' },
    ['='] = { '<C-w>=', 'balance splits' },
    q = { '<C-w>q', 'quit window' },
  },

  l = {
    name = 'LSP',
    a = { vim.lsp.buf.code_action, 'Code Action' },
    s = { '<cmd>Telescope lsp_document_symbols<cr>', 'Document Symbols' },
    S = {
      '<cmd>Telescope lsp_dynamic_workspace_symbols<cr>',
      'Workspace Symbols',
    },
    r = { vim.lsp.buf.rename, 'Rename' },
    f = { '<cmd>lua vim.lsp.buf.formatting()<cr>', 'Format' },
    i = { '<cmd>LspInfo<cr>', 'Info' },
    j = {
      vim.lsp.diagnostic.goto_next,
      'Next Diagnostic',
    },
    k = {
      vim.lsp.diagnostic.goto_prev,
      'Prev Diagnostic',
    },
    q = { vim.lsp.diagnostic.set_loclist, 'Quickfix' },
  },

  s = {
    name = 'Search',
    b = { '<cmd>Telescope git_branches<cr>', 'Checkout branch' },
    c = { '<cmd>Telescope colorscheme<cr>', 'Colorscheme' },
    h = { '<cmd>Telescope help_tags<cr>', 'Find Help' },
    M = { '<cmd>Telescope man_pages<cr>', 'Man Pages' },
    r = { '<cmd>Telescope oldfiles<cr>', 'Open Recent File' },
    R = { '<cmd>Telescope registers<cr>', 'Registers' },
    k = { '<cmd>Telescope keymaps<cr>', 'Keymaps' },
    C = { '<cmd>Telescope commands<cr>', 'Commands' },
    F = {
      function()
        require('telescope.builtin').live_grep({
          path_display = { 'smart' },
          theme = 'ivy',
        })
      end,
      'Find Text',
    },
    f = { '<cmd>Telescope live_grep theme=ivy<cr>', 'Find Text' },
    s = {
      function()
        local snap = require('snap')
        -- snap.run({
        --   producer = snap.get('producer.ripgrep.vimgrep'),
        --   select = snap.get('select.vimgrep').select,
        --   multiselect = snap.get('select.vimgrep').multiselect,
        --   views = { snap.get('preview.vimgrep') },
        -- })
        snap.run({
          producer = snap.get('consumer.fzf')(
            snap.get('consumer.combine')(
              snap.get('producer.ripgrep.file').args({}, './lua/user')
            )
          ),
          select = snap.get('select.file').select,
          multiselect = snap.get('select.file').multiselect,
          views = { snap.get('preview.file') },
        })
      end,
      'Snap Live Ripgrep',
    },
    z = {
      function()
        -- Prompt for a directory and a file pattern. This could use some
        -- improvement. Can we make the directory a pattern instead of a
        -- literal directory? Or at least can we accept multiple directories?

        -- These don't need to be globals, but it's slightly easier to meh
        if wb__fancy_grep_dir == nil then
          wb__fancy_grep_dir = './'
        end
        if wb__fancy_grep_glob_pattern == nil then
          wb__fancy_grep_glob_pattern = '*'
        end
        vim.ui.input({
          prompt = 'Directory: ',
          default = wb__fancy_grep_dir,
          completion = 'dir',
        }, function(dir)
          dir = vim.trim(dir or '')
          if dir == '' then
            return
          end
          wb__fancy_grep_dir = dir

          vim.ui.input({
            prompt = 'File glob pattern: ',
            default = wb__fancy_grep_glob_pattern,
          }, function(pattern)
            pattern = vim.trim(pattern or '')
            wb__fancy_grep_glob_pattern = pattern
            if pattern == '' or pattern == '*' then
              pattern = nil
              wb__fancy_grep_glob_pattern = '*'
            end

            patterns = {}
            for p in string.gmatch(pattern, '[^,]+') do
              table.insert(patterns, p)
              print('pattern', p)
            end
            require('telescope.builtin').live_grep({
              search_dirs = { dir },
              glob_pattern = patterns,
            })
          end)
        end)
      end,
      'Fancy live grep',
    },
  },
}

local setup = {
  plugins = {
    spelling = {
      enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
    },
  },
}

local opts = {
  mode = 'n', -- NORMAL mode
  prefix = '<leader>',
  buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
  silent = true, -- use `silent` when creating keymaps
  noremap = true, -- use `noremap` when creating keymaps
  nowait = true, -- use `nowait` when creating keymaps
}

which_key.setup(setup)
which_key.register(mappings, opts)
