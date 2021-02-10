return {
  -- Text objects & operators
  { "kana/vim-operator-user" },
  { "kana/vim-textobj-user" },
  {
    "kana/vim-operator-replace",
    requires = { "kana/vim-operator-user" },
    keys = {
      { "n", "<Plug>(operator-replace)" },
      { "x", "<Plug>(operator-replace)" },
    },
    setup = function()
      vim.api.nvim_set_keymap("n", "_", "<Plug>(operator-replace)", {})
      vim.api.nvim_set_keymap("x", "_", "<Plug>(operator-replace)", {})
    end,
  },
  {
    "machakann/vim-sandwich",
    keys = {
      { "n", "<Plug>(operator-sandwich-" },
      { "o", "<Plug>(operator-sandwich-" },
      { "x", "<Plug>(operator-sandwich-" },
      { "n", "<Plug>(textobj-sandwich-" },
      { "o", "<Plug>(textobj-sandwich-" },
      { "x", "<Plug>(textobj-sandwich-" },
    },
    setup = function()
      vim.g.sandwich_no_default_key_mappings = 1
      vim.g.operator_sandwich_no_default_key_mappings = 1
      vim.g.textobj_sandwich_no_default_key_mappings = 1

      -- Key mappings
      local opts = {silent = true}

      vim.api.nvim_set_keymap("n", "sd",
      "<Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)",
      opts)
      vim.api.nvim_set_keymap("n", "sr",
      "<Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)",
      opts)
      vim.api.nvim_set_keymap("n", "sd",
      "<Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)",
      opts)
      vim.api.nvim_set_keymap("n", "sr",
      "<Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)",
      opts)

      vim.api.nvim_set_keymap("n", "sa", "<Plug>(operator-sandwich-add)",     {})
      vim.api.nvim_set_keymap("x", "sa", "<Plug>(operator-sandwich-add)",     {})
      vim.api.nvim_set_keymap("o", "sa", "<Plug>(operator-sandwich-g@)",      {})
      vim.api.nvim_set_keymap("x", "sd", "<Plug>(operator-sandwich-delete)",  {})
      vim.api.nvim_set_keymap("x", "sr", "<Plug>(operator-sandwich-replace)", {})

      vim.api.nvim_set_keymap("o", "ab", "<Plug>(textobj-sandwich-auto-a)",  {})
      vim.api.nvim_set_keymap("o", "ib", "<Plug>(textobj-sandwich-auto-i)",  {})
      vim.api.nvim_set_keymap("x", "ab", "<Plug>(textobj-sandwich-auto-a)",  {})
      vim.api.nvim_set_keymap("x", "ib", "<Plug>(textobj-sandwich-auto-i)",  {})

      vim.api.nvim_set_keymap("o", "as", "<Plug>(textobj-sandwich-query-a)", {})
      vim.api.nvim_set_keymap("o", "is", "<Plug>(textobj-sandwich-query-i)", {})
      vim.api.nvim_set_keymap("x", "as", "<Plug>(textobj-sandwich-query-a)", {})
      vim.api.nvim_set_keymap("x", "is", "<Plug>(textobj-sandwich-query-i)", {})
    end,
    config =  function()
      vim.g["textobj#sandwich#stimeoutlen"] = 100
      -- vim.g["sandwich#recipes"] = vim.tbl_flatten({
      --   { buns = {'「', '」'} },
      --   { buns = {'【', '】'} },
      --   { buns = {'（', '）'} },
      --   { buns = {'『', '』'} },
      --   { buns = {[[\(]], [[\)]]},  filetype = {"vim"}, nesting = 1 },
      --   { buns = {[[\%(]], [[\)]]}, filetype = {"vim"}, nesting = 1 },
      --   vim.g["sandwich#default_recipes"]
      -- })
      vim.cmd[[ let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes) ]]
      vim.cmd[[
        let g:sandwich#recipes += [{'buns': ['「', '」']}, {'buns': ['【', '】']}, {'buns': ['（', '）']}, {'buns': ['『', '』']}]
      ]]
      vim.cmd[[
        let g:sandwich#recipes += [{'buns': ['\(',  '\)'], 'filetype': ['vim'], 'nesting': 1}]
      ]]
      vim.cmd[[
        let g:sandwich#recipes += [{'buns': ['\%(', '\)'], 'filetype': ['vim'], 'nesting': 1}]
      ]]
    end,
  },

  -- Smart align
  {
    "junegunn/vim-easy-align",
    keys = {
      {"n", "<Plug>(EasyAlign)"},
      {"v", "<Plug>(EasyAlign)"},
    },
    setup =  function()
      -- key mappings
      vim.api.nvim_set_keymap("n", "<Leader>a", "<Plug>(EasyAlign)", {silent = true})
      vim.api.nvim_set_keymap("v", "<Leader>a", "<Plug>(EasyAlign)", {silent = true})
      -- extending alignment rules
      vim.g.easy_align_delimiters = {
        ['>'] = { pattern = [[>>\|=>\|>]] },
        ['/'] = { pattern = [[//\+\|/\*\|\*/]], ignore_groups = {'String'} },
        ['#'] = {
          pattern = [[#\+]],
          ignore_groups = {'String'},
          delimiter_align = 'l',
        },
        [']'] = {
          pattern = [=[[[\]]]=],
          left_margin = 0,
          right_margin = 0,
          stick_to_left = 0
        },
        [')'] = {
          pattern = '[()]',
          left_margin = 0,
          right_margin = 0,
          stick_to_left = 0
        },
        ['d'] = {
          pattern = [[ \(\S\+\s*[;=]\)\@=]],
          left_margin = 0,
          right_margin = 0
        }
      }
    end
  },

  -- SKK input method for Japanese
  {
    "tyru/eskk.vim",
    event = "InsertCharPre *",
    config = function()
      local cache_dir = vim.fn.stdpath("cache")
      vim.g["eskk#directory"] = cache_dir .. "/eskk"

      vim.g["eskk#dictionary"] = {
        path     = cache_dir .. "/skk-jisyo",
        sorted   = 1,
        encoding = "utf-8",
      }

      if vim.fn.has('mac') then
        vim.g["eskk#large_dictionary"] = {
          path     = "~/Library/Application Support/AquaSKK/SKK-JISYO.L",
          sorted   = 1,
          encoding = "euc-jp",
        }
      elseif vim.fn.has('win32') or vim.fn.has('win64') then
        vim.g["eskk#large_dictionary"] = {
          path     = "~/SKK-JISYO.L",
          sorted   = 1,
          encoding = "euc-jp",
        }
      else
        vim.g["eskk#large_dictionary"] = {
          path     = "/usr/local/share/skk/SKK-JISYO.L",
          sorted   = 1,
          encoding = "euc-jp",
        }
      end

      vim.g["eskk#server"] = { host = "localhost", port = 1178 }

      -- Henkan, annotation
      vim.g["eskk#show_annotation"]             = 1
      vim.g["eskk#keep_state"]                  = 0
      vim.g["eskk#debug"]                       = 0
      vim.g["eskk#show_annotation"]             = 1
      vim.g["eskk#egg_like_newline"]            = 1
      vim.g["eskk#egg_like_newline_completion"] = 1
      vim.g["eskk#tab_select_completion"]       = 1
      vim.g["eskk#start_completion_length"]     = 2

      -- Key mappings
      vim.api.nvim_set_keymap("i", "<C-j>", "<Plug>(eskk:toggle)", {silent = true})
      vim.api.nvim_set_keymap("c", "<C-j>", "<Plug>(eskk:toggle)", {silent = true})

      -- easy escape with 'jj'
      vim.cmd("augroup user-plugin-eskk")
      vim.cmd("autocmd!")
      vim.cmd("autocmd User eskk-initialize-post EskkMap -remap jj <ESC>")
      vim.cmd("augroup END")
    end
  },

  -- Perform the replacement in quickfix
  {
    "thinca/vim-qfreplace",
    ft = {"qf"},
    config = function()
      vim.cmd("augroup qfreplace_setup")
      vim.cmd("autocmd!")
      vim.api.nvim_buf_set_keymap(0, "n", "R", "<cmd>Qfreplace<CR>", {noremap = true})
      vim.cmd("augroup END")
    end
  },
}

