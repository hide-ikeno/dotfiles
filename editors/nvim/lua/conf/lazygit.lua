local M = {}

function M.setup()
  -- transparency of floating window
  vim.g.lazygit_floating_window_winblend = 0
  -- scaling factor for floating window
  vim.g.lazygit_floating_window_scaling_factor = 0.9
  -- customize lazygit popup window corner characters
  vim.g.lazygit_floating_window_corner_chars = {'╭', '╮', '╰', '╯'}
  -- for neovim-remote support
  vim.g.lazygit_use_neovim_remote = 0

  -- key bindings
  vim.api.nvim_set_keymap("n", "<Space>gs", "<cmd>LazyGit<CR>", {noremap=true, silent=true})
end

return M
