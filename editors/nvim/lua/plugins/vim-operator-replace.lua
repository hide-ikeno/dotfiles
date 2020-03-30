local M = {}

function M.hook_add()
  vim.api.nvim_set_keymap("n", "_", "<Plug>(operator-replace)", {})
  vim.api.nvim_set_keymap("x", "_", "<Plug>(operator-replace)", {})
end

return M
