local M = {}

function M.hook_add()
  vim.api.nvim_set_keymap("n", "<Leader>=", ":set opfunc=codefmt#FormatMap<CR>g@", {silent = true; unique = true;})
  vim.api.nvim_set_keymap("n", "<Leader>==", ":FormatLines<CR>",          {silent = true; unique = true;})
  vim.api.nvim_set_keymap("x", "<Leader>=",  ":<C-u>FormatLines<CR>",     {silent = true; unique = true;})
  vim.api.nvim_set_keymap("n", "<Leader>=b", "<cmd>FormatCode<CR>",       {silent = true; unique = true;})

  vim.cmd("augroup autoformat_settings")
  vim.cmd("autocmd!")
  vim.cmd("autocmd FileType bzl AutoFormatBuffer buildifier")
  vim.cmd("autocmd FileType c,cpp,proto,javascript,arduino AutoFormatBuffer clang-format")
  vim.cmd("autocmd FileType dart AutoFormatBuffer dartfmt")
  vim.cmd("autocmd FileType go AutoFormatBuffer gofmt")
  vim.cmd("autocmd FileType gn AutoFormatBuffer gn")
  vim.cmd("autocmd FileType html,css,sass,scss,less,json AutoFormatBuffer js-beautify")
  vim.cmd("autocmd FileType java AutoFormatBuffer google-java-format")
  vim.cmd("autocmd FileType python AutoFormatBuffer black")
  vim.cmd("autocmd FileType rust AutoFormatBuffer rustfmt")
  vim.cmd("autocmd FileType sh AutoFormatBuffer shfmt")
  vim.cmd("autocmd FileType vue AutoFormatBuffer prettier")
  vim.cmd("augroup END")
end

return M
