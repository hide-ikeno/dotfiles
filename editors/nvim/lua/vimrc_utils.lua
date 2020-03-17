local vim = vim or {}

local M = {}

--- OS specific settings
M.os = (function()
  local is_windows = vim.loop.os_uname().version:match("Windows")
  local is_mac     = vim.loop.os_uname().version:match("Darwin")

  -- Get back the output of an external command
  local function capture(cmd, raw)
    local f = assert(io.popen(cmd, 'r'))
    local s = assert(f:read('*a'))
    f:close()
    if raw then return s end
    s = string.gsub(s, '^%s+', '')
    s = string.gsub(s, '%s+$', '')
    s = string.gsub(s, '[\n\r]+', ' ')
    return s
  end

  return {
    is_windows = is_windows;
    is_mac     = is_mac;
    capture    = capture;
  }
end)()

-- Path utilities (picked from nvim_lsp/utils.lua)
M.path = (function()
  local function exists(filename)
    local stat = vim.loop.fs_stat(filename)
    return stat and stat.type or false
  end

  local function is_dir(filename)
    return exists(filename) == "directory"
  end

  local function is_file(filename)
    return exists(filename) == "file"
  end

  local path_sep = M.os.is_windows and "\\" or "/"

  local dirname
  do
    local strip_dir_pat = path_sep.."([^"..path_sep.."]+)$"
    local strip_sep_pat = path_sep.."$"
    dirname = function(path)
      if not path then return end
      local result = path:gsub(strip_sep_pat, ""):gsub(strip_dir_pat, "")
      if #result == 0 then
        return "/"
      end
      return result
    end
  end

  local function path_join(...)
    local result =
      table.concat(
        vim.tbl_flatten {...}, path_sep):gsub(path_sep.."+", path_sep)
    return result
  end

  return {
    dirname = dirname;
    exists  = exists;
    is_dir  = is_dir;
    is_file = is_file;
    join    = path_join;
    sep     = path_sep;
  }
end)()

--- set global options
function M.set_global_options(options)
  for k, v in pairs(options) do
    vim.api.nvim_set_option(k, v)
  end
end

--- create augroups
function M.create_augroups(definitions)
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

return M
