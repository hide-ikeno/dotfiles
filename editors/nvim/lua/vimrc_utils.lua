local api = vim.api

--- OS specific settings
is_windows = vim.loop.os_uname().version:match("Windows")
is_mac     = vim.loop.os_uname().version:match("Darwin")

local file_separator = is_windows and '\\' or '/'

--- Check if a string is nil or empty
function is_empty(str)
  return str == nil or str == ''
end

--- Check if a file or directory exists in this path
function exists(file)
  local stat = vim.loop.fs_stat(file)
  return stat and stat.type or false
end

function is_directory(path)
  -- "/" works both Unix and Windows
  return exists(path.."/")
end

--- create augroups
function createAugroups(definitions)
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
