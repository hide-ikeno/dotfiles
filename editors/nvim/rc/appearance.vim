" let g:colors_name = "iceberg"
" silent! colorscheme iceberg

" " --- Transparent background on terminal
" " (taken from https://github.com/lambdalisue/dotfiles/blob/master/nvim/init.vim)
" function! s:transparent() abort
"   highlight Normal ctermbg=NONE guibg=NONE
"   highlight NonText ctermbg=NONE guibg=NONE
"   highlight EndOfBuffer ctermbg=NONE guibg=NONE
"   highlight Folded ctermbg=NONE guibg=NONE
"   highlight LineNr ctermbg=NONE guibg=NONE
"   highlight CursorLineNr ctermbg=NONE guibg=NONE
"   highlight SpecialKey ctermbg=NONE guibg=NONE
"   highlight ALEErrorSign ctermbg=NONE guibg=NONE
"   highlight ALEWarningSign ctermbg=NONE guibg=NONE
"   highlight GitGutterAdd ctermbg=NONE guibg=NONE
"   highlight GitGutterChange ctermbg=NONE guibg=NONE
"   highlight GitGutterChangeDelete ctermbg=NONE guibg=NONE
"   highlight GitGutterDelete ctermbg=NONE guibg=NONE
" endfunction

function! s:set_colorscheme() abort
  " -- Forest Night
  " let g:forest_night_enable_italic = 1
  " let g:forest_night_enable_bold = 1
  " let g:forest_night_transparent_background = 1
  " colorscheme forest-night

  " -- Edge
  set background=dark
  let g:edge_style = 'aura'
  let g:edge_enable_italic = 1
  let g:edge_enable_bold = 1
  if !exists('g:GuiLoaded') && !has("gui") && !exists('$SSH_CONNECTION')
    " Transparent background on terminal
    let g:edge_transparent_background = 1
  endif
  colorscheme edge
endfunction

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

" --- Events
augroup user_ui_events
  autocmd!
  " autocmd VimEnter * ++nested colorscheme iceberg
  autocmd VimEnter * ++nested call s:set_colorscheme()
  " autocmd VimEnter *
  "      \ if !exists('g:GuiLoaded') && !has("gui") && !exists('$SSH_CONNECTION') |
  "      \   call s:transparent() |
  "      \ endif
  autocmd FocusGained,VimEnter,WinEnter,BufEnter * setlocal statusline=%!ActiveLine()
  autocmd FocusLost,WinLeave,BufLeave            * setlocal statusline=%!InactiveLine()
  autocmd FileType defx                            setlocal statusline=%!DefxLine()
augroup END
