local vim = vim or {}
local utils = require("vimrc_utils")


local function init_dein()
  local rtp         = vim.o.runtimepath
  local base_dir    = vim.env.VIM_CACHE_HOME .. "/dein"
  local install_dir = base_dir .. "/repos/github.com/Shougo/dein.vim"

  if not sting.find(rtp, "dein.vim") then
    if not utils.path.is_dir(intall_dir) then
      -- Install dein.vim
      os.execute("git clone https://github.com/Shougo/dein.vim " .. install_dir)
    end
    vim.o.runtimepath = table.concat({install_dir, rtp}, ",")
  end

  vim.g["dein#enable_notification"]   = 0
  vim.g["dein#install_max_processes"] = 16
  vim.g["dein#install_progress_type"] = "title"
  vim.g["dein#install_log_filename"]  = base_dir .. "/dein.log"
end

local function dein_plugins(plugins)
  init_dein()
  -- Load dein's state from the chache script
  --   REMARK: It overwrites 'runtimepath' completely.
  if vim.fn["dein#load_state"](base_dir) then
    -- Reaches here if the cache script is old, invalid, or not found.
    -- Now initialize dein.vim and start plugin configuration block.
    vim.fn["dein#begin"](base_dir)

    vim.fn["dein#end"]()
    vim.fn["dein#save_state"]()
  end
-- if dein#load_state(s:dein_dir)
--   let s:toml = [
--         \ { 'name': 'plugins.toml',      'lazy': 0 },
--         \ { 'name': 'ftplugin.toml',     'lazy': 0 },
--         \ { 'name': 'plugins_lazy.toml', 'lazy': 1 },
--         \ { 'name': 'defx.toml',         'lazy': 1 },
--         \ { 'name': 'denite.toml',       'lazy': 1 },
--         \ { 'name': 'deoplete.toml',     'lazy': 1 },
--         \ { 'name': 'which_key.toml',    'lazy': 1 },
--         \ ]
--   " Reaches here if the cache script is old, invalid, or not found.
--   " Now initialize dein.vim and start plugin configuration block.
--   call dein#begin(s:dein_dir, map(deepcopy(s:toml), {_, t -> s:base . t['name']}))
--   call map(s:toml, {_, t -> dein#load_toml(s:base . t['name'], {'lazy': t['lazy']})})
--   " REMARK: 'runtimepath' is changed after dein#end()
--   call dein#end()
--   call dein#save_state()
-- endif

  -- Install missing plugin(s) automatically
  if vim.fn.has('vim_starting') and vim.fn.["dein#check_install"]() then
     vim.fn["dein#install"]()
  end
end


return { add_plugins = dein_plugins }
