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

  vim.cmd[[packadd packer.nvim]]
end

function _G.run_packer(method)
  vim.cmd[[packadd packer.nvim]]
  require("plugins.load")[method]()
end

-- Packer commands
vim.cmd[[command! PackerInstall lua run_packer'install']]
vim.cmd[[command! PackerUpdate  lua run_packer'update']]
vim.cmd[[command! PackerSync    lua run_packer'sync']]
vim.cmd[[command! PackerClean   lua run_packer'clean']]
vim.cmd[[command! PackerCompile lua run_packer'compile']]
