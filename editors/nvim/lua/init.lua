require('vimrc_utils')

local api = vim.api
local home = os.getenv("HOME")


--- Environment variables
local config_home = os.getenv("XDG_CONFIG_HOME") or home .. "/.config"
local cache_home  = os.getenv("XDG_CACHE_HOME")  or home .. "/.cache"
local data_home   = os.getenv("XDG_DATA_HOME")   or home .. "/.local/share"

VIM_CONFIG_HOME = config_home .. "/nvim"
VIM_CACHE_HOME  = cache_home  .. "/nvim"
VIM_DATA_HOME   = data_home   .. "/nvim"

local function create_backup_dirs()
  --- Ensure cache and data directories exist
  vim.fn.mkdir(VIM_CACHE_HOME .. "/backup",  'p')
  vim.fn.mkdir(VIM_CACHE_HOME .. "/swap",    'p')
  vim.fn.mkdir(VIM_CACHE_HOME .. "/undo",    'p')
  vim.fn.mkdir(VIM_CACHE_HOME .. "/view",    'p')
  vim.fn.mkdir(VIM_CACHE_HOME .. "/session", 'p')
  vim.fn.mkdir(VIM_DATA_HOME  .. "/spell",   'p')

end

local function set_options_on_vim_starting()
  -- List of character encodings considered when starting to edit an existing file
  vim.o.fileencodings = "ucs-bom,utf-8,euc-jp,iso-2022-jp,cp932,utf-16,utf-16le,cp1250"
  
  if vim.fn.has("multi_byte_ime") then
    vim.o.iminsert = 0
    vim.o.imsearch = 0
  end

  --- Enable true color if supported {{{
  --[[
    TODO: We should check if the terminal emulater has truecolor supports, but
    there is no reliable ways to do that. Some terminal emulater provides
    $COLORTERM environment variable set to 'truecolor' or '24bit' so we also
    checkt this variable.
  --]]
  local colorterm = os.getenv("COLORTERM")
  if vim.fn.has("termguicolors") and (colorterm == "truecolor" or colorterm == "24bit") then
    vim.o.termguicolors = true
  end
  --- }}}

  --- Disable unnecessary default plugins {{{
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
  -- Disable
  vim.o.packpath = ""
  --- }}}
end

if vim.fn.has("vim_starting") then
  create_backup_dirs()
  set_options_on_vim_starting()
end

