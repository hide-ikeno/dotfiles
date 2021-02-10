return {
  "nvim-telescope/telescope.nvim",
  requires = {
    { "nvim-lua/popup.nvim", opt = true },
    { "nvim-lua/plenary.nvim", opt = true },
    { "kyazdani42/nvim-web-devicons", opt = true },
    { "nvim-telescope/telescope-dap.nvim", opt = true },
    {
      "nvim-telescope/telescope-frecency.nvim",
      requires = {"tami5/sql.nvim", opt = true},
      opt = true,
    },
    { "nvim-telescope/telescope-fzf-writer.nvim", opt = true },
    { "nvim-telescope/telescope-fzy-native.nvim", opt = true },
    { "nvim-telescope/telescope-ghq.nvim", opt = true },
    { "nvim-telescope/telescope-packer.nvim", opt = true },
    { "nvim-telescope/telescope-symbols.nvim", opt = true },
  },

  cmd = { "Telescope" },

  keys = {
    "<Space>b",
    "<Space>f",
    "<Space>h",
    "<Space>l",
    "<Space>p",
    "<Space>t",
    "<Space>;",
    "<Space>/",
    "<Space>G",
    "<Space>P",
  },

  config = function()
    for _, name in pairs {
      'nvim-web-devicons',
      'popup.nvim',
      'sql.nvim',
      'telescope-frecency.nvim',
      'telescope-fzf-writer.nvim',
      'telescope-fzy-native.nvim',
      'telescope-ghq.nvim',
      'telescope-github.nvim',
      'telescope-packer.nvim',
      'telescope-symbols.nvim',
    } do vim.cmd('packadd '..name) end

    local telescope = require("telescope")
    local actions = require("telescope.actions")
    local previewers = require("telescope.previewers")
    local sorters = require("telescope.sorters")
    telescope.setup {
      defaults = {
        prompt_position = "top",
        prompt_prefix = " >",
        layout_strategy = "flex",
        layout_default = {
          horizontal = {
            width_padding = 0.1,
            height_padding = 0.1,
            preview_width = 0.6,
          },
          vertical = {
            width_padding = 0.05,
            height_padding = 1,
            preview_width = 0.5,
          },
        },

        file_sorter = sorters.get_fzy_sorter,

        color_devicons = true,

        preview_cutoff = 100,
        file_previewer = previewers.vim_buffer_cat.new,
        grep_previewer = previewers.vim_buffer_vimgrep.new,
        qflist_previewer = previewers.vim_buffer_qflist.new,

        mappings = {
          -- insert mode
          i = {
            ["<Tab>"] = actions.toggle_selection,
            ["<C-q>"] = actions.send_to_qflist,
            ["<M-q>"] = actions.send_selected_to_qflist,
          },
          -- normal mode
          n = {
            ["q"] = actions.close,
            ["<Space>"] = actions.toggle_selection,
            ["<C-q>"] = actions.send_to_qflist,
            ["<M-q>"] = actions.send_selected_to_qflist,
          },
        },
      },

      extensions = {
        frecency = {
          ignore_patterns = {
            "*.git/*",
            "*/tmp/*",
            "*/build/*",
          },
          show_scores = true,
          show_unindexed = true,
        },

        fzf_writer = {
          minimum_grep_characters = 3,
          minimum_files_characters = 3,
          use_highlighter = false
        },

        fzy_native = {
          override_generic_sorter = false,
          override_file_sorter = true,
        },
      },
    }

    pcall(telescope.load_extension, "dap")
    pcall(telescope.load_extension, "freceny")
    pcall(telescope.load_extension, "fzy_native")
    pcall(telescope.load_extension, "gh")
    pcall(telescope.load_extension, "ghq")

    -- find command
    local ignore_globs = {
      ".git", ".ropeproject", "__pycache__", ".venv", "venv",
      "node_modules", "images", "*.min.*", "img", "fonts"
    }
    local find_cmd;
    if vim.fn.executable("fd") then
      find_cmd = {"fd", ".", "--hidden", "--type", "f"}
      for _, x in ipairs(ignore_globs) do
        table.insert(find_cmd, "--exclude")
        table.insert(find_cmd, x)
      end
    elseif vim.fn.executable("rg") then
      find_cmd = {"rg", "--follow", "--hidden", "--files"}
      for _, x in ipairs(ignore_globs) do
        table.insert(find_cmd, "--glob=!" .. x)
      end
    elseif vim.fn.executable("ag") then
      find_cmd = {"ag", "-U", "--hidden", "--follow"}
      for _, x in ipairs(ignore_globs) do
        table.insert(find_cmd, "--exclude=" .. x)
      end
      for _, x in ipairs({"--nocolor", "--nogroup", "-g", ""}) do
        table.insert(find_cmd, x)
      end
    end

    -- mappings
    local map_builtin = function(key, f, options)
      local mode = "n"
      local rhs = string.format(
        "<cmd>lua require('telescope.builtin')['%s'](%s)<CR>",
        f,
        options and vim.inspect(options, { newline = '' }) or ''
      )
      local opts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap(mode, key, rhs, opts)
    end

    local map_extension = function(key, e, f, options)
      local mode = "n"
      local rhs = string.format(
        "<cmd>lua require('telescope').extensions['%s']['%s'](%s)<CR>",
        e, f,
        options and vim.inspect(options, { newline = '' }) or ''
      )
      local opts = { noremap = true, silent = true }
      vim.api.nvim_set_keymap(mode, key, rhs, opts)
    end

    -- File pickers
    map_builtin("<Space>f", "find_files", { find_command = find_cmd })
    map_builtin("<Space>p", "git_files", { shorten_path = false })
    map_builtin("<Space>G", "grep_string", { shorten_path = true })

    -- Vim pickers
    map_builtin("<Space>b", "buffers", {
      shorten_path = false, initial_mode = 'normal'
    })
    map_builtin("<Space>h", "help_tags", { show_version = true })
    map_builtin("<Space>;", "command_history")
    map_builtin("<Space>t", "treesitter")
    map_builtin("<Space>l", "current_buffer_fuzzy_find", {
      winblend = 10,
      border = true,
      previewer = false,
      shorten_path = false,
    })

    -- LSP pickers
    map_builtin("<Space>a", "lsp_code_actions")
    map_builtin("<Space>r", "lsp_references")
    map_builtin("<Space>s", "lsp_documen_symbols")
    map_builtin("<Space>S", "lsp_workspace_symbols")

    -- Git pickers
    map_builtin("<Space>gb", "git_branchs", { initial_mode = "normal" })
    map_builtin("<Space>gc", "git_bcommits", { initial_mode = "normal" })
    map_builtin("<Space>gC", "git_commits", { initial_mode = "normal" })
    -- map_builtin("<Space>gs", "git_status", { initial_mode = "normal" })

    -- frecency
    map_extension("<Space>o", "frecency", "frecency", {
      shorten_path = true,
      previewer = false,
      fzf_separator = "|>",
    })

    -- fzf-writer
    map_extension("<Space>/", "fzf_writer", "staged_grep", {
      layout_strategy = "vertical"
    })

    -- nvim-dap inl_defaultctegration
    map_extension("<Space>dc", "dap", "commands")
    map_extension("<Space>dC", "dap", "configurations")
    map_extension("<Space>dl", "dap", "list_breakpoints")
    map_extension("<Space>dv", "dap", "variables;")
  end,
}
