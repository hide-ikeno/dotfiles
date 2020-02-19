-- vim-packager
-- See `autoload/packages.vim` for plugin list and the definition of PackagerInit()
local function setup()
  vim.api.nvim_command [[command! PackagerInstall call packages#PackagerInit() | call packager#install()]]
  vim.api.nvim_command [[command! -bang PackagerUpdate call packages#PackagerInit() | call packager#update({ 'force_hooks': '<bang>'  })]]
  vim.api.nvim_command [[command! PackagerClean call packages#PackagerInit() | call packager#clean()]]
  vim.api.nvim_command [[command! PackagerStatus call packages#PackagerInit() | call packager#status()]]
end

return { setup = setup }
