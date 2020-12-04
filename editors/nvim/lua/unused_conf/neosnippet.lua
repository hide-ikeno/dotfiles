local M = {}

function M.setup()
  vim.g["neosnippet#enable_snipmate_compatibility"] = 1
  vim.g["neosnippet#enable_completed_snippet"]      = 1
  vim.g["neosnippet#enable_complete_done"]          = 1
  vim.g["neosnippet#expand_word_boundary"]          = 1
  vim.g["neosnippet#snippets_directory"]            = vim.fn.stdpath("config") .. "/snippets"
  vim.g["neosnippet#data_directory"]                = vim.fn.stdpath("cache") .. "/neosnippet"

  local options = {silent = true}
  vim.api.nvim_set_keymap("i", "<C-s>", "<Plug>(neosnippet_jump_or_expand)", options)
  vim.api.nvim_set_keymap("s", "<C-s>", "<Plug>(neosnippet_jump_or_expand)", options)
  vim.api.nvim_set_keymap("x", "<C-s>", "<Plug>(neosnippet_expand_target)",  options)
end

return M
