local M = {}

function M.setup()
  vim.g.nvim_tree_indent_markers = 1
  vim.g.nvim_tree_bindings = {
    edit = {"<CR>", "l"},
    edit_vsplit = {"<C-v>", "|"},
    edit_split = {"<C-x>", "-"},
    close_node = {"<S-CR>", "<BS>", "h"},
  }

  vim.api.nvim_set_keymap("n", "<Space>e", "<cmd>NvimTreeToggle<CR>", {noremap = true, silent = true})
end

return M
