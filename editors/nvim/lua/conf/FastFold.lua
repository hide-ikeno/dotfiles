local M = {}

function M.hook_add()
  -- Global variables
  vim.g.fastfold_savehook = 1
  vim.g.fastfold_fold_command_suffixes  = {"x","X","a","A","o","O","c","C"}
  vim.g.fastfold_fold_movement_commands = {"]z", "[z", "zj", "zk"}

  -- Key mappings
  vim.api.nvim_set_keymap("n", "zuz", "<Plug>(FastFoldUpdate)", {})
  vim.api.nvim_set_keymap("x", "iz",
    [[:<C-u>FastFoldUpdate<CR><ESC>:<C-u>normal! ]zv[z<CR>]], {})
  vim.api.nvim_set_keymap("x", "az",
    [[:<C-u>FastFoldUpdate<CR><ESC>:<C-u>normal! ]zV[z<CR>]], {})
end

return M
