local M = {}

function M.setup()
  vim.g.caw_no_default_keymappings = 1
  vim.api.nvim_set_keymap("n", "<Leader>cc", "<Plug>(caw:hatpos:toggle)",     {silent = true})
  vim.api.nvim_set_keymap("x", "<Leader>cc", "<Plug>(caw:hatpos:toggle)",     {silent = true})
  vim.api.nvim_set_keymap("n", "<Leader>ca", "<Plug>(caw:dollarpos:toggle)",  {silent = true})
  vim.api.nvim_set_keymap("x", "<Leader>ca", "<Plug>(caw:dollarpos:toggle)",  {silent = true})
  vim.api.nvim_set_keymap("n", "<Leader>cb", "<Plug>(caw:box:toggle)",        {silent = true})
  vim.api.nvim_set_keymap("x", "<Leader>cb", "<Plug>(caw:box:toggle)",        {silent = true})
  vim.api.nvim_set_keymap("n", "<Leader>cw", "<Plug>(caw:wrap:toggle)",       {silent = true})
  vim.api.nvim_set_keymap("x", "<Leader>cw", "<Plug>(caw:wrap:toggle)",       {silent = true})
  vim.api.nvim_set_keymap("n", "<Leader>c]", "<Plug>(caw:jump:comment-next)", {silent = true})
  vim.api.nvim_set_keymap("n", "<Leader>c[", "<Plug>(caw:jump:comment-prev)", {silent = true})
end

function M.config()
end

return M

