return {
  -- Asynchronously control git repositories
  -- { "lambdalisue/gina.vim", cmd = {"Gina"} },

  -- Calling LazyGit from within neovim
  {
    "kdheepak/lazygit.nvim",
    cmd = { "LazyGit", "LazyGitFilter", "LazyGitConfig" },
    setup = function()
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
  },

  -- Git signs written in pure lua
  {
    "lewis6991/gitsigns.nvim",
    branch = "main",
    requires = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("gitsigns").setup {
        signs = {
          add          = {hl = 'DiffAdd'   , text = '│'},
          change       = {hl = 'DiffChange', text = '│'},
          delete       = {hl = 'DiffDelete', text = '_'},
          topdelete    = {hl = 'DiffDelete', text = '_'},
          changedelete = {hl = 'DiffChange', text = '~'},
        },
        keymaps = {
          [']c']         = '<cmd>lua require("gitsigns").next_hunk()<CR>',
          ['[c']         = '<cmd>lua require("gitsigns").prev_hunk()<CR>',
          ['<leader>hs'] = '<cmd>lua require("gitsigns").stage_hunk()<CR>',
          ['<leader>hu'] = '<cmd>lua require("gitsigns").undo_stage_hunk()<CR>',
          ['<leader>hr'] = '<cmd>lua require("gitsigns").reset_hunk()<CR>',
        },
        watch_index = {
          enabled = true,
          interval = 1000
        }
      }
    end
  },

  -- Reveal the commit messages under the cursor
  {
    "rhysd/git-messenger.vim",
    cmd = { "GitMessenger" },
    keys = { "n", "<Plug>(git-messenger" },
    setup = function()
      vim.g.git_messenger_no_default_mappings = true
      vim.api.nvim_set_keymap("n", "<Space>gm", "<Plug>(git-messenger)", {silent = true})
    end
  },

  -- More pleasant editing on commit messsages
  {
    "rhysd/committia.vim",
    event = {"BufEnter COMMIT_EDITMSG"},
    setup = function()
      vim.g.committia_min_window_width = 100
    end
  },

  -- disabled until https://github.com/f-person/git-blame.nvim/issues/11 is solved
  {
    "f-person/git-blame.nvim",
    event = {"BufRead *", "BufNewFile *"},
  }
}
