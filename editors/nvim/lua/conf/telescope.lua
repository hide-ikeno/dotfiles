local M = {}

function M.setup()
  -- variables

  -- key mappings
  local opts = {noremap = true, silent = true}
  vim.api.nvim_set_keymap("n", "<Space>b", "<cmd>lua require'telescope.builtin'.buffers{ shorten_path = true }<CR>", opts)
  vim.api.nvim_set_keymap("n", "<Space>f", "<cmd>lua require'telescope.builtin'.find_files{}<CR>", opts)
  vim.api.nvim_set_keymap("n", "<Space>p", "<cmd>lua require'telescope.builtin'.git_files{ shorten_path = true }<CR>", opts)
  vim.api.nvim_set_keymap("n", "<Space>o", "<cmd>lua require'telescope.builtin'.oldfiles{}<CR>", opts)
  vim.api.nvim_set_keymap("n", "<Space>r", "<cmd>lua require'telescope.builtin'.lsp_references{}<CR>", opts)
  vim.api.nvim_set_keymap("n", "<Space>s", "<cmd>lua require'telescope.builtin'.lsp_document_symbols{}<CR>", opts)
  vim.api.nvim_set_keymap("n", "<Space>S", "<cmd>lua require'telescope.builtin'.lsp_workspace_symbols{}<CR>", opts)
  vim.api.nvim_set_keymap("n", "<Space>t", "<cmd>lua require'telescope.builtin'.treesitter{}<CR>", opts)
  vim.api.nvim_set_keymap("n", "<Space>;", "<cmd>lua require'telescope.builtin'.command_history{}<CR>", opts)

  vim.api.nvim_set_keymap("n", "<Space>/", "<cmd>lua require'telescope.builtin'.live_grep{ shorten_path = true }<CR>", opts)
  vim.api.nvim_set_keymap("n", "<Space>G", "<cmd>lua require'telescope.builtin'.grep_string{ shorten_path = true }<CR>", opts)
  vim.api.nvim_set_keymap("n", "<Space>l", "<cmd>lua require'telescope.builtin'.current_buffer_fuzzy_find{}<CR>", opts)
end

return M
