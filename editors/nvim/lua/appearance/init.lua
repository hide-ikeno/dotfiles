-- -- Colorschem Forest Night
-- vim.cmd[[packadd forest-night]]
-- vim.o.background = "dark"
-- vim.g.forest_night_enable_italic = 1
-- vim.g.forest_night_enable_bold   = 1
-- if vim.fn.exists("g:GuiLoaded") == 0 and vim.fn.has("gui") == 0 and vim.fn.exists("$SSH_CONNECTION") then
--   -- Transparent background on terminal
--   vim.g.forest_night_transparent_background = 1
-- end

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
vim.cmd("augroup user_appearance_events")
vim.cmd("autocmd!")
vim.cmd("autocmd VimEnter * ++nested colorscheme sonokai")
vim.cmd("augroup END")

-- Status line

-- _G.statusline_active = require("appearance.statusline").statusline_active
-- _G.statusline_inactive = require("appearance.statusline").statusline_inactive

-- vim.cmd("augroup user_appearance_events")
-- vim.cmd("autocmd!")
-- vim.cmd("autocmd VimEnter * ++nested colorscheme sonokai")
-- vim.cmd("autocmd VimEnter,ColorScheme * lua require('appearance.statusline').apply_theme('forest-night')")
-- vim.cmd("autocmd FocusGained,VimEnter,WinEnter,BufEnter * setlocal statusline=%!v:lua.statusline_active()")
-- vim.cmd("autocmd FocusLost,WinLeave,BufLeave            * setlocal statusline=%!v:lua.statusline_inactive()")
-- vim.cmd("augroup END")
