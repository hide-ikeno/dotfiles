return {
  {
    "hrsh7th/nvim-compe",
    event = { "InsertEnter *" },
    config = function()
      local compe = require("compe")
      compe.setup {
        enabled      = true,
        autocomplete = true,
        debug        = false,
        min_length   = 1,
        preselect    = "always",
        source = {
          path          = true,
          buffer        = true,
          calc          = true,
          vsnip         = true,
          nvim_lsp      = true,
          nvim_lua      = true,
          spell         = true,
          tags          = true,
          snippets_nvim = false,
          treesitter    = true,
        }
      }
      local opts = { silent = true, expr = true }
      vim.api.nvim_set_keymap("i", "<C-Space>", [[compe#complete()]], opts)
      vim.api.nvim_set_keymap("i", "<C-e>", [[compe#close('<C-e>')]], opts)
      vim.api.nvim_set_keymap("i", "<CR>", [[compe#confirm('<CR>')]], opts)

      -- We have to register sources manually, because packadd doesn't source
      -- files from "after" directory inside "opt" directory.
      -- See https://github.com/vim/vim/issues/1994
      for _, src in ipairs{
        "buffer", "calc", "nvim_lua", "path", "snippets_nvim", "spell",
        "tags", "treesitter", "vsnip"
      } do
        vim.g["loaded_compe_"..src] = true
        compe.register_source(src, require("compe_"..src))
      end
      vim.g.loaded_compe_nvim_lsp = true
      require("compe_nvim_lsp").attach()
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
    config = function()
      local opts = { expr = true }
      vim.api.nvim_set_keymap("i", "<Tab>", [[vsnip#available(1) ? '<Plug>(vsnip-expand-or-jump)' : '<Tab>']], opts)
      vim.api.nvim_set_keymap("s", "<Tab>", [[vsnip#available(1) ? '<Plug>(vsnip-jump-next)' : '<Tab>']], opts)
      vim.api.nvim_set_keymap("i", "<S-Tab>", [[vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']], opts)
      vim.api.nvim_set_keymap("s", "<S-Tab>", [[vsnip#available(-1) ? '<Plug>(vsnip-jump-prev)' : '<S-Tab>']], opts)
    end,
  }
}
