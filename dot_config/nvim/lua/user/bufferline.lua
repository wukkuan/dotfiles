require('bufferline').setup({
  options = {
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
            and ('[' .. parent_directory .. ']')
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
