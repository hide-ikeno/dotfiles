return {
  -- Packer can manage itself as an optional plugin { "wbthomason/packer.nvim", opt = true },
  { "wbthomason/packer.nvim", opt = true },

  { "nvim-lua/plenary.nvim" },

  -- Fix CursorHold performance
  -- TODO: remove it if https://github.com/neovim/neovim/issues/12587 is fixed.
  {
    "antoinemadec/FixCursorHold.nvim",
    config = [[vim.g.cursorhold_updatetime = 100]],
  },

  -- Seemless navigation between Tmux and (Neo)Vim
  {
    "christoomey/vim-tmux-navigator",
    setup = function()
      vim.g.tmux_navigator_no_mappings = 1

      -- Key mappings
      local opt = {noremap = true, silent = true}
      vim.api.nvim_set_keymap("n", "<M-h>", "<cmd>TmuxNavigateLeft<CR>",  opt)
      vim.api.nvim_set_keymap("n", "<M-j>", "<cmd>TmuxNavigateDown<CR>",  opt)
      vim.api.nvim_set_keymap("n", "<M-k>", "<cmd>TmuxNavigateUp<CR>",    opt)
      vim.api.nvim_set_keymap("n", "<M-l>", "<cmd>TmuxNavigateRight<CR>", opt)

      vim.api.nvim_set_keymap("t", "<M-h>", "<cmd>TmuxNavigateLeft<CR>",  opt)
      vim.api.nvim_set_keymap("t", "<M-j>", "<cmd>TmuxNavigateDown<CR>",  opt)
      vim.api.nvim_set_keymap("t", "<M-k>", "<cmd>TmuxNavigateUp<CR>",    opt)
      vim.api.nvim_set_keymap("t", "<M-l>", "<cmd>TmuxNavigateRight<CR>", opt)
    end
  },

  -- Better whitespace highlighting
  {
    "ntpeters/vim-better-whitespace",
    event = {"BufNewFile *", "BufRead *"},
    setup = function()
      vim.g.better_whitespace_enabled     = 1
      vim.g.strip_whitespace_on_save      = 1
      vim.g.show_spaces_that_precede_tabs = 1
      vim.g.better_whitespace_filetypes_blacklist = {
        'diff', 'gitcommit', 'defx', 'denite', 'qf', 'help', 'markdown', 'packer', 'which_key'
      }

      vim.api.nvim_set_keymap("n", "<Leader>x", "<cmd>StripWhitespace<CR>", {noremap = true, silent = true})
    end
  },

  -- Show keybindings in popup
  {
    "liuchengxu/vim-which-key",
    cmd = {"WhichKey", "WhichKeyVisual"},
    setup = "require'conf.vim-which-key'.setup()",
    config = "require'conf.vim-which-key'.config()",
  },
}

