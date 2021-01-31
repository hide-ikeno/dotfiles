-- Colorschem Sonokai
vim.cmd[[packadd sonokai]]
vim.o.background = "dark"
vim.g.sonokai_style = "shusia"
vim.g.sonokai_enable_italic = 1
vim.g.sonokai_enable_bold   = 1
if vim.fn.exists("g:GuiLoaded") == 0 and vim.fn.has("gui") == 0 and vim.fn.exists("$SSH_CONNECTION") then
  -- Transparent background on terminal
  vim.g.sonokai_transparent_background = 1
end

_G.statusline_active = require('appearance.statusline').statusline_active
_G.statusline_inactive = require('appearance.statusline').statusline_inactive

vim.cmd("augroup user_appearance_events")
vim.cmd("autocmd!")
vim.cmd("autocmd VimEnter * ++nested colorscheme sonokai")
vim.cmd("autocmd VimEnter,ColorScheme * lua require('appearance.statusline').apply_theme('sonokai_shusia')")
local events = {
  "VimEnter", "WinEnter", "BufEnter", "BufWritePost",
  "FileChangedShellPost","VimResized","TermOpen"
}
vim.cmd("autocmd ".. table.concat(events, ",") .. " * setlocal statusline=%!v:lua.statusline_active()")
vim.cmd("autocmd WinLeave,BufLeave * setlocal statusline=%!v:lua.statusline_inactive()")
vim.cmd("augroup END")
