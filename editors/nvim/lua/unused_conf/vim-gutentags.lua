local M = {}

function M.setup()
  vim.g["gutentags_cache_dir"]                = vim.fn.stdpath("cache") .. "/tags"
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
