local M = {}

function M.hook_add()
  vim.g.vim_markdown_frontmatter = 1
  vim.g.vim_markdown_math        = 1
  vim.g.vim_markdown_conceal     = 0
end

return M

