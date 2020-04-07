local M = {}

function M.hook_add()
  vim.g.indentLine_enable     = 1
  vim.g.indentLine_char       = '¦'
  vim.g.indentLine_setConceal = 0    -- Keep my conceal setting
  vim.g.indentLine_fileTypeExclude = {
    "help", "denite", "denite-filter", "vista", "vista_kind"
  }
end

return M
