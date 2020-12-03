require('envs').setup()

require('core').setup()

-- Global options (Nvim core)
require('options')

-- Plugins
require("plugins")

-- Key mappings
require("mappings")

-- Filetype settings
require("filetype").setup()

-- Appearance
require("style")
