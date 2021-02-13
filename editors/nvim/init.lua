-- ~/.config/nvim/init.lua -- NeoVim configuration

-- for vim.opt
require("core.opt")

-- Set envs
require("envs").setup()

-- Nvim startup
require("startup").setup()

-- Plugins
require("plugins")

-- Set options
require("options")

-- Key mappings
require("mappings")

-- Filetype settings
require("ftplugin").setup()

-- Appearance
-- require("style")
require("appearance")
