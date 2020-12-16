local M = {}

function M.setup()
  vim.api.nvim_set_keymap("n", "J", "<Plug>(jplus)", {})
  vim.api.nvim_set_keymap("v", "J", "<Plug>(jplus)", {})
  vim.api.nvim_set_keymap("n", "<Leader>J", "<Plug>(jplus-input)", {})
  vim.api.nvim_set_keymap("v", "<Leader>J", "<Plug>(jplus-input)", {})
end

return M
