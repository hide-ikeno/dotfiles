
vim.cmd[[
function! ActiveLine() abort
  return luaeval("require('style.statusline').statusline_active()")
endfunction
]]

vim.cmd[[
function! InActiveLine() abort
  return luaeval("require('style.statusline').statusline_inactive()")
endfunction
]]

-- Colorschem Edge Aura (dark)
vim.o.background         = "dark"
vim.g.edge_style         = "aura"
vim.g.edge_enable_italic = 1
vim.g.edge_enable_bold   = 1
if vim.fn.exists("g:GuiLoaded") == 0 and vim.fn.has("gui") == 0 and vim.fn.exists("$SSH_CONNECTION") then
  -- Transparent background on terminal
  vim.g.edge_transparent_background = 1
end

vim.cmd("augroup user_style_events")
vim.cmd("autocmd!")
-- vim.cmd("autocmd VimEnter * ++nested colorscheme edge")
vim.cmd("autocmd VimEnter,ColorScheme * lua require('style.statusline').apply_theme()")
vim.cmd("autocmd FocusGained,VimEnter,WinEnter,BufEnter * setlocal statusline=%!ActiveLine()")
vim.cmd("autocmd FocusLost,WinLeave,BufLeave            * setlocal statusline=%!InActiveLine()")
vim.cmd("augroup END")

