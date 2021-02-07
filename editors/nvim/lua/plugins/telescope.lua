return {
  "nvim-telescope/telescope.nvim",
  requires = {
    { "nvim-lua/popup.nvim", opt = true },
    { "nvim-lua/plenary.nvim", opt = true },
    { "kyazdani42/nvim-web-devicons", opt = true },
    { "nvim-telescope/telescope-dap.nvim", opt = true },
    {
      "nvim-telescope/telescope-frecency.nvim",
      requires = {"tami5/sql.nvim"},
      opt = true,
    },
    { "nvim-telescope/telescope-fzy-native.nvim", opt = true },
    { "nvim-telescope/telescope-ghq.nvim", opt = true },
    { "nvim-telescope/telescope-github.nvim", opt = true },
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

    -- mappings
    -- key mappings
    local opts = {noremap = true, silent = true}
    -- key mappings
    vim.api.nvim_set_keymap("n", "<Space>b", "<cmd>lua require'telescope.builtin'.buffers{ shorten_path = true, initial_mode='normal' }<CR>", opts)
    -- vim.api.nvim_set_keymap("n", "<Space>f", "<cmd>lua require'telescope.builtin'.find_files{}<CR>", opts)
    vim.api.nvim_set_keymap("n", "<Space>f", "<cmd>lua require'telescope.builtin'.find_files{}<CR>", opts)
    vim.api.nvim_set_keymap("n", "<Space>h", "<cmd>lua require'telescope.builtin'.help_tags{}<CR>", opts)
    vim.api.nvim_set_keymap("n", "<Space>p", "<cmd>lua require'telescope.builtin'.git_files{ shorten_path = true }<CR>", opts)
    vim.api.nvim_set_keymap("n", "<Space>o", "<cmd>lua require'telescope.builtin'.oldfiles{}<CR>", opts)
    vim.api.nvim_set_keymap("n", "<Space>t", "<cmd>lua require'telescope.builtin'.treesitter{}<CR>", opts)
    vim.api.nvim_set_keymap("n", "<Space>;", "<cmd>lua require'telescope.builtin'.command_history{}<CR>", opts)

    -- LSP
    vim.api.nvim_set_keymap("n", "<Space>a", "<cmd>lua require'telescope.builtin'.lsp_code_actions{}<CR>", opts)
    vim.api.nvim_set_keymap("n", "<Space>r", "<cmd>lua require'telescope.builtin'.lsp_references{}<CR>", opts)
    vim.api.nvim_set_keymap("n", "<Space>s", "<cmd>lua require'telescope.builtin'.lsp_document_symbols{}<CR>", opts)
    vim.api.nvim_set_keymap("n", "<Space>S", "<cmd>lua require'telescope.builtin'.lsp_workspace_symbols{}<CR>", opts)

    -- grep / search
    vim.api.nvim_set_keymap("n", "<Space>/", "<cmd>lua require'telescope.builtin'.live_grep{ shorten_path = true }<CR>", opts)
    vim.api.nvim_set_keymap("n", "<Space>G", "<cmd>lua require'telescope.builtin'.grep_string{ shorten_path = true }<CR>", opts)
    vim.api.nvim_set_keymap("n", "<Space>l", "<cmd>lua require'telescope.builtin'.current_buffer_fuzzy_find{}<CR>", opts)

    -- github CLI integlation
    vim.api.nvim_set_keymap("n", "<Space>ghi", "<cmd>lua require'telescope.builtin'.gh_issues()<CR>", opts)
    vim.api.nvim_set_keymap("n", "<Space>ghp", "<cmd>lua require'telescope.builtin'.gh_pull_request()<CR>", opts)
    vim.api.nvim_set_keymap("n", "<Space>ghg", "<cmd>lua require'telescope.builtin'.gh_gist()<CR>", opts)

    -- frecency
    vim.api.nvim_set_keymap("n", "<Space><Space>", "<cmd>lua require'telescope'.extensions.frecency.frecency()<CR>", opts)

    -- packer.nvim
    vim.api.nvim_set_keymap("n", "<Space>P", "<cmd>lua require'telescope'.extensions.packer.plugins()<CR>", opts)

    -- nvim-dap integration
    vim.api.nvim_set_keymap("n", "<Space>dc", "<cmd>lua require'telescope'.extensions.dap.commends()<CR>", opts)
    vim.api.nvim_set_keymap("n", "<Space>dC", "<cmd>lua require'telescope'.extensions.dap.configurations()<CR>", opts)
    vim.api.nvim_set_keymap("n", "<Space>dl", "<cmd>lua require'telescope'.extensions.dap.list_breakpoints()<CR>", opts)
    vim.api.nvim_set_keymap("n", "<Space>dv", "<cmd>lua require'telescope'.extensions.dap.variables()<CR>", opts)
  end,
}
