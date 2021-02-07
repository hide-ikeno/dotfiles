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
    "b3nj5m1n/kommentary",
    keys = {
      {"n", "<Plug>kommentary_" },
      {"v", "<Plug>kommentary_" },
    },
    setup = function()
      vim.g.kommentary_create_default_mappings = false
      vim.api.nvim_set_keymap("n", "<leader>cc", "<Plug>kommentary_line_default",  {silent = true})
      vim.api.nvim_set_keymap("n", "<leader>c", "<Plug>kommentary_motion_default", {silent = true})
      vim.api.nvim_set_keymap("v", "<leader>c", "<Plug>kommentary_visual_default", {silent = true})
    end,
    config = function()
      local conf = require("kommentray.config")
      conf.configure_language("c", {
        single_line_comment_string = false,
        multi_line_comment_strings = {"/*", "*/"},
      })
      conf.configure_language("cpp", {
        single_line_comment_string = "//",
        multi_line_comment_strings = {"/*", "*/"},
        prefer_single_line_comments = true,
      })
      conf.configure_language("lua", {
        prefer_single_line_comments = true,
      })
      conf.configure_language("python", {
        single_line_comment_string = "#",
        multi_line_comment_strings = false,
      })
      conf.configure_language("rust", {
        single_line_comment_string = "//",
        multi_line_comment_strings = {"/*", "*/"},
        prefer_single_line_comments = true,
      })
    end
  },

  -- {
  --   "tyru/caw.vim",
  --   requires = {
  --     "context_filetype.vim",
  --     "vim-repeat",
  --     "vim-operator-user",
  --   },
  --   event = "CursorMoved *",
  --   setup = "require'conf.caw'.setup()",
  -- },

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
  }
}
