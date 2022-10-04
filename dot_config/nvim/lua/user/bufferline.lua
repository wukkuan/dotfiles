-- Remove vowels in the middle of the name to shorten it a bit
local function shortenName(name)
  if #name < 5 then
    return name
  end

  local first = name:sub(1, 1)
  local middle = name:sub(2, #name - 1)
  local last = name:sub(#name)

  return first .. middle:gsub('[aeiou]', '') .. last
end

require('bufferline').setup({
  options = {
    close_command = 'BDelete %d',
    right_mouse_command = 'BDelete %d',
    diagnostics = true,
    offsets = {
      -- If NvimTree is open, keep the buffer line only over the buffers and
      -- not the NvimTree window.
      {
        filetype = 'NvimTree',
        text = '',
        padding = 1,
      },
    },
    max_name_length = 30,
    name_formatter = function(buf)
      local in_web_repo = string.match(vim.fn.getcwd(), '/workspace/web$')
        ~= nil

      if in_web_repo then
        -- The web repo has terrible naming conventions and makes tab names
        -- useless. To fix, we:
        -- * Add the parent directory as context, e.g. [Tweet]connect.js
        -- * Replace `index.js` with `.js` to save space

        local parent_directory = string.match(buf.path, '/(%w*)/[^/]*$')
        -- Add some context to for each tab
        local prefix = parent_directory ~= nil
            and ('[' .. shortenName(parent_directory) .. ']')
          or ''

        if buf.name == 'index.js' then
          return prefix .. '.js'
        else
          return prefix .. buf.name
        end
      end

      return buf.name
    end,
  },
})
