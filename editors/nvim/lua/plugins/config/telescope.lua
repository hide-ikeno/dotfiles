local M = {}

-- [[ Custom Pickers ]]

function M.edit_nvim_config()
  require('telescope.builtin').find_files {
    find_command = M._find_command,
    prompt_title = "~ dotfiles ~",
    shorten_path = false,
    cwd = "~/.config/nvim",

    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.65 },
  }
end

function M.edit_zsh_config()
  require('telescope.builtin').find_files {
    find_command = M._find_command,
    prompt_title = "~ dotfiles ~",
    shorten_path = false,
    cwd = "~/.config/zsh",

    file_ignore_patterns = { ".zcompdump", ".zcompcache", ".*.zwc" },
    layout_strategy = "horizontal",
    layout_config = { preview_width = 0.55 },
  }
end

function M.fd()
  require("telescope.builtin").find_files { find_command = M._find_command }
end

function M.fd_all()
  require("telescope.builtin").find_files { find_command = M._find_all_command }
end

function M.git_files()
  local opts = require("telescope.themes").get_dropdown {
    previewer = false,
    shorten_path = false,
  }
  require("telescope.builtin").git_files(opts)
end

function M.grep_prompt()
  require("telescope.builtin").grep_string {
    shorten_path = true,
    search = vim.fn.input("Grep String > "),
  }
end

function M.grep_last_search()
  local register = vim.fn.getreg('/'):gsub('\\<', ''):gsub('\\>', ''):gsub(
    "\\C", ""
  )
  local opts = { shorten_path = true, word_match = "-w", search = register }
  require("telescope.builtin").grep_string(opts)
end

function M.live_grep()
  require("telescope").extensions.fzf_writer.staged_grep {
    shorten_path = true,
    previewer = false,
  }
end

function M.file_browser()
  require("telescope.builtin").file_browser {
    sorting_strategy = "ascending",
    scroll_strategy = "cycle",
    prompt_position = "top",
  }
end

function M.buffers()
  require("telescope.builtin").buffers {
    shorten_path = false,
    initial_mode = "normal",
  }
end

function M.current_buffer_fuzzy_find()
  local opts = require("telescope.themes").get_dropdown {
    border = true,
    previewer = false,
    shorten_path = false,
  }
  require("telescope.builtin").current_buffer_fuzzy_find(opts)
end

function M.oldfiles() require("telescope").extensions.frecency.frecency() end

function M.help_tags()
  require("telescope.builtin").help_tags { show_version = true }
end

M.pickers = setmetatable(
  {}, {
    __index = function(_, k)
      if M[k] then
        return M[k]
      else
        return require("telescope.builtin")[k]
      end
    end,
  }
)

-- setup: called befor loading telescope.nvim
function M.setup()
  -- find command
  local ignore_globs = {
    ".git",
    ".ropeproject",
    "__pycache__",
    ".venv",
    "venv",
    "node_modules",
    "images",
    "*.min.*",
    "img",
    "fonts",
  }
  local find_cmd, find_all_cmd;
  if vim.fn.executable("fd") then
    find_cmd = { "fd", ".", "--hidden", "--follow", "--type", "f" }
    find_all_cmd = vim.deepcopy(find_cmd)
    table.insert(find_all_cmd, "--no-ignore")
    for _, x in ipairs(ignore_globs) do
      table.insert(find_cmd, "--exclude")
      table.insert(find_cmd, x)
    end
  elseif vim.fn.executable("rg") then
    find_cmd = { "rg", "--follow", "--hidden", "--files" }
    find_all_cmd = vim.deepcopy(find_cmd)
    table.insert(find_all_cmd, "--no-ignore")
    for _, x in ipairs(ignore_globs) do
      table.insert(find_cmd, "--glob=!" .. x)
    end
  end

  M._find_command = find_cmd
  M._find_all_command = find_all_cmd
end

-- config: called after telescope.nvim is loaded
function M.config()
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
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        },
        -- normal mode
        n = {
          ["q"] = actions.close,
          ["<Space>"] = actions.toggle_selection,
          ["<C-n>"] = actions.move_selection_next,
          ["<C-p>"] = actions.move_selection_previous,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
        },
      },
    },

    extensions = {
      frecency = {
        ignore_patterns = { "*.git/*", "*/tmp/*", "*/build/*" },
        show_scores = true,
        show_unindexed = true,
        workspaces = {
          ["conf"] = vim.env.XDG_CONFIG_HOME,
          ["data"] = vim.env.XDG_DATA_HOME,
        },
      },

      fzf_writer = {
        minimum_grep_characters = 3,
        minimum_files_characters = 3,
        use_highlighter = false,
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
  local set_keymap = function(key, f, options, buffer)
    local mode = "n"
    local rhs = string.format(
      "<cmd>lua require('plugins.config.telescope').pickers['%s'](%s)<CR>", f,
      options and vim.inspect(options, { newline = '' }) or ''
    )
    local map_opts = { noremap = true, silent = true }
    if buffer then
      vim.api.nvim_buf_set_keymap(0, mode, key, rhs, map_opts)
    else
      vim.api.nvim_set_keymap(mode, key, rhs, map_opts)
    end
  end

  local map_extension = function(key, e, f, options)
    local mode = "n"
    local rhs = string.format(
      "<cmd>lua require('telescope').extensions['%s']['%s'](%s)<CR>", e, f,
      options and vim.inspect(options, { newline = '' }) or ''
    )
    local opts = { noremap = true, silent = true }
    vim.api.nvim_set_keymap(mode, key, rhs, opts)
  end

  -- Call telescope on command line mode
  vim.api.nvim_set_keymap(
    "c", "<C-r><C-r>", "<Plug>(TelescopeFuzzyCommandSearch)",
    { noremap = true, nowait = true }
  )

  -- File pickers
  set_keymap("<Space>en", "edit_nvim_config")
  set_keymap("<Space>ez", "edit_zsh_config")

  set_keymap("<Space>fd", "fd")
  set_keymap("<Space>fD", "fd_all")
  set_keymap("<Space>fe", "file_browser")
  set_keymap("<Space>fg", "live_grep")
  set_keymap("<Space>fG", "grep_prompt")
  set_keymap("<Space>fo", "oldfiles")
  set_keymap("<Space>ft", "git_files")
  set_keymap("<Space>f/", "grep_last_search")

  -- Vim pickers
  set_keymap("<Space>fb", "buffers")
  set_keymap("<Space>fh", "help_tags")
  set_keymap("<Space>ff", "current_buffer_fuzzy_find")

  -- LSP pickers
  set_keymap("<Space>la", "lsp_code_actions")
  set_keymap("<Space>lr", "lsp_references")
  set_keymap("<Space>ls", "lsp_documen_symbols")
  set_keymap("<Space>lS", "lsp_workspace_symbols")

  -- Git pickers
  set_keymap("<Space>gb", "git_branchs", { initial_mode = "normal" })
  set_keymap("<Space>gc", "git_bcommits", { initial_mode = "normal" })
  set_keymap("<Space>gC", "git_commits", { initial_mode = "normal" })
  set_keymap("<Space>gs", "git_status", { initial_mode = "normal" })

  -- nvim-dap inl_defaultctegration
  map_extension("<Space>dc", "dap", "commands")
  map_extension("<Space>dC", "dap", "configurations")
  map_extension("<Space>dl", "dap", "list_breakpoints")
  map_extension("<Space>dv", "dap", "variables;")
end

return M
