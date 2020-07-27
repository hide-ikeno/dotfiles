local M = {}

function M.setup()
  -- variables
  vim.g.fzf_preview_use_dev_icons = 1

  -- key mappings
  local opts = {noremap = true, silent = true}
  vim.api.nvim_set_keymap("n", "<Space>B", "<cmd>FzfPreviewAllBuffers<CR>", opts)

  vim.api.nvim_set_keymap("n", "<Space>b", "<cmd>FzfPreviewBuffers<CR>", opts)
  vim.api.nvim_set_keymap("n", "<Space>f", "<cmd>FzfPreviewFromResources directory old<CR>", opts)
  vim.api.nvim_set_keymap("n", "<Space>l", "<cmd>FzfPreviewLocationList<CR>", opts)
  vim.api.nvim_set_keymap("n", "<Space>p", "<cmd>FzfPreviewFromResources project_mru git<CR>", opts)
  vim.api.nvim_set_keymap("n", "<Space>q", "<cmd>FzfPreviewQuickfix<CR>", opts)
  vim.api.nvim_set_keymap("n", "<Space>t", "<cmd>FzfPreviewBufferTags<CR>", opts)

  vim.api.nvim_set_keymap(
    "n", "<Space>/",
    [[:<C-u>FzfPreviewLines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'"<CR>]],
    opts)
  vim.api.nvim_set_keymap(
    "n", "<Space>*",
    [[:<C-u>FzfPreviewLines --add-fzf-arg=--no-sort --add-fzf-arg=--query="'<C-r>=expand('<cword>')<CR>"<CR>]],
    opts)
  vim.api.nvim_set_keymap("n", "<Space>G", ":<C-u>FzfPreviewProjectGrep<Space>", {noremap = true})
  vim.api.nvim_set_keymap(
    "x", "<Space>G",
    [["sy:FzfPreviewProjectGrep<Space>-F<Space>"<C-r>=substitute(substitute(@s, '\n', '', 'g'), '/', '\\/', 'g')<CR>"]],
    {noremap = true}
    )
end

return M
