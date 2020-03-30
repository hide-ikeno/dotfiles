local M = {}

function M.hook_add()
  vim.g["fruzzy#usenative"]   = 1
  vim.g["fruzzy#sortonempty"] = 0
end

function M.hook_post_update()
  vim.fn["call fruzzy#install"]()
end

return M
