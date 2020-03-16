let g:colors_name = "iceberg"

" --- Transparent background on terminal
" (taken from https://github.com/lambdalisue/dotfiles/blob/master/nvim/init.vim)
function! s:transparent() abort
  highlight Normal ctermbg=NONE guibg=NONE
  highlight NonText ctermbg=NONE guibg=NONE
  highlight EndOfBuffer ctermbg=NONE guibg=NONE
  highlight Folded ctermbg=NONE guibg=NONE
  highlight LineNr ctermbg=NONE guibg=NONE
  highlight CursorLineNr ctermbg=NONE guibg=NONE
  highlight SpecialKey ctermbg=NONE guibg=NONE
  highlight ALEErrorSign ctermbg=NONE guibg=NONE
  highlight ALEWarningSign ctermbg=NONE guibg=NONE
  highlight GitGutterAdd ctermbg=NONE guibg=NONE
  highlight GitGutterChange ctermbg=NONE guibg=NONE
  highlight GitGutterChangeDelete ctermbg=NONE guibg=NONE
  highlight GitGutterDelete ctermbg=NONE guibg=NONE
endfunction

autocmd MyAutoCmd VimEnter *
      \ if !exists('g:GuiLoaded') && !has("gui") && !exists('$SSH_CONNECTION') |
      \   call s:transparent() |
      \ endif


" --- Status line

function! InactiveLine() abort
  return luaeval("require'statusline'.inActiveLine()")
endfunction

function! ActiveLine() abort
  return luaeval("require'statusline'.activeLine()")
endfunction

function! DefxLine() abort
  return luaeval("require'statusline'.defxLine()")
endfunction

autocmd MyAutoCmd FocusGained,VimEnter,WinEnter,BufEnter * setlocal statusline=%!ActiveLine()
autocmd MyAutoCmd FocusLost,WinLeave,BufLeave            * setlocal statusline=%!InactiveLine()
autocmd MyAutoCmd FileType defx                            setlocal statusline=%!DefxLine()
