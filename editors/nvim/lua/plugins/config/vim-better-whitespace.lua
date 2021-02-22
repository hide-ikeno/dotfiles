local M = {}

function M.setup()
  vim.g.better_whitespace_enabled = 1
  vim.g.strip_whitespace_on_save = 1
  vim.g.show_spaces_that_precede_tabs = 1
  vim.g.better_whitespace_filetypes_blacklist =
    {
      'diff',
      'gitcommit',
      'defx',
      'denite',
      'qf',
      'help',
      'markdown',
      'packer',
      'which_key',
    }

  vim.api.nvim_set_keymap(
    "n", "<Leader>x", "<cmd>StripWhitespace<CR>",
    { noremap = true, silent = true }
  )
end

return M
