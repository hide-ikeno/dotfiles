local M = {}

function M.setup()
  vim.api.nvim_set_keymap("n", "\\<Space>gd", "<cmd>SignifyDiff<CR>",     {silent = true, noremap = true})
  vim.api.nvim_set_keymap("n", "\\<Space>gp", "<cmd>SignifyHunkDiff<CR>", {silent = true, noremap = true})
  vim.api.nvim_set_keymap("n", "\\<Space>gu", "<cmd>SignifyHunkUndo<CR>", {silent = true, noremap = true})

  vim.api.nvim_set_keymap("n", "\\<Space>g[", "<Plug>(signify-prev-hunk)", {silent = true})
  vim.api.nvim_set_keymap("n", "\\<Space>g]", "<Plug>(signify-next-hunk)", {silent = true})

  vim.api.nvim_set_keymap("o", "ih", "<Plug>(signify-inner-pending)", {silent = true})
  vim.api.nvim_set_keymap("x", "ih", "<Plug>(signify-inner-visual)",  {silent = true})
  vim.api.nvim_set_keymap("o", "ah", "<Plug>(signify-outer-pending)", {silent = true})
  vim.api.nvim_set_keymap("x", "ah", "<Plug>(signify-outer-visual)",  {silent = true})
end

return M
