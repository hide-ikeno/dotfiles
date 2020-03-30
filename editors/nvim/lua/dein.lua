local vim = vim or {}
local utils = require("vimrc_utils")

local dein_dir      = utils.path.join(vim.env.VIM_CACHE_HOME, "dein")
local dein_conf_dir = utils.path.join(vim.env.VIM_CONFIG_HOME, "dein")
local dein_repo_dir = utils.path.join(dein_dir, "repos", "github.com", "Shougo", "dein.vim")

-- Install dein.vim from github repository if dein_dir does not exist
local rtp = vim.o.runtimepath
if not string.find(rtp, "dein.vim") then
  if not utils.path.is_dir(dein_repo_dir) then
    -- Install dein.vim
    os.execute("git clone https://github.com/Shougo/dein.vim " .. dein_repo_dir)
  end
  vim.o.runtimepath = table.concat({dein_repo_dir, rtp}, ",")
end

-- Set variables for controling dein.vim
vim.g["dein#enable_notification"]   = 0
vim.g["dein#install_max_processes"] = 16
vim.g["dein#install_progress_type"] = "title"
vim.g["dein#install_log_filename"]  = dein_dir .. "/dein.log"


-- Load dein's state from the chache script
--   REMARK: It overwrites 'runtimepath' completely.
if vim.fn["dein#load_state"](dein_dir) == 1 then
  -- Reaches here if the cache script is old, invalid, or not found.
  -- Now initialize dein.vim and start plugin configuration block.

  local toml_non_lazy = {
    utils.path.join(dein_conf_dir, "plugins.toml");
    utils.path.join(dein_conf_dir, "ftplugin.toml");
  }

  local toml_lazy = {
    utils.path.join(dein_conf_dir, "plugins_lazy.toml");
    --utils.path.join(dein_conf_dir, "defx.toml");
    --utils.path.join(dein_conf_dir, "denite.toml");
    --utils.path.join(dein_conf_dir, "deoplete.toml");
    --utils.path.join(dein_conf_dir, "which_key.toml");
  }

  vim.fn["dein#begin"](dein_dir, vim.tbl_flatten({toml_non_lazy, toml_lazy}))

  for _, t in ipairs(toml_non_lazy) do
    vim.fn["dein#load_toml"](t, {lazy = 0})
  end

  for _, t in ipairs(toml_lazy) do
    vim.fn["dein#load_toml"](t, {lazy = 1})
  end

  vim.fn["dein#end"]()
  vim.fn["dein#save_state"]()
end

-- Install missing plugin(s) automatically
if vim.fn.has('vim_starting') and vim.fn["dein#check_install"]() > 0 then
  vim.fn["dein#install"]()
end

