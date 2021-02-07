return {
  {
    "hrsh7th/nvim-compe",
    event = {"InsertEnter *"},
    config = function()
      require("compe").setup{
        enabled = true,
        autocomplete = true,
        debug = false,
        min_length = 2,
        preselect = "always",
        source = {
          -- builtin
          path = true,
          buffer = true,
          tags = true,
          spell = true,
          calc = true,
          -- Neovim specific
          nvim_lsp = true,
          nvim_lua = true,
          -- external plugins
          vsnip = true,
        }
      }
    end
  },
  {
    "hrsh7th/vim-vsnip",
    event = { "InsertCharPre *" },
    setup = function()
      -- Uer snippet directory
      vim.g.vsnip_snippet_dir = vim.fn.stdpath("config") .. "/snippets"
      -- Plugin snippets directories
      -- vim.g.vsnip_snippet_dirs = { vim.fn.stdpath("config") .. "/snippets" }
    end,
  }
}
