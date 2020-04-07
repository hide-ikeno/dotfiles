local M = {}

function M.hook_add()
  local options = {noremap = true, silent = true}
  vim.api.nvim_set_keymap("n", "<Space>gs", "<cmd>Gina status<CR>",         options)
  vim.api.nvim_set_keymap("n", "<Space>gb", "<cmd>Gina branch<CR>",         options)
  vim.api.nvim_set_keymap("n", "<Space>gc", "<cmd>Gina commit<CR>",         options)
  vim.api.nvim_set_keymap("n", "<Space>gC", "<cmd>Gina commit --amend<CR>", options)
  vim.api.nvim_set_keymap("n", "<Space>gt", "<cmd>Gina tag<CR>",            options)
  vim.api.nvim_set_keymap("n", "<Space>gl", "<cmd>Gina log<CR>",            options)
  vim.api.nvim_set_keymap("n", "<Space>gL", "<cmd>Gina log :%<CR>",         options)
  vim.api.nvim_set_keymap("n", "<Space>gf", "<cmd>Gina ls<CR>",             options)
end

function M.hook_post_source()
  local options = {noremap = true, silent = true}
  vim.fn["gina#custom#command#option"]("commit", "-v|--verbose")
  vim.fn["gina#custom#command#option"]([[/\%(status\|commit\)]], "-u|--untracked-files")
  vim.fn["gina#custom#command#option"]("status", "-b|--branch")
  vim.fn["gina#custom#command#option"]("status", "-s|--short")
  vim.fn["gina#custom#command#option"]([[/\%(commit\|tag\)]], "--restore")
  vim.fn["gina#custom#command#option"]("show", "--show-signature")

  vim.fn["gina#custom#action#alias"]("branch", "track",  "checkout:track")
  vim.fn["gina#custom#action#alias"]("branch", "merge",  "commit:merge")
  vim.fn["gina#custom#action#alias"]("branch", "rebase", "commit:rebase")
  vim.fn["gina#custom#action#alias"]([[/\%(blame\|log\|reflog\)]], "preview", "topleft show:commit:preview")
  vim.fn["gina#custom#action#alias"]([[/\%(blame\|log\|reflog\)]], "changes", "topleft changes:of:preview")

  vim.fn["gina#custom#mapping#nmap"]("branch", "g<CR>", "<Plug>(gina-commit-checkout-track)")
  vim.fn["gina#custom#mapping#nmap"]("status", "<C-^>", ":<C-u>Gina commit<CR>", options)
  vim.fn["gina#custom#mapping#nmap"]("commit", "<C-^>", ":<C-u>Gina status<CR>", options)
  vim.fn["gina#custom#mapping#nmap"]("status", "<C-6>", ":<C-u>Gina commit<CR>", options)
  vim.fn["gina#custom#mapping#nmap"]("commit", "<C-6>", ":<C-u>Gina status<CR>", options)
  vim.fn["gina#custom#mapping#nmap"]([[/\%(blame\|log\|reflog\)]], "p",
    "<cmd>call gina#action#call(''preview'')<CR>", options)
  vim.fn["gina#custom#mapping#nmap"]([[/\%(blame\|log\|reflog\)]],
    "c", "<cmd>call gina#action#call(''changes'')<CR>", options)

  vim.fn["gina#custom#execute"]([[/\%(ls\|log\|reflog\|grep\)]], "setlocal noautoread")
  vim.fn["gina#custom#execute"]([[/\%(status\|branch\|ls\|log\|reflog\|grep\)]], "setlocal cursorline")
end

return M
