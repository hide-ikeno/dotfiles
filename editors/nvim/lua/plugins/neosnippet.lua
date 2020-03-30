local M = {}

function M.hook_add()
  vim.g["neosnippet#enable_snipmate_compatibility"] = 1
  vim.g["neosnippet#enable_completed_snippet"] = 1
  vim.g["neosnippet#expand_word_boundary"] = 1
  vim.g["neosnippet#snippets_directory"] = vim.env.VIM_CONFIG_HOME .. "/snippets"

  local options = {silent = true}
  vim.api.nvim_set_keymap("i", "<C-s>", "<Plug>(neosnippet_jump_or_expand)", options)
  vim.api.nvim_set_keymap("s", "<C-s>", "<Plug>(neosnippet_jump_or_expand)", options)
  vim.api.nvim_set_keymap("x", "<C-s>", "<Plug>(neosnippet_expand_target)",  options)
end

return M
