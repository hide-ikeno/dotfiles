local function ensure_packer()
  vim.cmd [[packadd packer.nvim]]
  vim._update_package_paths()

  local packer_exists = pcall(require, 'packer')

  if not packer_exists then
    local dir  = vim.fn.stdpath('data') .. '/site/pack/packer/opt/'
    local repo = "https://github.com/wbthomason/packer.nvim"

    vim.fn.mkdir(dir, 'p')

    local out = vim.fn.system(string.format(
      'git clone %s %s', repo, dir .. '/packer.nvim'
    ))

    print(out)
    print("Downloading packer.nvim...")

    return
  end
end

local packer = nil

local function init()
  if packer == nil then
    ensure_packer()
    packer = require("packer")
    packer.init()
  end

  local use = packer.use

  -- Clear state from previous operations
  packer.reset()

  -- Packer can manage itself as an optional plugin
  use { "wbthomason/packer.nvim", opt = true }

  -- [[ Fundamentals ]] {{{

  -- Enable configuration file in each directory
  use "thinca/vim-localrc"

  -- EditorConfig
  use {
    "editorconfig/editorconfig-vim",
    setup = "vim.g.EditorConfig_exclude_patterns = {'scp://.*', 'term://.*'}"
  }

  -- Seemless navigation between Tmux and (Neo)Vim
  use {
    "christoomey/vim-tmux-navigator",
    setup = "require'conf.vim-tmux-navigator'.setup()"
  }
  -- }}}

  -- [[ Interfaces ]] {{{

  -- Visually displaying indent levels in code
  use {
    "nathanaelkane/vim-indent-guides",
    setup = "require'conf.vim-indent-guides'.setup()"
  }

  -- Better whitespace highlighting
  use {
    "ntpeters/vim-better-whitespace",
    setup = "require'conf.vim-better-whitespace'.setup()"
  }

  -- Even better % navigation and highlight mathching words
  use {
    "andymass/vim-matchup",
    opt = true,
    event = "CursorHold *"
  }

  -- Improve `foldtext` for better looks
  use "lambdalisue/readablefold.vim"

  -- Find fenced code blocks and filetype (e.g., Javascript blocks inside HTML)
  use "Shougo/context_filetype.vim"

  -- Show keybindings in popup
  use {
    "liuchengxu/vim-which-key",
    cmd = {"WhichKey", "WhichKeyVisual"},
    setup = "require'conf.vim-which-key'.setup()",
    config = "require'conf.vim-which-key'.config()",
  }

  -- A high-performance color highlighter for NeoVim
  use {
    "norcalli/nvim-colorizer.lua",
    config = "require'colorizer'.setup()"
  }

  -- Breakdown Vim's --startuptime output
  use { "tweekmonster/startuptime.vim", cmd = "StartupTime" }

  -- }}}

  -- [[ Editor ]] {{{

  use "kana/vim-operator-user"
  use "kana/vim-textobj-user"

  use {
    "kana/vim-operator-replace",
    requires = { "vim-operator-user" },
    setup = "require'conf.vim-operator-replace'.setup()"
  }


  use {
    "machakann/vim-sandwich",
    setup = "require'conf.vim-sandwich'.setup()",
    config = "require'conf.vim-sandwich'.config()",
  }

  use "tpope/vim-repeat"

  -- Smart commenter
  use {
    "tyru/caw.vim",
    event = "CursorMoved *",
    setup = "require'conf.caw'.setup()",
  }

  -- Smart align
  use {
    "junegunn/vim-easy-align",
    event = "CursorMoved *",
    setup = "require'conf.vim-easy-align'.setup()"
  }

  -- SKK input method for Japanese
  use {
    "tyru/eskk.vim",
    event = "InsertCharPre *",
    setup = "require'conf.eskk'.setup()",
    config = "require'conf.eskk'.config()",
  }

  -- Perform the replacement in quickfix
  use {
    "thinca/vim-qfreplace",
    ft = {"qf"},
    config = function()
      vim.cmd("augroup qfreplace_setup")
      vim.cmd("autocmd!")
      vim.api.nvim_buf_set_keymap(0, "n", "R", "<cmd>Qfreplace<CR>", {noremap = true})
      vim.cmd("augroup END")
    end
  }

  -- (DO)cument (GE)nerator
  use {
    "kkoomen/vim-doge",
    ft = {
      "python", "php", "javascript", "typescript", "coffee", "lua", "java",
      "groovy", "ruby", "scalar", "kotlin", "r", "c", "cpp", "sh"
    },
    setup = "require'conf.vim-doge'.setup()"
  }

  -- Syntax-aware code formatting
  use {
    "google/vim-codefmt",
    requires = {
      "google/vim-maktaba",
      "google/vim-glaive"
    },
    cmd = {
      "FormatLines", "FormatCode", "AutoFormatBuffer", "NoAutoFormatBuffer"
    },
    setup = "require'conf.vim-codefmt'.setup()"
  }
  -- }}}

  -- [[ Colorscheme ]]

  use { "sainnhe/edge", opt = true }
  use { "sainnhe/forest-night", opt = true }
  use { "sainnhe/gruvbox-material", opt = true }

  -- A color scheme template
  -- use "Iron-E/nvim-highlite"

  -- [[ Syntax, filetype ]] {{{

  -- A solid language pack for Vim
  use {
    "sheerun/vim-polyglot",
    setup = "vim.g.polyglot_disable = {'json', 'markdown'}"
  }

  -- Vim help in japanese
  use "vim-jp/vimdoc-ja"

  -- GNU As
  use "Shirk/vim-gas"

  -- Jsonc
  use "neoclide/jsonc.vim"

  -- Python
  use "vim-scripts/python_match.vim"

  use "raimon49/requirements.txt.vim"

  use {
    "petobens/poet-v",
    ft = {"python"},
    setup = "vim.g.poetv_auto_activate = 1"
  }

  use { "tmhedberg/SimpylFold", ft = {"python"} }

  -- Markdown
  use "rcmdnk/vim-markdown"
  use "rhysd/vim-gfm-syntax"

  -- Zsh
  use "chrisbra/vim-zsh"

  -- Hex editor
  use {
    "Shougo/vinarise.vim",
    cmd = {"Vinarise"},
    setup = "vim.g.vinarise_enable_auto_detect = 1"
  }
  -- }}}

  -- [[ VCS (Git etc.) ]] {{{

  -- Asynchronously control git repositories
  use { "lambdalisue/gina.vim", cmd = {"Gina"} }

  -- Show difference with style
  use {
    "mhinz/vim-signify",
    setup = "require'conf.vim-signify'.setup()"
  }

  -- More pleasant editing on commit messsages
  use {
    "rhysd/committia.vim",
    event = {"BufEnter COMMIT_EDITMSG"},
    setup = "vim.g.committia_min_window_width = 100"
  }

  -- Reveal the commit messages under the cursor
  use {
    "rhysd/git-messenger.vim",
    cmd = {"GitMessenger"},
    setup = "require'conf.git-messenger'.setup()"
  }
  -- }}}

  -- [[ LSP, Tag jumps ]] {{{

  -- Collection of common configurations for Nvim LSP client
  use {
    "neovim/nvim-lsp",
    event = {"BufNewFile *", "BufRead *"},
    requires = {
      "nvim-lua/diagnostic-nvim",
      "nvim-lua/lsp-status.nvim",
    },
    setup = "require'conf.nvim-lsp'.setup()",
    config = "require'conf.nvim-lsp'.config()"
  }

  -- Manage tag files
  use {
    "ludovicchabant/vim-gutentags",
    setup = "require'conf.vim-gutentags'.setup()"
  }

  -- View and search LSP symbols and tags in (Neo)Vim
  use {
    "liuchengxu/vista.vim",
    cmd = {"Vista"},
    setup = "require'conf.vista'.setup()"
  }
  -- }}}

  -- [[ Treesitter ]] {{{

  use {
    "nvim-treesitter/nvim-treesitter",
    event = {"BufNewFile *", "BufRead *"},
    config = "require('conf.nvim-treesitter').config()"
  }

  -- }}}

  -- [[ Auto completion ]] {{{

  -- Snippet plugin for (Neo)Vim that supports LSP/VSCode's snippet format
  use {
    "hrsh7th/vim-vsnip",
    event = "InsertEnter *",
    setup = "require('conf.vim-vsnip').setup()",
  }
  use {
    "hrsh7th/vim-vsnip-integ",
    -- opt = true,
    after = {"vim-vsnip"}
  }

  use {
    "nvim-lua/completion-nvim",
    event = "InsertEnter *",
    requires = {
      "vim-vsnip",
      "vim-vsnip-integ",
      {
        "nvim-treesitter/completion-treesitter",
        after = { "completion-nvim", "nvim-treesitter" }
      }
    },
    setup = "require'conf.completion-nvim'.setup()",
    config = "require'conf.completion-nvim'.config()"
  }
  -- }}}

  -- [[ Fuzzy finder ]] {{{
  use {
    "junegunn/fzf",
    run = "./install --all --xdg --no-update-rc"
  }

  use {
    "yuki-ycino/fzf-preview.vim",
    branch = "release",
    run = ":UpdateRemotePlugins",
    requires = {
      {
        "LeafCage/yankround.vim",
        setup = "vim.g.yankround_dir = vim.fn.stdpath('cache') .. '/yankround'"
      },
      "ryanoasis/vim-devicons",
      "lambdalisue/gina.vim",
      "liuchengxu/vista.vim",
    },
    setup = "require'conf.fzf-preview'.setup()"
  }

  -- }}}
end

-- Hack for convenience: make this module (1) ensure packer.init() is called and
-- (2) re-export all of packer's functions
local plugins = setmetatable({}, {
  __index = function(_, key)
    init()
    return packer[key]
  end
})

return plugins
