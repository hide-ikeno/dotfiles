local M = {}

function M.hook_add()
  vim.g.textobj_url_no_default_key_mappings = 1
  vim.api.nvim_set_keymap("o", "au", "<Plug>(textobj-line-a)", {})
  vim.api.nvim_set_keymap("o", "iu", "<Plug>(textobj-line-i)", {})
  vim.api.nvim_set_keymap("x", "au", "<Plug>(textobj-line-a)", {})
  vim.api.nvim_set_keymap("x", "iu", "<Plug>(textobj-line-i)", {})
end

return M
