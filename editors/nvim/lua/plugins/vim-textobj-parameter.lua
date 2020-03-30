local M = {}

function M.hook_add()
  vim.g.textobj_parameter_no_default_key_mappings = 1
  vim.api.nvim_set_keymap("o", "a,", "<Plug>(textobj-parameter-a)", {})
  vim.api.nvim_set_keymap("o", "i,", "<Plug>(textobj-parameter-i)", {})
  vim.api.nvim_set_keymap("x", "a,", "<Plug>(textobj-parameter-a)", {})
  vim.api.nvim_set_keymap("x", "i,", "<Plug>(textobj-parameter-i)", {})
end

return M
