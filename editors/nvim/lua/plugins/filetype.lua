return {
    -- Vim help in japanese
    { "vim-jp/vimdoc-ja" },

    -- GNU As
    { "Shirk/vim-gas" },

    -- Jsonc
    { "neoclide/jsonc.vim" },

    -- Python
    { "vim-scripts/python_match.vim" },
    { "raimon49/requirements.txt.vim" },
    {
      "petobens/poet-v",
      ft = {"python"},
      setup = "vim.g.poetv_auto_activate = 1"
    },
    { "tmhedberg/SimpylFold", ft = {"python"} },

    -- Lua
     { "tjdevries/nlua.nvim", ft = {"lua"} },
     { "tjdevries/manillua.nvim" },

    -- Markdown
    { "rcmdnk/vim-markdown" },
    { "rhysd/vim-gfm-syntax", ft = {"markdown"} },
    {
      "mattn/vim-maketable",
      ft = {"markdown"},
      cmd = {"MakeTable", "UnmakeTable"}
    },

    -- Zsh
    { "chrisbra/vim-zsh" },

    -- Hex editor
    {
      "Shougo/vinarise.vim",
      cmd = {"Vinarise"},
      setup = "vim.g.vinarise_enable_auto_detect = 1"
    },
  }
