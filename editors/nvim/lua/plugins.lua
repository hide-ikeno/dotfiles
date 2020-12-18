-- Only if you have packer in your `opt` pack
local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

if not packer_exists then
  if vim.fn.input("Download Packer? (y for yes)") ~= "y" then
    return
  end
  local dir  = string.format("%s/site/pack/packer/opt/", vim.fn.stdpath("data"))
  local repo = "https://github.com/wbthomason/packer.nvim"

  vim.fn.mkdir(dir, 'p')

  local out = vim.fn.system(string.format(
    'git clone %s %s', repo, dir .. '/packer.nvim'
  ))

  print(out)
  print("Downloading packer.nvim...")

  vim.cmd('packadd packer.nvim')

  return
end

return require("packer").startup{
  function(use)
    -- Packer can manage itself as an optional plugin
    use { "wbthomason/packer.nvim", opt = true }

    -- [[ Interfaces ]] {{{

    -- Seemless navigation between Tmux and (Neo)Vim
    use {
      "christoomey/vim-tmux-navigator",
      setup = "require'conf.vim-tmux-navigator'.setup()"
    }
    -- Visually displaying indent levels in code
    use {
      "glepnir/indent-guides.nvim",
      config = "require'conf.indent-guides'.config()"
    }

    -- Better whitespace highlighting
    use {
      "ntpeters/vim-better-whitespace",
      event = {"BufNewFile *", "BufRead"},
      setup = "require'conf.vim-better-whitespace'.setup()"
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

    -- A lua fork of vim-devicons
    use {
      'kyazdani42/nvim-web-devicons',
      config = "require'nvim-web-devicons'.setup{}"
    }

    -- Breakdown Vim's --startuptime output
    use { "tweekmonster/startuptime.vim", cmd = "StartupTime" }

    -- }}}

    -- [[ Enhanced ]] {{{

    -- Enable repeating supported plugin maps with "."
    use "tpope/vim-repeat"

    -- Even better % navigation and highlight mathching words
    use {
      "andymass/vim-matchup",
      opt = true,
      event = "CursorHold *"
    }

    -- Enhanced f/t
    use {
      "hrsh7th/vim-eft",
      setup = "require'conf.vim-eft'.setup()"
    }

    -- Make blockwise visual mode more useful
    use "kana/vim-niceblock"

    -- Accelerate up-down moving
    use {
      "rhysd/accelerated-jk",
      setup = "require'conf.accelerated-jk'.setup()"
    }

    -- Smart line join
    use {
      "osyo-manga/vim-jplus",
      setup = "require'conf.vim-jplus'.setup()"
    }

    -- }}}

    -- [[ Editor ]] {{{

    -- EditorConfig
    use {
      "editorconfig/editorconfig-vim",
      setup = "vim.g.EditorConfig_exclude_patterns = {'scp://.*', 'term://.*'}"
    }

    -- Text objects & operators
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

    -- Comment plugin
    use {
      "tyru/caw.vim",
      requires = {
        "context_filetype.vim",
        "vim-repeat",
        "vim-operator-user",
      },
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
      config = "require'conf.vim-qfreplace'.config()",
    }

    -- (DO)cument (GE)nerator
    use {
      "kkoomen/vim-doge",
      run =  ":call doge#install()",
      ft = {
        "python", "php", "javascript", "typescript", "coffee", "lua", "java",
        "groovy", "ruby", "scalar", "kotlin", "r", "c", "cpp", "sh"
      },
      setup = "require'conf.vim-doge'.setup()"
    }

    -- }}}

    -- [[ Appearance ]] {{{

    use { "sainnhe/edge", opt = true }
    use { "sainnhe/forest-night", opt = true }
    use { "sainnhe/gruvbox-material", opt = true }

    use {
      "akinsho/nvim-bufferline.lua",
      requires = { "nvim-lua/nvim-web-devicons" },
      config = function()
        require("bufferline").setup{
          options = {
            mappings = true,
            always_show_bufferline = false,
          }
        }
      end
    }

    -- }}}

    -- [[ Syntax, filetype ]] {{{

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

    -- Lua
    use { "tjdevries/nlua.nvim", ft = {"lua"} }
    use "tjdevries/manillua.nvim"

    -- Markdown
    use "rcmdnk/vim-markdown"
    use { "rhysd/vim-gfm-syntax", ft = {"markdown"} }
    use {
      "mattn/vim-maketable",
      ft = {"markdown"},
      cmd = {"MakeTable", "UnmakeTable"}
    }

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

    -- Calling LazyGit from within neovim
    use {
      "kdheepak/lazygit.nvim",
      cmd = { "LazyGit", "LazyGitFilter", "LazyGitConfig" },
      setup = "require'conf.lazygit'.setup()"
    }

    -- More pleasant editing on commit messsages
    use {
      "rhysd/committia.vim",
      event = {"BufEnter COMMIT_EDITMSG"},
      setup = "vim.g.committia_min_window_width = 100"
    }

    -- Git signs written in pure lua
    use {
      "lewis6991/gitsigns.nvim",
      branch = "main",
      requires = {
        "nvim-lua/plenary.nvim",
      },
      config = "require'conf.gitsigns'.config()"
    }

    -- disabled until https://github.com/f-person/git-blame.nvim/issues/11 is solved
    use {
      "f-person/git-blame.nvim",
      event = {"BufRead *", "BufNewFile *"},
    }

    -- }}}

    -- [[ LSP, DAP, Tag jumps ]] {{{

    -- Collection of common configurations for Nvim LSP client
    use {
      "neovim/nvim-lspconfig",
      event = {"BufNewFile *", "BufRead *"},
      requires = {
        "nvim-lua/lsp-status.nvim",
      },
      setup = "require'conf.nvim-lspconfig'.setup()",
      config = "require'conf.nvim-lspconfig'.config()"
    }

    -- Debug Adapter Protocol client implementation for Neovim
    use {
      "mfussenegger/nvim-dap",
      opt = false,
      requires = {
        "mfussenegger/nvim-dap-python",
        {"theHamsta/nvim-dap-virtual-text", after = "nvim-treesitter"}
      },
      setup = "require'conf.nvim-dap'.setup()",
      config = "require'conf.nvim-dap'.config()"
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
      event = "BufRead *",
      requires = {
        -- nvim-treesitter plugins
        {"nvim-treesitter/nvim-treesitter-refactor",    after="nvim-treesitter"},
        {"nvim-treesitter/nvim-treesitter-textobjects", after="nvim-treesitter"},
      },
      config = "require('conf.nvim-treesitter').config()"
    }

    -- }}}

    -- [[ Auto completion ]] {{{

    -- Snippets plugin written in Lua
    use {
      "norcalli/snippets.nvim",
      config = "require'conf.snippets'.config()"
    }

    -- Auto completion framework
    use {
      "nvim-lua/completion-nvim",
      event = "InsertEnter *",
      requires = {
        "norcalli/snippets.nvim",
        {
          "steelsojka/completion-buffers",
          after = { "completion-nvim" }
        },
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
      "nvim-telescope/telescope.nvim",
      opt = false,
      requires = {
        "nvim-lua/popup.nvim",
        "nvim-lua/plenary.nvim",
        "nvim-lua/nvim-web-devicons",
        "nvim-telescope/telescope-fzy-native.nvim",
        "nvim-telescope/telescope-github.nvim",
        "nvim-telescope/telescope-packer.nvim",
        "nvim-telescope/telescope-dap.nvim",
      },
      setup = "require'conf.telescope'.setup()",
      config = "require'conf.telescope'.config()",
    }
    -- }}}
  end
}

