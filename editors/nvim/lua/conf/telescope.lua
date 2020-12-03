local M = {}

function M.find_files()
  -- command for find file
  local ignore_globs = {
    ".git", ".ropeproject", "__pycache__", ".venv", "venv",
    "node_modules", "images", "*.min.*", "img", "fonts"
  }
  local cmd = nil;
  if vim.fn.executable("fd") then
    cmd = {"fd", ".", "--hidden", "--type", "f"}
    for _, x in ipairs(ignore_globs) do
      table.insert(cmd, "--exclude")
      table.insert(cmd, x)
    end
  elseif vim.fn.executable("rg") then
    cmd = {"rg", "--follow", "--hidden", "--files"}
    for _, x in ipairs(ignore_globs) do
      table.insert(cmd, "--glob=!" .. x)
    end
  elseif vim.fn.executable("ag") then
    cmd = {"ag", "-U", "--hidden", "--follow"}
    for _, x in ipairs(ignore_globs) do
      table.insert(cmd, "--exclude=" .. x)
    end
    for _, x in ipairs({"--nocolor", "--nogroup", "-g", ""}) do
      table.insert(cmd, x)
    end
  end

  require'telescope.builtin'.find_files{
    find_command = cmd
  }
end

function M.setup()
  -- key mappings
  local opts = {noremap = true, silent = true}
  vim.api.nvim_set_keymap("n", "<Space>b", "<cmd>lua require'telescope.builtin'.buffers{ shorten_path = true }<CR>", opts)
  -- vim.api.nvim_set_keymap("n", "<Space>f", "<cmd>lua require'telescope.builtin'.find_files{}<CR>", opts)
  vim.api.nvim_set_keymap("n", "<Space>f", "<cmd>lua require'conf.telescope'.find_files{}<CR>", opts)
  vim.api.nvim_set_keymap("n", "<Space>h", "<cmd>lua require'telescope.builtin'.help_tags{}<CR>", opts)
  vim.api.nvim_set_keymap("n", "<Space>p", "<cmd>lua require'telescope.builtin'.git_files{ shorten_path = true }<CR>", opts)
  vim.api.nvim_set_keymap("n", "<Space>o", "<cmd>lua require'telescope.builtin'.oldfiles{}<CR>", opts)
  vim.api.nvim_set_keymap("n", "<Space>t", "<cmd>lua require'telescope.builtin'.treesitter{}<CR>", opts)
  vim.api.nvim_set_keymap("n", "<Space>;", "<cmd>lua require'telescope.builtin'.command_history{}<CR>", opts)

  -- LSP
  vim.api.nvim_set_keymap("n", "<Space>r", "<cmd>lua require'telescope.builtin'.lsp_code_actions{}<CR>", opts)
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

  -- packer.nvim
  vim.api.nvim_set_keymap("n", "<Space>P", "<cmd>lua require'telescope'.extensions.packer.plugins()<CR>", opts)
end

function M.config()
  local telescope = require("telescope")
  telescope.setup {
    extensions = {
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
      }
    }
  }
  telescope.load_extension("ghcli")
end

return M
