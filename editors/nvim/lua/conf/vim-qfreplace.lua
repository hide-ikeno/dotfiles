local M = {}

function M.config()
  vim.cmd("augroup qfreplace_setup")
  vim.cmd("autocmd!")
  vim.api.nvim_buf_set_keymap(0, "n", "R", "<cmd>Qfreplace<CR>", {noremap = true})
  vim.cmd("augroup END")
end

return M
