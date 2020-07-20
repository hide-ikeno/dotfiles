local M = {}

function M.hook_add()
  vim.api.nvim_set_keymap("n", "<Leader>a", "<Plug>(EasyAlign)", {silent = true})
  vim.api.nvim_set_keymap("v", "<Leader>a", "<Plug>(EasyAlign)", {silent = true})
end

return M
