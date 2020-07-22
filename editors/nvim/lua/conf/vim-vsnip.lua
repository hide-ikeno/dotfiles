local M = {}

function M.setup()
  -- variables
  -- Uer snippet directory
  vim.g.vsnip_snippet_dir = vim.fn.stdpath("config") .. "/vsnip"
  -- Plugin snippets directories
  vim.g.vsnip_snippet_dirs = { vim.fn.stdpath("config") .. "/snippets" }

  -- key mappings
  local opts = {silent = true, expr = true}

  vim.api.nvim_set_keymap(
    "i", "<C-k>", [[vsnip#available(1) ? '<Plug>(vsnip-expand)' : '<C-k>']], opts
    )
  vim.api.nvim_set_keymap(
    "s", "<C-k>", [[vsnip#available(1) ? '<Plug>(vsnip-expand)' : '<C-k>']], opts
    )
  vim.api.nvim_set_keymap(
    "i", "<C-l>", [[vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>']], opts
    )
  vim.api.nvim_set_keymap(
    "i", "<C-f>", [[vsnip#available(1) ? '<Plug>(vsnip-jump-next)' : '<C-f>']], opts
    )
  vim.api.nvim_set_keymap(
    "s", "<C-f>", [[vsnip#available(1) ? '<Plug>(vsnip-jump-next)' : '<C-f>']], opts
    )
  vim.api.nvim_set_keymap(
    "i", "<C-b>", [[vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-b>']], opts
    )
  vim.api.nvim_set_keymap(
    "s", "<C-b>", [[vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)' : '<C-b>']], opts
    )
end

return M
