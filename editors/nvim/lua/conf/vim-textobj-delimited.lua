local M = {}

function M.hook_add()
  vim.g.textobj_delimited_no_default_key_mappings = 1
  vim.api.nvim_set_keymap("o", "ad", "<Plug>(textobj-delimited-forward-a)", {})
  vim.api.nvim_set_keymap("o", "id", "<Plug>(textobj-delimited-forward-i)", {})
  vim.api.nvim_set_keymap("x", "ad", "<Plug>(textobj-delimited-forward-a)", {})
  vim.api.nvim_set_keymap("x", "id", "<Plug>(textobj-delimited-forward-i)", {})
  vim.api.nvim_set_keymap("o", "aD", "<Plug>(textobj-delimited-backward-a)", {})
  vim.api.nvim_set_keymap("o", "iD", "<Plug>(textobj-delimited-backward-i)", {})
  vim.api.nvim_set_keymap("x", "aD", "<Plug>(textobj-delimited-backward-a)", {})
  vim.api.nvim_set_keymap("x", "iD", "<Plug>(textobj-delimited-backward-i)", {})
end

return M
