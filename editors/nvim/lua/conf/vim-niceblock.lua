local M = {}

function M.hook_add()
  vim.api.nvim_set_keymap("x", "I", "<Plug>(niceblock-I)", {})
  vim.api.nvim_set_keymap("x", "A", "<Plug>(niceblock-A)", {})
end

return M
