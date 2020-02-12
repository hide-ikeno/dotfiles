local api = vim.api

--- OS specific settings
is_windows = vim.loop.os_uname().version:match("Windows")
file_separator = is_windows and '\\' or '/'

--- Check if a string is nil or empty
function is_empty(str)
  return str == nil or str == ''
end

--- Check if a file or directory exists in this path
function exists(file)
  local ok, err, code = os.rename(file, file)
  if not ok then
    if code == 13 then
      -- permission denied, but it exists
      return true
    end
  end
  return ok, err
end

function is_directory(path)
  -- "/" works both Unix and Windows
  return exists(path.."/")
end


--- Set options
function setOptions(options)
  for k, v in pairs(options) do
    vim.api.nvim_set_option(k, v)
  end
end

--- create augroups
function createAugrops(definitions)
  for group_name, definition in pairs(definitions) do
    vim.api.nvim_command("augroup " .. group_name)
    vim.api.nvim_command("autocmd!")
    for _, def in ipairs(definition) do
      local command = table.concat(vim.tbl_flatten{"autocmd", def}, " ")
      vim.api.nvim_command(command)
    end
    vim.api.nvim_command('augroup END')
  end
end

--- Get git branch name
function gitBranch()

end
