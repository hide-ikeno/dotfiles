local M = {}

function M.setup()
  vim.g.tmux_navigator_no_mappings = 1

  -- Key mappings
  local opt = { noremap = true, silent = true }
  vim.api.nvim_set_keymap("n", "<M-h>", "<cmd>TmuxNavigateLeft<CR>", opt)
  vim.api.nvim_set_keymap("n", "<M-j>", "<cmd>TmuxNavigateDown<CR>", opt)
  vim.api.nvim_set_keymap("n", "<M-k>", "<cmd>TmuxNavigateUp<CR>", opt)
  vim.api.nvim_set_keymap("n", "<M-l>", "<cmd>TmuxNavigateRight<CR>", opt)
  vim.api.nvim_set_keymap("t", "<M-h>", "<cmd>TmuxNavigateLeft<CR>", opt)
  vim.api.nvim_set_keymap("t", "<M-j>", "<cmd>TmuxNavigateDown<CR>", opt)
  vim.api.nvim_set_keymap("t", "<M-k>", "<cmd>TmuxNavigateUp<CR>", opt)
  vim.api.nvim_set_keymap("t", "<M-l>", "<cmd>TmuxNavigateRight<CR>", opt)
end

return M
