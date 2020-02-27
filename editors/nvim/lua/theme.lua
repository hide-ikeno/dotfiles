require("colors/iceberg")
require("statusline")

vim.api.nvim_command("autocmd MyAutoCmd FocusGained,VimEnter,WinEnter,BufEnter * setlocal statusline=%!v:lua.StatuslineActive()")
vim.api.nvim_command("autocmd MyAutoCmd FocusLost,WinLeave,BufLeave            * setlocal statusline=%!v:lua.StatuslineInactive()")
vim.api.nvim_command("autocmd MyAutoCmd FileType defx                            setlocal statusline=%!v:lua.StatuslineDefx()")


if vim.fn.has("gui_running") then
  -- transparent background
  vim.api.nvim_command("highlight Normal                 ctermbg=NONE guibg=NONE")
  vim.api.nvim_command("highlight LineNr                 ctermbg=NONE guibg=NONE")
  vim.api.nvim_command("highlight SignColumn             ctermbg=NONE guibg=NONE")
  vim.api.nvim_command("highlight Normal                 ctermbg=NONE guibg=NONE")
  vim.api.nvim_command("highlight NonText                ctermbg=NONE guibg=NONE")
  vim.api.nvim_command("highlight EndOfBuffer            ctermbg=NONE guibg=NONE")
  vim.api.nvim_command("highlight Folded                 ctermbg=NONE guibg=NONE")
  vim.api.nvim_command("highlight LineNr                 ctermbg=NONE guibg=NONE")
  vim.api.nvim_command("highlight CursorLineNr           ctermbg=NONE guibg=NONE")
  vim.api.nvim_command("highlight SpecialKey             ctermbg=NONE guibg=NONE")
  vim.api.nvim_command("highlight ALEErrorSign           ctermbg=NONE guibg=NONE")
  vim.api.nvim_command("highlight ALEWarningSign         ctermbg=NONE guibg=NONE")
  vim.api.nvim_command("highlight GitGutterAdd           ctermbg=NONE guibg=NONE")
  vim.api.nvim_command("highlight GitGutterChange        ctermbg=NONE guibg=NONE")
  vim.api.nvim_command("highlight GitGutterChangeDelete  ctermbg=NONE guibg=NONE")
  vim.api.nvim_command("highlight GitGutterDelete        ctermbg=NONE guibg=NONE")
end

