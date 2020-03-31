-- Path utilities (picked from nvim_lsp/utils.lua)
local os_ = require('core.os')

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

local path_sep = os_.is_windows and "\\" or "/"
local strip_dir_pat = path_sep.."([^"..path_sep.."]+)$"
local strip_sep_pat = path_sep.."$"

local function dirname(path)
  if not path then return end
  local result = path:gsub(strip_sep_pat, ""):gsub(strip_dir_pat, "")
  if #result == 0 then
    return "/"
  end
  return result
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
