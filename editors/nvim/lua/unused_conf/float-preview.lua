local M = {}

function M.hook_add()
  vim.g["float_preview#docked"]     = 0
  vim.g["float_preview#max_width"]  = 60
  vim.g["float_preview#max_height"] = 20
end

return M
