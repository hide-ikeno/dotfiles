local M = {}

function M.setup()
  vim.g.format_debug = true
  vim.api.nvim_set_keymap("n", "<Leader>F", ":Format<CR>", {silent = true})
  vim.api.nvim_set_keymap("x", "<Leader>F", ":Format<CR>", {silent = true})

  -- Format on save
  vim.cmd("augroup format_nvim_setting")
  vim.cmd("autocmd!")
  vim.cmd("autocmd BufWritePost * FormatWrite")
  vim.cmd("augroup END")
end

function M.config()
  require "format".setup {
    -- ["*"] = {
    --   {cmd = {"sed -i 's/[ \t]*$//'"}} -- remove trailing whitespace
    -- },
    -- vim = {
    --   {
    --     cmd = {"luafmt -w replace"},
    --     start_pattern = "^lua << EOF$",
    --     end_pattern = "^EOF$"
    --   }
    -- },
    vimwiki = {
      {
        cmd = {"prettier -w --parser babel"},
        start_pattern = "^{{{javascript$",
        end_pattern = "^}}}$"
      }
    },
    -- lua = {
    --   {
    --     cmd = {
    --       function(file)
    --         return string.format("luafmt -l %s -w replace %s", vim.bo.textwidth, file)
    --       end
    --     }
    --   }
    -- },
    -- go = {
    --   {
    --     cmd = {"gofmt -w", "goimports -w"},
    --     tempfile_postfix = ".tmp"
    --   }
    -- },
    javascript = {
      {cmd = {"prettier -w", "./node_modules/.bin/eslint --fix"}}
    },
    markdown = {
      {cmd = {"prettier -w"}},
      {
        cmd = {"black"},
        start_pattern = "^```python$",
        end_pattern = "^```$",
        target = "current"
      }
    },
    python = {
      {cmd = {"black", "isort"}}
    },
    sh = {
      {cmd = {"shfmt -ci -s -bn"}}
    }
  }
end

return M
