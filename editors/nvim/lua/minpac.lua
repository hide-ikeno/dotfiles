local vim = vim or {}
local utils = require("vimrc_utils")

local M = {}
local base_dir = vim.env.VIM_CACHE_HOME .. "/pack/minpac"

local plugins = {
  -- Plugin manager
  {"k-takata/minpac", type = "opt"};

  -- Basics
  'thinca/vim-localrc';
  'editorconfig/editorconfig-vim';
  'TravonteD/luajob';
  -- 'itchyny/vim-gitbranch';
  'itchyny/vim-parenmatch';
  'Yggdroot/indentLine';
  'ntpeters/vim-better-whitespace';
  'christoomey/vim-tmux-navigator';
  'Shougo/context_filetype.vim';
  'kana/vim-operator-user';
  'kana/vim-textobj-user';
  'tpope/vim-repeat';
  'ryanoasis/vim-devicons';

  -- LSP
  {'neovim/nvim-lsp',             type = "opt"};
  {'haorenW1025/diagnostic-nvim', type = "opt"};

  -- Tags
  {'ludovicchabant/vim-gutentags', type = "opt"};
  {'liuchengxu/vista.vim',        type = "opt"};

  -- Snippets
  {'Shougo/neosnippet.vim',        type = "opt"};

  -- Auto completion
  {'haorenW1025/completion-nvim', type = "opt"};

  -- {'Shougo/deoplete.nvim', type = "opt"};
  -- 'ncm2/float-preview.nvim';
  -- 'Shougo/neco-syntax';
  -- 'Shougo/neosnippet-snippets';
  -- 'Shougo/deoplete-lsp';
  -- 'tbodt/deoplete-tabnine';
  -- 'zchee/deoplete-zsh';
  -- {'Shougo/neco-vim',         type = "opt"};
  -- {'Shougo/neoinclude.vim',   type = "opt"};
  -- {'hrsh7th/vim-vsnip',       type = "opt"};
  -- {'hrsh7th/vim-vsnip-integ', type = "opt"};

  -- Fuzzy finder
  'junegunn/fzf';
  'yuki-ycino/fzf-preview.vim';
  -- {'junegunn/fzf',               type = "opt"};
  -- {'yuki-ycino/fzf-preview.vim', type = "opt"};

  -- {'Shougo/denite.nvim', type = "opt"};
  -- {'Shougo/neoyank.vim', type = "opt"};
  -- {'Shougo/neomru.vim',  type = "opt"};
  -- {'Shougo/deol.nvim',   type = "opt"};
  -- {'raghur/fruzzy',      type = "opt", ["do"] = "{-> fruzzy#install()}"};

  -- Filer
  {'Shougo/defx.nvim',          type = "opt"};
  {'kristijanhusak/defx-icons', type = "opt"};
  'kristijanhusak/defx-git';
  'chemzqm/unite-location';
  'cocopon/iceberg.vim';
  'drewtempelmeyer/palenight.vim';

  -- Filetypes
  'sheerun/vim-polyglot';
  'vim-jp/vimdoc-ja';
  'JesseKPhillips/d.vim';
  'vim-scripts/python_match.vim';
  'neoclide/jsonc.vim';
  'chrisbra/vim-zsh';
  'Shirk/vim-gas';
  'raimon49/requirements.txt.vim';
  'chrisbra/csv.vim';
  'rcmdnk/vim-markdown';
  'rhysd/vim-gfm-syntax';

  -- Commands, Interfaces
  {'thinca/vim-qfreplace',        type = "opt"};
  {'t9md/vim-choosewin',          type = "opt"};
  {'junegunn/vim-easy-align',     type = "opt"};
  {'AndrewRadev/splitjoin.vim',   type = "opt"};
  {'rbgrouleff/bclose.vim',       type = "opt"};
  {'tyru/eskk.vim',               type = "opt"};
  {'tyru/caw.vim',                type = "opt"};
  {'kana/vim-niceblock',          type = "opt"};
  {'easymotion/vim-easymotion',   type = "opt"};
  {'haya14busa/vim-edgemotion',   type = "opt"};
  {'rhysd/accelerated-jk',        type = "opt"};
  {'osyo-manga/vim-jplus',        type = "opt"};
  {'Konfekt/FastFold',            type = "opt"};
  {'itchyny/calendar.vim',        type = "opt"};
  {'osyo-manga/vim-precious',     type = "opt"};
  {'kkoomen/vim-doge',            type = "opt"};
  {'norcalli/nvim-colorizer.lua', type = "opt"};
  {'liuchengxu/vim-which-key',    type = "opt"};

  -- text objects, operators
  {'machakann/vim-sandwich',          type = "opt"};
  {'kana/vim-operator-replace',       type = "opt"};
  {'kana/vim-textobj-entire',         type = "opt"};
  {'kana/vim-textobj-line',           type = "opt"};
  {'thinca/vim-textobj-comment',      type = "opt"};
  {'mattn/vim-textobj-url',           type = "opt"};
  {'machakann/vim-textobj-delimited', type = "opt"};
  {'terryma/vim-expand-region',       type = "opt"};

  -- Filetypes (lazy)
  {'lambdalisue/gina.vim',        type = "opt"};
  {'airblade/vim-gitgutter',      type = "opt"};
  {'rhysd/committia.vim',         type = "opt"};
  {'rhysd/git-messenger.vim',     type = "opt"};
  {'lambdalisue/vim-pyenv',       type = "opt"};
  {'tmhedberg/SimpylFold',        type = "opt"};
  {'iamcco/markdown-preview.vim', type = "opt"};
  {'Shougo/vinarise.vim',         type = "opt"};
}

local function ensure_minpac()
  local minpac_dir = base_dir .. "/opt/minpac"

  if vim.fn.has("vim_starting") then
    if not utils.path.is_dir(vim.fn.expand(minpac_dir)) then
      print("Install minpac ...")
      os.execute("git clone --depth 1 https://github.com/k-takata/minpac.git " .. minpac_dir)
    end
  end
end

function M.pack_init()
  ensure_minpac()

  vim.api.nvim_command("packadd minpac")
  vim.fn["minpac#init"]({dir = vim.env.VIM_CACHE_HOME})
  for _, p in ipairs(plugins) do
    if type(p) == 'string' then
      vim.fn["minpac#add"](p)
    elseif type(p) == 'table' then
      local url = p[1]
      assert(url, 'Must specify repository of the plugin.')
      p[1] = nil
      vim.fn["minpac#add"](url, p)
      p[1] = url
    end
  end
end

function M.pack_update()
  M.pack_init()
  vim.fn["minpac#update"]("", {["do"] = "call minpac#status()"})
end

function M.pack_clean()
  M.pack_init()
  vim.fn["minpac#clean"]()
end

function M.pack_status()
  M.pack_init()
  vim.fn["minpac#status"]()
end

return M
