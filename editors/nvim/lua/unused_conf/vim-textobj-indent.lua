local M = {}

function M.hook_add()
  vim.g.textobj_indent_no_default_key_mappings = 1
  vim.api.nvim_set_keymap("o", "ai", "<Plug>(textobj-indent-a)", {})
  vim.api.nvim_set_keymap("o", "ii", "<Plug>(textobj-indent-i)", {})
  vim.api.nvim_set_keymap("x", "ai", "<Plug>(textobj-indent-a)", {})
  vim.api.nvim_set_keymap("x", "ii", "<Plug>(textobj-indent-i)", {})
  vim.api.nvim_set_keymap("o", "aI", "<Plug>(textobj-indent-same-a)", {})
  vim.api.nvim_set_keymap("o", "iI", "<Plug>(textobj-indent-same-i)", {})
  vim.api.nvim_set_keymap("x", "aI", "<Plug>(textobj-indent-same-a)", {})
  vim.api.nvim_set_keymap("x", "iI", "<Plug>(textobj-indent-same-i)", {})
end

return M
