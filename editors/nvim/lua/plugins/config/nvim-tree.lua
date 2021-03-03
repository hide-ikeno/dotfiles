local M = {}

function M.setup()
  vim.api.nvim_set_keymap(
    "n", "<Space>t", "<cmd>NvimTreeToggle<CR>",
    { noremap = true, silent = true }
  )
end

function M.config()
  vim.g.nvim_tree_width = 40
  vim.g.nvim_tree_indent_markers = 1
  vim.g.nvim_tree_icons = {
    default = '',
    symlink = '',
    git = {
      unstaged = "✗",
      staged = "✓",
      unmerged = "",
      renamed = "➜",
      untracked = "★",
    },
    folder = {
      default = "",
      open = "",
      empty = "",
      empty_open = "",
      symlink = "",
    },
  }
  vim.g.nvim_tree_bindings = {
    ["l"] = "<cmd>lua require'nvim-tree'.on_keypress('edit')<CR>",
    ["h"] = "<cmd>lua require'nvim-tree'.on_keypress('close_node')<CR>",
  }
end

return M
