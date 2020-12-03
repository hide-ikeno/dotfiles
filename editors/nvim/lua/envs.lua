local M = {}
local utils = require('utils')

local function configure_path(new_paths, path_var)
  local path_separator = utils.os.is_windows and ";" or ":"
  local paths = {}

  local function is_empty(str)
    return str == nil or str == ""
  end

  local function add_paths(list)
    for _, x in ipairs(list) do
      if not is_empty(x) then
        local y = vim.fn.expand(x)
        if utils.path.is_dir(y) and not vim.tbl_contains(paths, y) then
          paths[#paths+1] = y
        end
      end
    end
  end

  -- Split path_var string with the separator, and filter out non-exsiting dirs
  if not is_empty(path_var) then
    add_paths(vim.split(path_var, path_separator, true))
  end
  -- Add given directories in the path list.
  add_paths(new_paths)
  -- concat paths
  return table.concat(paths, path_separator)
end

function M.setup()
  -- Set PATH/MANPATH so that Nvim GUI frontend can recognize these variables
  vim.env.PATH = configure_path({
      "~/.poetry/bin",
      "~/.yarn/bin",
      "~/.cargo/bin",
      "~/.luarock/bin",
      "~/.asdf/bin",
      "~/.asdf/shims",
      "~/.local/bin",
      "~/.local/share/gem/bin",
      "~/.local/share/npm/bin",
      "~/bin",
      "/Library/Tex/texbin",
      "/usr/local/bin",
      "/usr/bin",
      "/bin",
      "/usr/local/sbin",
      "/usr/sbin",
      "/sbin",
    }, os.getenv("PATH"))

  vim.env.MANPATH = configure_path({
      "~/.local/share/man",
      "/usr/share/man/",
      "/usr/local/share/man/ja",
      "/usr/local/share/man/",
      "/Applications/Xcode.app/Contents/Developer/usr/share/man",
      "/opt/intel/man/",
    }, os.getenv("MANPATH"))
end

return M
