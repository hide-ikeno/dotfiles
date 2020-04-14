local vim = vim or {}
local path = require('core/path')

local M = {}

M.plugins = {}
M.is_finalized = false

--- Register a plugin
function M.add_plugin(repo, options)
  assert(not M.is_finalized, "Tried to add a plugin after plugin registration was over")
  if options == nil then
    table.insert(M.plugins, repo)
  else
    options[1] = repo
    table.insert(M.plugins, options)
  end
end

--- Check if the plugin has been registered
function M.has_plugin(plugin)
  plugin = "/" .. plugin

  for _, v in pairs(M.plugins) do
    if type(v) == "string" then
      if vim.endswith(v, plugin) then return true end
      if vim.endswith(v, plugin .. ".git") then return true end
    elseif type(v) == "table" then
      if vim.endswith(v[1], plugin) then return true end
      if vim.endswith(v[1], plugin .. ".git") then return true end
    end
  end

  return false
end

--- Finish plugin registration
function M.finalize()
  M.is_finalized = true

  -- commands
  vim.cmd("command! PackUpdate lua require('core.plug').pack_update()")
  vim.cmd("command! PackStatus lua require('core.plug').pack_status()")
  vim.cmd("command! PackClean  lua require('core.plug').pack_clean()")
end

--- Setup minpac as a backend plugin manager
M._is_minpac_initilized = false

local function ensure_minpac(base_dir)
  if vim.fn.has("vim_starting") then
    local minpac_dir = base_dir .. "/pack/minpac/opt/minpac"
    if not path.is_dir(vim.fn.expand(minpac_dir)) then
      print("Install minpac ...")
      os.execute("git clone --depth 1 https://github.com/k-takata/minpac.git " .. minpac_dir)
    end
  end
end

function M.pack_init()
  if M._is_minpac_initilized then
    return
  end

  local base_dir = vim.env.VIM_CACHE_HOME
  vim.o.packpath = base_dir

  ensure_minpac(base_dir)

  vim.cmd("packadd minpac")
  vim.fn["minpac#init"]({dir = vim.env.VIM_CACHE_HOME})
  for _, p in ipairs(M.plugins) do
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

  M._is_minpac_initilized = true
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
