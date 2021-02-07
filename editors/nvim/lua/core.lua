--- ~/.config/nvim/lua/core.lua
local utils = require('utils')

-- Directories to store nvim data
local config_dir = vim.fn.stdpath("config")
local cache_dir = vim.fn.stdpath("cache")
local data_dir = vim.fn.stdpath("data")

local nvim_dir = {
  config = config_dir,
  cache = cache_dir,
  data = data_dir,
  backup = utils.path.join(data_dir, "backup"),
  swap = utils.path.join(data_dir, "swap"),
  undo = utils.path.join(data_dir, "undo"),
  view = utils.path.join(data_dir, "view"),
  site_packages = utils.path.join(data_dir, "site"),
}

--- Ensure cache and data directories exist {{{1
local function ensure_nvim_dirs()
  -- NOTE: this function must be called after setting ENVS
  vim.fn.mkdir(nvim_dir.backup, "p")
  vim.fn.mkdir(nvim_dir.swap, "p")
  vim.fn.mkdir(nvim_dir.undo, "p")
  vim.fn.mkdir(nvim_dir.view, "p")
  vim.fn.mkdir(nvim_dir.site_packages, "p")
  -- vim.o.packpath = nvim_dir.site_packages
end

--- Set nvim built-in global options on startup {{{1
local function set_encodings()
  -- Set default text encoding
  vim.o.encoding = "utf-8"
  -- List of character encodings considered when starting to edit an existing file
  vim.o.fileencodings = "ucs-bom,utf-8,euc-jp,iso-2022-jp,cp932,utf-16,utf-16le,cp1250"

  -- IME setting
  if vim.fn.has("multi_byte_ime") then
    vim.o.iminsert = 0
    vim.o.imsearch = 0
  end
end

local function enable_truecolor()
  --[[
    Enable true color if supported.

    TODO: We should check if the terminal emulater has truecolor supports, but
    there is no reliable ways to do that. Some terminal emulater provides
    $COLORTERM environment variable set to 'truecolor' or '24bit' so we also
    checkt this variable.
  --]]
  -- local colorterm = os.getenv("COLORTERM")
  -- if vim.fn.has("termguicolors") and (colorterm == "truecolor" or colorterm == "24bit") then
  --   vim.o.termguicolors = true
  -- end
  vim.o.termguicolors = true
end

--- Set nvim default global vars on startup {{{1

--- Python, Node.js providers {{{2
local function set_providers()
  --[[
    Set python2/python3 interpretor (required to setup plugins using neovim
    python API).

    It is recommended to create virtualenvs for and only for neovim (install
    pynvim + development tools) and set python3_host_prog and python_host_prog
    to point the corresponding python interpreters.
  --]]
  vim.g.python3_host_prog = vim.env.HOME .. "/.asdf/shims/python3"
  vim.g.python_host_prog  = vim.env.HOME .. "/.asdf/shims/python2"
  -- Set Node.js provider
  vim.g.node_host_prog = vim.env.XDG_DATA_HOME .. "/npm/bin/neovim-node-host"
end

--- Set mapleader, localmapleader, and other prefix keys for keymap {{{2
local function set_prefix_keys()
  --[[ Leader/Localleader keys ]]
  vim.g.mapleader      = ";"
  vim.g.maplocalleader = "m"
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
end

local function disable_default_plugins()
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
  -- Disable ruby/perl support in neovim
  vim.g.loaded_ruby_provider = 0
  vim.g.loaded_perl_provider = 0
end


--- Initialize {{{1
local function on_vim_starting()
  if vim.fn.has("vim_starting") then
    ensure_nvim_dirs()
    set_encodings()
    enable_truecolor()
    set_providers()
    set_prefix_keys()
    disable_default_plugins()
  end
end

return {
  setup = on_vim_starting,
  nvim_dir = nvim_dir
}
