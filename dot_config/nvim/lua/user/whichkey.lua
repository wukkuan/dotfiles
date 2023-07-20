local status_ok, which_key = pcall(require, 'which-key')
if not status_ok then
  return
end

local function goto_window(winnum)
  local winlist = vim.api.nvim_list_wins()
  for _, winid in ipairs(winlist) do
    if vim.api.nvim_win_get_number(winid) == winnum then
      vim.api.nvim_set_current_win(winid)
      return
    end
  end
  print('Window ' .. winnum .. ' not found')
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
    m = { '<cmd>BufferLineGroupClose ungrouped<cr>', 'Maximize' },
    p = { '<cmd>BufferLineTogglePin<cr>', 'Toggle pin' },
  },
  ['q'] = {
    name = 'Macros',
    q = { '<cmd>normal @q<CR>', '@q' },
  },
  z = {
    name = 'Toggles',
    h = { '<cmd>nohlsearch<CR>', 'No Highlight' },
    l = { require('lsp_lines').toggle, 'LSP Lines' },
    q = { '<cmd>cclose<CR>', 'Close Quickfix' },
  },
  f = {
    name = 'Files',
    y = { '<cmd>let @* = expand("%")<cr>', 'Copy current filename' },
    ['/'] = {
      function()
        require('telescope.builtin').find_files({
          sorter = require('telescope.sorters').get_fzy_sorter(),
          path_display = {
            'absolute',
            shorten = {
              len = 3,
              exclude = { -1, -2, -3, -4, -5, -6, -7 },
            },
          },
          layout_strategy = 'vertical',
          layout_config = {
            width = 0.9,
          },
        })
      end,
      'Find files',
    },
    w = {
      '<cmd>w<cr>',
      'Write',
    },
    s = {
      '<cmd>source %<cr>',
      ':source %',
    },
    d = {
      function()
        local answer = vim.fn.confirm("Do you want to delete this file?", "&Yes\n&No", 0)
        if answer == 1 then
          local filename = vim.fn.expand('%:p')  -- get the full path of the file
          local escaped_filename = vim.fn.shellescape(filename)  -- escape special characters
          os.execute('rm ' .. escaped_filename)
          vim.cmd('bd')
        end
      end,
      'Delete file'
    }
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
    l = { '<cmd>Gitsigns blame_line<cr>', 'Blame line' },
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
    d = { '<C-w>q', 'quit window' },
    ['1'] = { function() goto_window(1) end, 'go to 1' },
    ['2'] = { function() goto_window(2) end, 'go to 2' },
    ['3'] = { function() goto_window(3) end, 'go to 3' },
    ['4'] = { function() goto_window(4) end, 'go to 4' },
    ['5'] = { function() goto_window(5) end, 'go to 5' },
    ['6'] = { function() goto_window(6) end, 'go to 6' },
    ['7'] = { function() goto_window(7) end, 'go to 7' },
    ['8'] = { function() goto_window(8) end, 'go to 8' },
  },

  s = {
    name = 'Search',
    b = { '<cmd>Telescope git_branches<cr>', 'Checkout branch' },
    c = { '<cmd>Telescope colorscheme<cr>', 'Colorscheme' },
    h = { '<cmd>Telescope help_tags<cr>', 'Find Help' },
    r = { '<cmd>Telescope oldfiles<cr>', 'Open Recent File' },
    R = { '<cmd>Telescope registers<cr>', 'Registers' },
    k = { '<cmd>Telescope keymaps<cr>', 'Keymaps' },
    C = { '<cmd>Telescope commands<cr>', 'Commands' },
    f = {
      function()
        require('telescope.builtin').live_grep({
          path_display = { 'smart' },
          theme = 'ivy',
        })
      end,
      'Find Text',
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

return {
  opts = opts
}
