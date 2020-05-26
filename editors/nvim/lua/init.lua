local vim   = vim or {}
local utils = require('vimrc_utils')

--- Environment variables {{{1
local home = os.getenv("HOME")

local function configure_path(new_paths, path_var)
  local path_separator = utils.os.is_windows and ";" or ":"
  local paths = {}

  local function is_empty(str)
    return str == nil or str == ""
  end

  local function add_paths(list)
    for _, x in ipairs(list) do
      if not is_empty(x) then
        local y = vim.fn.expand(x)
        if utils.path.is_dir(y) and not vim.tbl_contains(paths, y) then
          paths[#paths+1] = y
        end
      end
    end
  end

  -- Add given directories in the path list.
  add_paths(new_paths)
  -- Split path_var string with the separator, and filter out non-exsiting dirs
  if not is_empty(path_var) then
    add_paths(vim.split(path_var, path_separator, true))
  end
  -- concat paths
  return table.concat(paths, path_separator)
end


local function set_envs()
  -- Directories to store nvim related files
  local config_home = os.getenv("XDG_CONFIG_HOME") or home .. "/.config"
  local cache_home  = os.getenv("XDG_CACHE_HOME")  or home .. "/.cache"
  local data_home   = os.getenv("XDG_DATA_HOME")   or home .. "/.local/share"

  vim.env.VIM_CONFIG_HOME = config_home .. "/nvim"
  vim.env.VIM_CACHE_HOME  = cache_home  .. "/nvim"
  vim.env.VIM_DATA_HOME   = data_home   .. "/nvim"

  -- Set PATH/MANPATH so that Nvim GUI frontend can recognize these variables
  vim.env.PATH = configure_path({
      "~/.poetry/bin",
      "~/.yarn/bin",
      "~/.cargo/bin",
      "~/.goenv/bin",
      "~/.nodenv/bin",
      "~/.rbenv/bin",
      "~/.pyenv/bin",
      "~/.nodenv/shims",
      "~/.rbenv/shims",
      "~/.pyenv/shims",
      "~/.anyenv/envs/goenv/bin",
      "~/.anyenv/envs/rbenv/bin",
      "~/.anyenv/envs/pyenv/bin",
      "~/.anyenv/envs/nodenv/shims",
      "~/.anyenv/envs/rbenv/shims",
      "~/.anyenv/envs/pyenv/shims",
      "~/.local/bin",
      "~/bin",
      "/Library/Tex/texbin",
      "/usr/local/bin",
      "/usr/bin",
      "/bin",
      "/usr/local/sbin",
      "/usr/sbin",
      "/sbin",
    }, os.getenv("PATH"))

  vim.env.MANPATH = configure_path({
      "~/.local/share/man",
      "/usr/share/man/",
      "/usr/local/share/man/ja",
      "/usr/local/share/man/",
      "/Applications/Xcode.app/Contents/Developer/usr/share/man",
      "/opt/intel/man/",
    }, os.getenv("MANPATH"))

  -- Pyenv root directory
  vim.env.PYENV_ROOT = vim.fn.expand('~/.anyenv/envs/pyenv')
end

--- Ensure cache and data directories exist {{{1
local function create_backup_dirs()
  -- NOTE: this function must be called after setting ENVS
  vim.fn.mkdir(vim.env.VIM_CACHE_HOME .. "/backup",  "p")
  vim.fn.mkdir(vim.env.VIM_CACHE_HOME .. "/swap",    "p")
  vim.fn.mkdir(vim.env.VIM_CACHE_HOME .. "/undo",    "p")
  vim.fn.mkdir(vim.env.VIM_CACHE_HOME .. "/view",    "p")
  vim.fn.mkdir(vim.env.VIM_CACHE_HOME .. "/session", "p")
  vim.fn.mkdir(vim.env.VIM_DATA_HOME  .. "/spell",   "p")
end

--- Set nvim built-in global options on startup {{{1
local function set_global_options_on_startup()
  -- Set default text encoding
  vim.o.encoding = "utf-8"
  -- List of character encodings considered when starting to edit an existing file
  vim.o.fileencodings = "ucs-bom,utf-8,euc-jp,iso-2022-jp,cp932,utf-16,utf-16le,cp1250"

  -- IME setting
  if vim.fn.has("multi_byte_ime") then
    vim.o.iminsert = 0
    vim.o.imsearch = 0
  end

  --[[
    Enable true color if supported.

    TODO: We should check if the terminal emulater has truecolor supports, but
    there is no reliable ways to do that. Some terminal emulater provides
    $COLORTERM environment variable set to 'truecolor' or '24bit' so we also
    checkt this variable.
  --]]
  local colorterm = os.getenv("COLORTERM")
  if vim.fn.has("termguicolors") and (colorterm == "truecolor" or colorterm == "24bit") then
    vim.o.termguicolors = true
  end

  --- Directories to find packages
  -- vim.o.packpath = vim.env.VIM_CACHE_HOME
  vim.o.packpath = ""
end

--- Set nvim default global vars on startup {{{1
local function set_global_vars_on_startup()
  --[[
    Set python2/python3 interpretor (required to setup plugins using neovim
    python API).

    It is recommended to create virtualenvs for and only for neovim (install
    pynvim + development tools) and set python3_host_prog and python_host_prog
    to point the corresponding python interpreters.
  --]]
  vim.g.python3_host_prog = vim.env.PYENV_ROOT .. "/versions/neovim3/bin/python"
  vim.g.python_host_prog  = vim.env.PYENV_ROOT .. "/versions/neovim2/bin/python"

  --[[ Leader/Localleader keys ]]
  vim.g.mapleader      = ";"
  vim.g.maplocalleader = ","
  -- release keymappings for plugins
  vim.api.nvim_set_keymap("n", "<Space>", "<Nop>", {noremap = true})
  vim.api.nvim_set_keymap("x", "<Space>", "<Nop>", {noremap = true})
  vim.api.nvim_set_keymap("n", ";",       "<Nop>", {noremap = true})
  vim.api.nvim_set_keymap("x", ";",       "<Nop>", {noremap = true})
  vim.api.nvim_set_keymap("n", ",",       "<Nop>", {noremap = true})
  vim.api.nvim_set_keymap("x", ",",       "<Nop>", {noremap = true})
  vim.api.nvim_set_keymap("n", "m",       "<Nop>", {noremap = true})
  vim.api.nvim_set_keymap("x", "m",       "<Nop>", {noremap = true})
  vim.api.nvim_set_keymap("n", "s",       "<Nop>", {noremap = true})
  vim.api.nvim_set_keymap("x", "s",       "<Nop>", {noremap = true})

  --[[ Disable unnecessary default plugins ]]
  vim.g.loaded_2html_plugin      = 1
  vim.g.loaded_getscript         = 1
  vim.g.loaded_getscriptPlugin   = 1
  vim.g.loaded_gzip              = 1
  vim.g.loaded_logiPat           = 1
  vim.g.loaded_matchit           = 1
  vim.g.loaded_matchparen        = 1
  vim.g.netrw_nogx               = 1
  vim.g.loaded_netrwPlugin       = 1
  vim.g.loaded_netrwSettings     = 1
  vim.g.loaded_netrwFileHandlers = 1
  vim.g.loaded_rrhelper          = 1
  vim.g.loaded_spellfile_plugin  = 1
  vim.g.loaded_tar               = 1
  vim.g.loaded_tarPlugin         = 1
  vim.g.loaded_vimball           = 1
  vim.g.loaded_vimballPlugin     = 1
  vim.g.loaded_zip               = 1
  vim.g.loaded_zipPlugin         = 1
  -- Disable ruby support in neovim
  vim.g.loaded_ruby_provider     = 1
end

--- Initialize {{{1
set_envs()

if vim.fn.has("vim_starting") then
  create_backup_dirs()
  set_global_options_on_startup()
  set_global_vars_on_startup()
end


-- Global options (Nvim core)
require('options')

-- Plugins
require("dein")

-- ftplugin, syntax
if vim.fn.has("vim_starting") and vim.fn.empty(vim.fn.argv()) == 0 then
  vim.fn["vimrc#on_filetype"]()
end

-- autocmd
vim.cmd("augroup MuAutoCmd")
vim.cmd("autocmd!")
vim.cmd("autocmd FileType,Syntax,BufNewFile,BufNew,BufRead *? call vimrc#on_filetype()")
vim.cmd("autocmd CursorHold *? syntax sync minlines=300")
vim.cmd("autocmd TextYankPost *  silent! lua require'vim.highlight'.on_yank('IncSearch', 1000)")
vim.cmd("augroup END")

-- Key mappings
require("mappings")

-- Filetype settings
require("filetype").setup()

-- Appearance
require("style")

