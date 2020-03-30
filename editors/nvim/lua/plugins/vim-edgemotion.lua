local M = {}

function M.hook_add()
  vim.api.nvim_set_keymap("",  "gj", "<Plug>(edgemotion-j)", {})
  vim.api.nvim_set_keymap("",  "gk", "<Plug>(edgemotion-k)", {})
  vim.api.nvim_set_keymap("x", "gj", "<Plug>(edgemotion-j)", {})
  vim.api.nvim_set_keymap("x", "gk", "<Plug>(edgemotion-k)", {})
end

return M
