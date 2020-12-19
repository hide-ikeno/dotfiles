local M = {}

function M.setup()
  vim.api.nvim_set_keymap("n", "p", "<Plug>(miniyank-autoput)", {})
  vim.api.nvim_set_keymap("n", "P", "<Plug>(miniyank-autoPut)", {})
end

return M
