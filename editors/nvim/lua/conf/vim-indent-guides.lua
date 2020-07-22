local M = {}

function M.setup()
  vim.g.indeng_guides_enable_on_vim_startup = 1
  vim.g.indeng_guides_default_mapping = 0
  vim.g.indeng_guides_guide_size  = 1
  vim.g.indeng_guides_color_change_percent  = 5
  vim.g.indeng_guides_start_level = 2
  vim.g.indeng_guides_exclude_filetypes = {
    "help", "denite", "denite-filter", "startify", "vista", "vista_kind", "tagbar"
  }
end

return M
