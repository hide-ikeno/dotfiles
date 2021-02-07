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

function M.config()
  local telescope = require("telescope")
  local sorters = require("telescope.sorters")
  telescope.setup {
    defaults = {
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
      preview_cutoff = 100,
      file_sorter = sorters.get_fzy_sorter,
    },
    extensions = {
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
      }
    }
  }
  telescope.load_extension("gh")
  telescope.load_extension("dap")
end

return M
