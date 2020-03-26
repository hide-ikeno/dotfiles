local plug = require("core.plug")

local layer = {}

function layer.register_plugins()
  plug.add_plugin("christoomey/vim-tmux-navigator")
end

function layer.init_config()
  vim.g.tmux_navigator_no_mappings = 1

  -- Key mappings
  local options = { noremap = true, silent = true }

  vim.api.nvim_set_keymap("n", "<M-h>", "<cmd>TmuxNavigateLeft<CR>",     options)
  vim.api.nvim_set_keymap("n", "<M-j>", "<cmd>TmuxNavigateDown<CR>",     options)
  vim.api.nvim_set_keymap("n", "<M-k>", "<cmd>TmuxNavigateUp<CR>",       options)
  vim.api.nvim_set_keymap("n", "<M-l>", "<cmd>TmuxNavigateRight<CR>",    options)
  vim.api.nvim_set_keymap("n", "<M-\\>","<cmd>TmuxNavigatePrevious<CR>", options)

  vim.api.nvim_set_keymap("t", "<M-h>", "<cmd>TmuxNavigateLeft<CR>",     options)
  vim.api.nvim_set_keymap("t", "<M-j>", "<cmd>TmuxNavigateDown<CR>",     options)
  vim.api.nvim_set_keymap("t", "<M-k>", "<cmd>TmuxNavigateUp<CR>",       options)
  vim.api.nvim_set_keymap("t", "<M-l>", "<cmd>TmuxNavigateRight<CR>",    options)
end

return layer
