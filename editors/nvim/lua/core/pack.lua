-- ~/.config/nvim/lua/core/pack.lua
--[[ Configure packer.nvim, a plugin manager, with bootstrapping ]]

local nvim_dir = require("core.globals").nvim_dir
local config_dir = nvim_dir.config
local plugin_config_dir = config_dir .. "/lua/plugins"
local site_packages = nvim_dir.site_packages
local packer = nil

local Packer = {}
Packer.__index = Packer

function Packer:load_packer()
  if not packer then
    vim.cmd [[packadd packer.nvim]]
    packer = require("packer")
    packer.init {
      disable_commands = true,
      max_jobs = 50,
    }
  end
  packer.reset()

  local plugin_config_files = vim.split(vim.fn.glob(plugin_config_dir .. "/*.lua"), "\n")
  for _, fname in ipairs(plugin_config_files) do
    local name = vim.fn.fnamemodify(fname, ":t:r")
    packer.use(require('plugins.' .. name))
  end
end

function Packer:init_ensure_plugins()
  local packer_dir = site_packages .. "/pack/packer/opt/packer.nvim"
  local packer_repo = "https://github.com/wbthomason/packer.nvim"
  local state = vim.loop.fs_stat(packer_dir)
  if not state then
    local out = vim.fn.system(string.format('git clone %s %s', packer_repo, packer_dir))
    print(out)
    self:load_packer()
    packer.install()
    packer.compile()
  end
end

local plugins = setmetatable({}, {
  __index = function(_, key)
    Packer:load_packer()
    return packer[key]
  end,
})

function plugins.ensure_plugins()
  Packer:init_ensure_plugins()
end

function plugins.auto_compile()
  local file = vim.fn.expand("%:p")
  if file:match("nvim/lua/plugins/%a+.lua") then
    plugins.compile()
  end
end

return plugins
