local M = {}
local nvim_set_keymap = vim.api.nvim_set_keymap

function M.hook_add()
  vim.g.tmux_navigator_no_mappings = 1

  -- Key mappings
  local options = {noremap = true, silent = true}
  nvim_set_keymap("n", "<M-h>", "<cmd>TmuxNavigateLeft<CR>",     options)
  nvim_set_keymap("n", "<M-j>", "<cmd>TmuxNavigateDown<CR>",     options)
  nvim_set_keymap("n", "<M-k>", "<cmd>TmuxNavigateUp<CR>",       options)
  nvim_set_keymap("n", "<M-l>", "<cmd>TmuxNavigateRight<CR>",    options)
  nvim_set_keymap("n", "<M-\\>","<cmd>TmuxNavigatePrevious<CR>", options)

  nvim_set_keymap("t", "<M-h>", "<cmd>TmuxNavigateLeft<CR>",     options)
  nvim_set_keymap("t", "<M-j>", "<cmd>TmuxNavigateDown<CR>",     options)
  nvim_set_keymap("t", "<M-k>", "<cmd>TmuxNavigateUp<CR>",       options)
  nvim_set_keymap("t", "<M-l>", "<cmd>TmuxNavigateRight<CR>",    options)
end

return M
