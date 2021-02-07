return {
  "neovim/nvim-lspconfig",
  event = {"BufRead *"},
  requires = {
    {"nvim-lua/lsp-status.nvim", opt = true},
    {"glepnir/lspsaga.nvim", opt = true},
  },
  setup = "require'conf.nvim-lspconfig'.setup()",
  config = "require'conf.nvim-lspconfig'.config()",
}
