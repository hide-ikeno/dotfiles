" colorscheme.vim --- setup colorscheme on vim/nvim and costomize lightline
"
" " --- Colorscheme
" set background=dark
" "
" " let g:one_allow_italics = 1
" " colorscheme one
" " call one#highlight('Visual', '', '3e4452', 'none')
"
" " let g:nord_italic = 1
" " let g:nord_underline = 1
" " let g:nord_cursor_line_number_background = 1
" " colorscheme nord
"
" colorscheme nord

function! s:transparent() abort
  highlight Normal                 ctermbg=NONE guibg=NONE
  highlight LineNr                 ctermbg=NONE guibg=NONE
  highlight SignColumn             ctermbg=NONE guibg=NONE
  highlight Normal                 ctermbg=NONE guibg=NONE
  highlight NonText                ctermbg=NONE guibg=NONE
  highlight EndOfBuffer            ctermbg=NONE guibg=NONE
  highlight Folded                 ctermbg=NONE guibg=NONE
  highlight LineNr                 ctermbg=NONE guibg=NONE
  highlight CursorLineNr           ctermbg=NONE guibg=NONE
  highlight SpecialKey             ctermbg=NONE guibg=NONE
  highlight ALEErrorSign           ctermbg=NONE guibg=NONE
  highlight ALEWarningSign         ctermbg=NONE guibg=NONE
  highlight GitGutterAdd           ctermbg=NONE guibg=NONE
  highlight GitGutterChange        ctermbg=NONE guibg=NONE
  highlight GitGutterChangeDelete  ctermbg=NONE guibg=NONE
  highlight GitGutterDelete        ctermbg=NONE guibg=NONE
endfunction

autocmd MyAutoCmd VimEnter *
     \ if !has("gui_running") |
     \   call s:transparent() |
     \ endif

" Change statusline automatically
autocmd MyAutoCmd FocusGained,VimEnter,WinEnter,BufEnter * lua SetStatusLineActive()
autocmd MyAutoCmd FocusLost,WinLeave,BufLeave            * lua SetStatusLineInactive()

