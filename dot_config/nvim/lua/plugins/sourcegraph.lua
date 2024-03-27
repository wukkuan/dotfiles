local function urlencode(str)
  return (
    str
      :gsub('[^%w _~-]', function(chr)
        return string.format('%%%02X', string.byte(chr))
      end)
      :gsub(' ', '+')
  )
end

local function get_current_sha()
  local git_command = 'git rev-parse main'
  local sha = vim.fn.system(git_command)
  if vim.v.shell_error ~= 0 then
    error('Error retrieving SHA. Are you in a Git repository?')
  end
  return sha:gsub('\n', '') -- Remove newline character from the end
end

local function copy_sourcegraph_url_to_clipboard()
  local file_path = vim.fn.expand('%:p')

  local git_command = 'git -C '
    .. vim.fn.shellescape(vim.fn.fnamemodify(file_path, ':h'))
    .. ' ls-files --full-name '
    .. vim.fn.shellescape(file_path)

  local relative_path = vim.fn.system(git_command)
  relative_path = relative_path:gsub('\n', '')

  local url = 'https://sg.uberinternal.com/code.uber.internal/uber-code/web-code@'
    .. get_current_sha()
    .. '/-/blob/'
    .. urlencode(relative_path)

  vim.fn.setreg('+', url)
end

local which_key = require('which-key')
which_key.register({
  ['<leader>cs'] = {
    function()
      copy_sourcegraph_url_to_clipboard()
    end,
    'Copy Sourcegraph URL',
  },
})

return {}
