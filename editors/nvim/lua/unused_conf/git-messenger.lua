local M = {}

function M.setup()
  vim.g.git_messenger_no_default_mappings = true
  vim.api.nvim_set_keymap("n", "gm", "<cmd>GitMessenger<CR>", {silent = true})
end


return M
