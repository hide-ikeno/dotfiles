return {
  -- Enable repeating supported plugin maps with "."
  { "tpope/vim-repeat" },

  -- Even better % navigation and highlight mathching words
  { "andymass/vim-matchup", event = { "CursorHold" } },

  -- Imporove foldtext for better looks
  { "lambdalisue/readablefold.vim" },

  -- Enhanced f/t
  {
    "hrsh7th/vim-eft",
    keys = {
      { "n", "<Plug>(eft-" },
      { "o", "<Plug>(eft-" },
      { "x", "<Plug>(eft-" },
    },
    setup = function()
      vim.api.nvim_set_keymap("n", "f", "<Plug>(eft-f-repeatable)", {})
      vim.api.nvim_set_keymap("x", "f", "<Plug>(eft-f-repeatable)", {})
      vim.api.nvim_set_keymap("o", "f", "<Plug>(eft-f-repeatable)", {})
      vim.api.nvim_set_keymap("n", "F", "<Plug>(eft-F-repeatable)", {})
      vim.api.nvim_set_keymap("x", "F", "<Plug>(eft-F-repeatable)", {})
      vim.api.nvim_set_keymap("o", "F", "<Plug>(eft-F-repeatable)", {})

      vim.api.nvim_set_keymap("n", "t", "<Plug>(eft-t-repeatable)", {})
      vim.api.nvim_set_keymap("x", "t", "<Plug>(eft-t-repeatable)", {})
      vim.api.nvim_set_keymap("o", "t", "<Plug>(eft-t-repeatable)", {})
      vim.api.nvim_set_keymap("n", "T", "<Plug>(eft-T-repeatable)", {})
      vim.api.nvim_set_keymap("x", "T", "<Plug>(eft-T-repeatable)", {})
      vim.api.nvim_set_keymap("o", "T", "<Plug>(eft-T-repeatable)", {})
    end,
  },

  -- Make blockwise visual mode more useful
  {
    "kana/vim-niceblock",
    keys = { { "v", "<Plug>(niceblock-" } },
    setup = function()
      vim.g.niceblock_no_default_key_mappings = 1
      vim.api.nvim_set_keymap("v", "I", "<Plug>(niceblock-I)", {})
      vim.api.nvim_set_keymap("v", "gI", "<Plug>(niceblock-gI)", {})
      vim.api.nvim_set_keymap("v", "A", "<Plug>(niceblock-A)", {})
    end,
  },

  -- Smart line join
  {
    "osyo-manga/vim-jplus",
    keys = {
      { "n", "<Plug>(jplus)" },
      { "v", "<Plug>(jplus)" },
      { "n", "<Plug>(jplus-input)" },
      { "v", "<Plug>(jplus-input)" },
    },
    setup = function()
      vim.api.nvim_set_keymap("n", "J", "<Plug>(jplus)", {})
      vim.api.nvim_set_keymap("v", "J", "<Plug>(jplus)", {})
      vim.api.nvim_set_keymap("n", "<Leader>J", "<Plug>(jplus-input)", {})
      vim.api.nvim_set_keymap("v", "<Leader>J", "<Plug>(jplus-input)", {})
    end,
  },

  -- The killring-alike plugin with no default mappings.
  -- (Use this plugin until https://github.com/neovim/neovim/issues/1822 is fixed)
  {
    "bfredl/nvim-miniyank",
    keys = { { "n", "<Plug>(miniyank-" } },
    setup = function()
      vim.g.miniyank_maxitems = 100
      vim.api.nvim_set_keymap("n", "p", "<Plug>(miniyank-autoput)", {})
      vim.api.nvim_set_keymap("n", "P", "<Plug>(miniyank-autoPut)", {})
    end,
  },

  -- Show keybindings in popup
  {
    "liuchengxu/vim-which-key",
    cmd = { "WhichKey", "WhichKeyVisual" },
    setup = "require'conf.vim-which-key'.setup()",
    config = "require'conf.vim-which-key'.config()",
  },

  -- A high-performance color highlighter for NeoVim
  {
    "norcalli/nvim-colorizer.lua",
    cmd = {
      "ColorizerAttachToBuffer",
      "ColorizerDetachFromBuffer",
      "ColorizerReloadAllBuffers",
      "ColorizerToggle",
    },
    config = function() require'colorizer'.setup() end,
  },

  -- Breakdown Vim's --startuptime output
  { "tweekmonster/startuptime.vim", cmd = "StartupTime" },
}
