local plug = require("core.plug")

local layer = {}

function layer.register_plugins()
  -- Provides the branch name of the current git repository
  plug.add_plugin("itchyny/vim-gitbranch")
  -- Show a diff using Vim its sign column
  plug.add_plugin("mhinz/vim-signify")
  -- Reveal the commit messages under the cursor
  plug.add_plugin("rhysd/git-messenger.vim", {type = "opt"})
  -- layerore pleasant editing on commit messages
  plug.add_plugin("rhysd/committia.vim", {type = "opt"})
end

function layer.init_config()
  -- vim-signify
  vim.api.nvim_set_keymap("n", "<Leader>gd", "<cmd>SignifyDiff<CR>",     {silent = true, noremap = true})
  vim.api.nvim_set_keymap("n", "<Leader>gp", "<cmd>SignifyHunkDiff<CR>", {silent = true, noremap = true})
  vim.api.nvim_set_keymap("n", "<Leader>gu", "<cmd>SignifyHunkUndo<CR>", {silent = true, noremap = true})

  vim.api.nvim_set_keymap("n", "<Leader>gk", "<Plug>(signify-prev-hunk)", {silent = true})
  vim.api.nvim_set_keymap("n", "<Leader>gj", "<Plug>(signify-next-hunk)", {silent = true})

  vim.api.nvim_set_keymap("o", "ih", "<Plug>(signify-inner-pending)", {silent = true})
  vim.api.nvim_set_keymap("x", "ih", "<Plug>(signify-inner-visual)",  {silent = true})
  vim.api.nvim_set_keymap("o", "ah", "<Plug>(signify-outer-pending)", {silent = true})
  vim.api.nvim_set_keymap("x", "ah", "<Plug>(signify-outer-visual)",  {silent = true})

  -- committia.vim
  vim.g.committia_min_window_width = 100
  -- lazy load on the specific buffers
  vim.cmd("augroup user_plugin_committia")
  vim.cmd("autocmd!")
  vim.cmd("autocmd BufEnter COMMIT_EDITMSG,MERGE_MSG ++once packadd comittia")
  vim.cmd("augroup END")

  -- git-messenger
  vim.g.git_messenger_no_default_mappings = true
  vim.api.nvim_set_keymap("n", "<Leader>gm", "<Plug>(git-messenger)", {silent = true})
  vim.cmd("packadd git-messenger") -- TODO: make it load on demand
end

return layer
