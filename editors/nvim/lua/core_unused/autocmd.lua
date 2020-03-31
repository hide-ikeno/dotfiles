local vim = vim or {}
local M = {}

M._group_name = "vimrc_group"
M._bound_funcs = {}

function M._run_hook(trigger)
  local funcs = M._bound_func[trigger]
  if funcs ~= nil then
    for _, func in ipairs(funcs) do
      func()
    end
  end
end

--- Clears out auto commands
function M.init(group_name)
  if group_name then
    M._group_name = group_name
  end

  vim.api.nvim_command("augroup " .. M._group_name)
  vim.api.nvim_command("autocmd!")
  vim.api.nvim_command("augroup END")
end

function M.bind(trigger, func)
  local s = M._bound_func[trigger]
  if s == nil then
    M._bound_funcs[trigger] = {}
    local cmd = string.format("autocmd %s %s  lua require('autocmd')._run_hook(%s)",
      M._group_name, trigger, trigger)
    vim.api.nvim_command(cmd)
  end
  table.insert(M._bound_funcs[trigger], func)
end

function M.bind_filetype(filetypes, func)
  local trigger
  if type(filetypes) == "string" then
    trigger = "FileType " .. filetypes
  elseif type(filetypes) == "table" then
    trigger = "FileType " .. table.concat(filetypes, ",")
  else
    assert(false, "`filetypes` should be a string or a table")
  end
  M.bind(trigger, func)
end

return M
