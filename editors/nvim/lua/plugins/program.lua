return {
  -- EditorConfig
  {
    "editorconfig/editorconfig-vim",
    setup = function()
      vim.g.EditorConfig_exclude_patterns = {
        'scp://.*',
        'term://.*',
        'gina://.*',
        'fugitive://.*',
      }
    end
  },

  -- Visually displaying indent levels in code
  {
    "glepnir/indent-guides.nvim",
    config = function()
      require('indent_guides').setup{
        indent_levels = 30;
        indent_guide_size = 1;
        indent_start_level = 2;
        indent_space_guides = true;
        indent_tab_guides = true;
        indent_pretty_guides = false;
        indent_soft_pattern = '\\s';
        exclude_filetypes = {
          "help", "denite", "denite-filter", "LuaTree", "NvimTree",
          "startify", "vista", "vista_kind", "sagehover", "tagbar"
        },
        even_colors = { fg = "NONE", bg = "#49464e" },
        odd_colors = { fg = "NONE", bg = "#3b383e" },
      }
    end
  },

  -- Comment plugin
  {
    "terrortylor/nvim-comment",
    config = function()
      require('nvim_comment').setup {
        -- Linters prefer comment and line to have a space in between markers
        marker_padding = true,
        -- should comment out empty or whitespace only lines
        comment_empty = false,
        -- Should key mappings be created
        create_mappings = true,
        -- Normal mode mapping left hand side
        line_mapping = "<Leader>cc",
        -- Visual/Operator mapping left hand side
        operator_mapping = "<Leader>c"
      }
    end,
  },

  -- View and search LSP symbols, tags in Vim/Neovim
  {
    "liuchengxu/vista.vim",
    cmd = {"Vista"},
    setup = function()
      vim.api.nvim_set_keymap("n", "<Space>v", "<cmd>Vista!!<CR>", {noremap = true, silent = true})

      vim.g.vista_default_executive = "ctags"
      vim.g.vista_executive_for = {
        c          = "nvim_lsp",
        cpp        = "nvim_lsp",
        css        = "nvim_lsp",
        dockerfile = "nvim_lsp",
        fortran    = "nvim_lsp",
        go         = "nvim_lsp",
        lua        = "nvim_lsp",
        javascript = "nvim_lsp",
        python     = "nvim_lsp",
        ruby       = "nvim_lsp",
        rust       = "nvim_lsp",
        sh         = "nvim_lsp",
        tex        = "nvim_lsp",
        typescript = "nvim_lsp",
      }
    end
  },

  -- (DO)cument (GE)nerator
  {
    "kkoomen/vim-doge",
    run =  ":call doge#install()",
    ft = {
      "python", "php", "javascript", "typescript", "coffee", "lua", "java",
      "groovy", "ruby", "scalar", "kotlin", "r", "c", "cpp", "sh"
    },
    --setup = "require'conf.vim-doge'.setup()"
    setup = function()
      vim.g.doge_doc_standard_c      = "doxygen_qt"
      vim.g.doge_doc_standard_cpp    = "doxygen_qt"
      vim.g.doge_doc_standard_python = "numpy"
      -- Key mappings
      vim.g.doge_mapping = "<Leader>d"
      vim.g.doge_mapping_comment_jump_forward  = "<M-n>"
      vim.g.doge_mapping_comment_jump_backward = "<M-p>"
    end
  },

  -- Language Server Protocol (LSP)
  {
    "neovim/nvim-lspconfig",
    event = {"BufRead *"},
    requires = {
      {"nvim-lua/lsp-status.nvim", opt = true},
      {"glepnir/lspsaga.nvim", opt = true},
    },
    setup = function()
      require'conf.lspconfig'.setup()
    end,
    config = function()
      vim.cmd [[packadd lsp-status.nvim]]
      vim.cmd [[packadd lspsaga.nvim]]
      require'conf.lspconfig'.config()
    end
  },

  -- Debug Adapter Protocol client implementation for Neovim
  {
    "mfussenegger/nvim-dap",
    ft = { "c", "cpp", "python", "rust", },
    requires = {
      { "mfussenegger/nvim-dap-python", opt = true },
      { "theHamsta/nvim-dap-virtual-text", opt = true },
    },
    config = function()
      vim.cmd[[packadd nvim-dap-python]]
      vim.cmd[[packadd nvim-dap-virtual-text]]
      require'conf.dap'.config()
    end
  },
}
