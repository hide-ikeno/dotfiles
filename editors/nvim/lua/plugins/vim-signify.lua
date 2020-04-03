local M = {}

function M.hook_add()
  vim.api.nvim_set_keymap("n", "<Leader>gd", "<cmd>SignifyDiff<CR>",     {silent = true, noremap = true})
  vim.api.nvim_set_keymap("n", "<Leader>gp", "<cmd>SignifyHunkDiff<CR>", {silent = true, noremap = true})
  vim.api.nvim_set_keymap("n", "<Leader>gu", "<cmd>SignifyHunkUndo<CR>", {silent = true, noremap = true})

  vim.api.nvim_set_keymap("n", "<Leader>gk", "<Plug>(signify-prev-hunk)", {silent = true})
  vim.api.nvim_set_keymap("n", "<Leader>gj", "<Plug>(signify-next-hunk)", {silent = true})

  vim.api.nvim_set_keymap("o", "ih", "<Plug>(signify-inner-pending)", {silent = true})
  vim.api.nvim_set_keymap("x", "ih", "<Plug>(signify-inner-visual)",  {silent = true})
  vim.api.nvim_set_keymap("o", "ah", "<Plug>(signify-outer-pending)", {silent = true})
  vim.api.nvim_set_keymap("x", "ah", "<Plug>(signify-outer-visual)",  {silent = true})
end

return M