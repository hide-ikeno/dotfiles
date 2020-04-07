local M = {}

function M.hook_add()
  vim.g.indeng_guides_enable_on_vim_startup = 1
  vim.g.indeng_guides_default_mapping = 1
  vim.g.indeng_guides_guide_size  = 1
  vim.g.indeng_guides_start_level = 2
  vim.g.indeng_guides_exclude_filetypes = {
    "help", "denite", "denite-filter", "startify", "vista", "vista_kind", "tagbar"
  }
end

return M
