return {
  -- Colorschemes
  { "sainnhe/edge",             opt = true },
  { "sainnhe/forest-night",     opt = true },
  { "sainnhe/gruvbox-material", opt = true },
  { "sainnhe/sonokai",          opt = true },

  -- A snazzy bufferline for Neovim
  {
    "akinsho/nvim-bufferline.lua",
    requires = { "kyazdani42/nvim-web-devicons", opt = true },
    config = function()
      require("bufferline").setup{
        options = {
          mappings = true,
          always_show_bufferline = true,
        }
      }
    end
  }
}


