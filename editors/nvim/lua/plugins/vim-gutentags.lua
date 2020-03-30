local M = {}

function M.hook_add()
  vim.g["gutentags_cache_dir"]                = vim.env.VIM_CACHE_HOME .. "/tags"
  vim.g["gutentags_generate_on_missing"]      = 0
  vim.g["gutentags_generate_on_new"]          = 0
  vim.g["gutentags_generate_on_save"]         = 1
  vim.g["gutentags_exclude_filetype"]         = {}
  vim.g["gutentags_ctags_exclude_wildignore"] = 1
  vim.g["gutentags_ctags_exclude"]            = {
    "*/build", "*/wp-admin", "*/wp-content", "*/wp-includes",
    "*/application/vendor", "*/vendor/ckeditor", "*/media/vendor"
  }
end

return M
