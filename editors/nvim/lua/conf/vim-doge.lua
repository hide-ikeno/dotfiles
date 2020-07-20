local M = {}

function M.hook_add()
  vim.g.doge_doc_standard_c      = "doxygen_qt"
  vim.g.doge_doc_standard_cpp    = "doxygen_qt"
  vim.g.doge_doc_standard_python = "numpy"
  -- Key mappings
  vim.g.doge_mapping = "<Leader>d"
  vim.g.doge_mapping_comment_jump_forward  = "<M-n>"
  vim.g.doge_mapping_comment_jump_backward = "<M-p>"
end

return M
