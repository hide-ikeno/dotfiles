-- ~/.config/nvim/init.lua -- NeoVim configuration

-- Set envs
require('envs').setup()

-- Nvim core settings
require('core').setup()
require('options')

-- Plugins
require("plugins")

-- Key mappings
require("mappings")

-- Filetype settings
require("filetype").setup()

-- Appearance
-- require("style")
require("appearance")
