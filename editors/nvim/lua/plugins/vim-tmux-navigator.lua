-- vim-tmux-navigator
local function setup()
  vim.g.tmux_navigator_no_mappings = 1
  vim.api.nvim_set_keymap("n", "<M-h>",  "<cmd>TmuxNavigateLeft<CR>",     {noremap = true, silent = true})
  vim.api.nvim_set_keymap("n", "<M-j>",  "<cmd>TmuxNavigateDown<CR>",     {noremap = true, silent = true})
  vim.api.nvim_set_keymap("n", "<M-k>",  "<cmd>TmuxNavigateUp<CR>",       {noremap = true, silent = true})
  vim.api.nvim_set_keymap("n", "<M-l>",  "<cmd>TmuxNavigateRight<CR>",    {noremap = true, silent = true})
  vim.api.nvim_set_keymap("n", "<M-\\>", "<cmd>TmuxNavigatePrevious<CR>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap("t", "<M-h>",  "<cmd>TmuxNavigateLeft<CR>",     {noremap = true, silent = true})
  vim.api.nvim_set_keymap("t", "<M-j>",  "<cmd>TmuxNavigateDown<CR>",     {noremap = true, silent = true})
  vim.api.nvim_set_keymap("t", "<M-k>",  "<cmd>TmuxNavigateUp<CR>",       {noremap = true, silent = true})
  vim.api.nvim_set_keymap("t", "<M-l>",  "<cmd>TmuxNavigateRight<CR>",    {noremap = true, silent = true})
  vim.api.nvim_set_keymap("t", "<M-\\>", "<cmd>TmuxNavigatePrevious<CR>", {noremap = true, silent = true})
end

return { setup = setup }
