local M = {}

function M.setup()
  vim.api.nvim_set_keymap("n", "<Leader>a", "<Plug>(EasyAlign)", {silent = true})
  vim.api.nvim_set_keymap("v", "<Leader>a", "<Plug>(EasyAlign)", {silent = true})
end

return M
