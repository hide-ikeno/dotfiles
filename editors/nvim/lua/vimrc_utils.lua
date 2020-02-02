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

