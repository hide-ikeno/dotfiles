local utils = require("utils")

local function ensure_plugin_manager()
  local packpath = utils.path.join(vim.fn.stdpath("data"), "site")
  local packer_path = utils.path.join(packpath, "pack", "packer", "opt", "packer.nvim")

  -- Install packer.nvim from github repository if dein_dir does not exist
  local rtp = vim.o.runtimepath
  if not string.find(rtp, "packer.nvim") then
    if not utils.path.is_dir(packer_path) then
      -- Install dein.vim
      os.execute("git clone https://github.com/wbthomason/packer.nvim " .. packer_path)
    end
  end
end

local packer = nil

local function init()
  if packer == nil then
    ensure_plugin_manager()
    packer = require("packer")
    packer.init()
  end

  local use = packer.use
  -- Clear state from previous operations
  packer.reset()

  -- Packer can manage itself as an optional plugin
  use {
    "wbthomason/packer.nvim",
    opt = true
  }

  -- [[ Fundamentals ]]

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
    setup = require"conf.vim-tmux-navigator".setup
  }

  -- [[ Interfaces ]]

  -- Provides the branch name of the current git repository
  use "itchyny/vim-gitbranch"

  -- Visually displaying indent levels with thin vertical lines
  use {
    "Yggdroot/indentLine",
    setup = require"conf.indentLine".setup
  }

  -- Better whitespace highlighting
  use {
    "ntpeters/vim-better-whitespace",
    setup = require"conf.vim-better-whitespace".setup
  }

  -- Even better % navigation and highlight mathching words
  use {
    "andymass/vim-matchup",
    event = "VimEnter *"
  }

  -- Find fenced code blocks and filetype (e.g., Javascript blocks inside HTML)
  use "Shougo/context_filetype.vim"

  -- A high-performance color highlighter for NeoVim
  use {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require'colorizer'.setup()
    end
  }

  -- [[ Editor ]]

  use "kana/vim-operator-user"
  use "kana/vim-textobj-user"

  use {
    "machakann/vim-sandwich",
    setup = require"conf.vim-sandwich".setup,
    config = require"conf.vim-sandwich".config,
  }

  use "tpope/vim-repeat"

  -- Smart commenter
  use {
    "tyru/caw.vim",
    setup = require"conf.caw".setup,
  }

  use "tyru/eskk.vim"

  -- [[ Syntax, filetype ]]

  -- A solid language pack for Vim
  use {
    "sheerun/vim-polyglot",
    setup = "vim.g.polyglot_disable = {'json', 'markdown'}"
  }

  -- Vim help in japanese
  use "vim-jp/vimdoc-ja"

  -- GNU As
  use "Shirk/vim-gas"

  -- CSV
  use "chrisbra/csv.vim"

  -- D language
  use "JesseKPhillips/d.vim"

  -- Json
  use "neoclide/jsonc.vim"

  -- Python
  use "vim-scripts/python_match.vim"
  use "raimon49/requirements.txt.vim"

  use {
    "petobens/poet-v",
    opt = true,
    ft = {"python"},
    setup = "vim.g.poetv_auto_activate = 1"
  }

  use {
    "tmhedberg/SimpylFold",
    opt = true,
    ft = {"python"}
  }

  -- Markdown
  use "rcmdnk/vim-markdown"
  use {
    "rhysd/vim-gfm-syntax",
    opt = true,
    ft = {"markdown"}
  }

  -- use {
  --   "iamcco/markdown-preview.vim",
  --   opt = true,
  --   run = "cd app && yarn install",
  --   ft = {"markdown", "pandoc.markdown", "rmd"},
  --   setup = "vim.g.mkdp_refresh_slow = 1"
  -- }

  -- Zsh
  use "chrisbra/vim-zsh"

  -- Hex editor
  use {
    "Shougo/vinarise.vim",
    opt = true,
    cmd = {"Vinarise"},
    setup = "vim.g.vinarise_enable_auto_detect = 1"
  }

  -- [[ VCS (Git etc.) ]]

  -- Show difference with style
  use {
    "mhinz/vim-signify",
    opt = true,
    event = {"BufEnter *"},
    setup = require"conf.vim-signify".setup
  }

  -- More pleasant editing on commit messsages
  use {
    "rhysd/committia.vim",
    opt = true,
    event = {"BufRead COMMIT_EDITMSG"},
    setup = "vim.g.committia_min_window_width = 100"
  }

  -- Reveal the commit messages under the cursor
  use {
    "rhysd/git-messenger.vim",
    opt = true,
    cmd = {"GitMessenger"},
    keys = {
      {"n", "<Plug>(git-messenger)"}
    },
    -- keys = "gm",
    setup = require"conf.git-messenger".setup,
    config = require"conf.git-messenger".config,
  }

  -- [[ LSP ]]
--  use "Shougo/neosnippet-snippets"
--  use "Shougo/deoplete-lsp"
--  use "tbodt/deoplete-tabnine"
--  use "zchee/deoplete-zsh"
--  use "kristijanhusak/defx-git"
--  use "chemzqm/unite-location"
--  use "google/vim-maktaba"
--  use "google/vim-glaive"
--  use "cocopon/iceberg.vim"
--  use "sainnhe/gruvbox-material"
--  use "sainnhe/forest-night"
--  use "sainnhe/edge"
--  use "sainnhe/sonokai"

-- dein/plugins_lazy.toml:repo = "neovim/nvim-lsp"
-- dein/plugins_lazy.toml:repo = "haorenW1025/diagnostic-nvim"
-- dein/plugins_lazy.toml:repo = "weilbith/nvim-lsp-smag"
-- dein/plugins_lazy.toml:repo = "weilbith/nvim-lsp-denite"
-- dein/plugins_lazy.toml:repo = "google/vim-codefmt"
-- dein/plugins_lazy.toml:repo = "nvim-treesitter/nvim-treesitter"
-- dein/plugins_lazy.toml:repo = "Shougo/denite.nvim"
-- dein/plugins_lazy.toml:repo = "raghur/fruzzy"
-- dein/plugins_lazy.toml:repo = "Shougo/neoyank.vim"
-- dein/plugins_lazy.toml:repo = "Shougo/neomru.vim"
-- dein/plugins_lazy.toml:repo = "Shougo/deol.nvim"
-- dein/plugins_lazy.toml:repo = "Shougo/deoplete.nvim"
-- dein/plugins_lazy.toml:repo = "Shougo/neco-syntax"
-- dein/plugins_lazy.toml:repo = "Shougo/neoinclude.vim"
-- dein/plugins_lazy.toml:repo = "Shougo/neco-vim"
-- dein/plugins_lazy.toml:repo = "ncm2/float-preview.nvim"
-- dein/plugins_lazy.toml:repo = "Shougo/neosnippet.vim"
-- dein/plugins_lazy.toml:# repo = "cohama/lexima.vim"
-- dein/plugins_lazy.toml:repo = "ludovicchabant/vim-gutentags"
-- dein/plugins_lazy.toml:repo = "hrsh7th/vim-vsnip"
-- dein/plugins_lazy.toml:repo = "hrsh7th/vim-vsnip-integ"
-- dein/plugins_lazy.toml:repo = "Shougo/defx.nvim"
-- dein/plugins_lazy.toml:repo = "kristijanhusak/defx-icons"
-- dein/plugins_lazy.toml:repo = "haya14busa/dein-command.vim"
-- dein/plugins_lazy.toml:repo = "liuchengxu/vista.vim"
-- dein/plugins_lazy.toml:repo = "thinca/vim-qfreplace"
-- dein/plugins_lazy.toml:# repo = "t9md/vim-choosewin"
-- dein/plugins_lazy.toml:repo = "junegunn/vim-easy-align"
-- dein/plugins_lazy.toml:repo = "AndrewRadev/splitjoin.vim"
-- dein/plugins_lazy.toml:repo = "rbgrouleff/bclose.vim"
-- dein/plugins_lazy.toml:repo = "liuchengxu/vim-which-key"
-- dein/plugins_lazy.toml:repo = "kana/vim-niceblock"
-- dein/plugins_lazy.toml:repo = "easymotion/vim-easymotion"
-- dein/plugins_lazy.toml:repo = "haya14busa/vim-edgemotion"
-- dein/plugins_lazy.toml:repo = "rhysd/accelerated-jk"
-- dein/plugins_lazy.toml:repo = "osyo-manga/vim-jplus"
-- dein/plugins_lazy.toml:repo = "lambdalisue/readablefold.vim"
-- dein/plugins_lazy.toml:# repo = "Konfekt/FastFold"
-- dein/plugins_lazy.toml:# repo = "osyo-manga/vim-precious"
-- dein/plugins_lazy.toml:repo = "kkoomen/vim-doge"
-- dein/plugins_lazy.toml:repo = "kana/vim-operator-replace"
-- dein/plugins_lazy.toml:# repo = "kana/vim-textobj-line"
-- dein/plugins_lazy.toml:# repo = "thinca/vim-textobj-comment"
-- dein/plugins_lazy.toml:repo = "kana/vim-textobj-indent"
-- dein/plugins_lazy.toml:repo = "mattn/vim-textobj-url"
-- dein/plugins_lazy.toml:repo = "sgur/vim-textobj-parameter"
-- dein/plugins_lazy.toml:repo = "machakann/vim-textobj-delimited"
-- dein/plugins_lazy.toml:repo = "terryma/vim-expand-region"

end

-- Hack for convenience: make this module (1) ensure packer.init() is called and (2) re-export all
-- of packer's functions
local plugins = setmetatable({}, {
  __index = function(_, key)
    init()
    return packer[key]
  end
})

return plugins
