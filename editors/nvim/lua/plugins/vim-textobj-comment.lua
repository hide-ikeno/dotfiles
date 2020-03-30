local M = {}

function M.hook_add()
  vim.g.textobj_comment_no_default_key_mappings = 1

  vim.api.nvim_set_keymap("o", "ac", "<Plug>(textobj-comment-a)", {})
  vim.api.nvim_set_keymap("o", "ic", "<Plug>(textobj-comment-i)", {})
  vim.api.nvim_set_keymap("x", "ac", "<Plug>(textobj-comment-a)", {})
  vim.api.nvim_set_keymap("x", "ic", "<Plug>(textobj-comment-i)", {})
end

return M
