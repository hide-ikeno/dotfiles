local M = {}

function M.hook_add()
  vim.g.textobj_line_no_default_key_mappings = 1
  vim.api.nvim_set_keymap("o", "al", "<Plug>(textobj-line-a)", {})
  vim.api.nvim_set_keymap("o", "il", "<Plug>(textobj-line-i)", {})
  vim.api.nvim_set_keymap("x", "al", "<Plug>(textobj-line-a)", {})
  vim.api.nvim_set_keymap("x", "il", "<Plug>(textobj-line-i)", {})
end

return M
