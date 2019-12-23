" colorscheme.vim --- setup colorscheme on vim/nvim and costomize lightline

" --- Colorscheme
set background=dark
"
" let g:one_allow_italics = 1
" colorscheme one
" call one#highlight('Visual', '', '3e4452', 'none')

" let g:nord_italic = 1
" let g:nord_underline = 1
" let g:nord_cursor_line_number_background = 1
" colorscheme nord

colorscheme nord

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

" --- Customize status line with lightline
let g:lightline = {
      \ 'colorscheme': 'nord',
      \ 'active': {
      \   'left': [
      \     ['mode', 'paste'],
      \     ['gitbranch', 'readonly', 'filename', 'modified'],
      \   ],
      \   'right': [
      \      ['lineinfo'],
      \      ['percent'],
      \      ['fileformat', 'fileencoding', 'filetype'],
      \      ['pyenv']
      \   ],
      \ },
      \ 'inactive': {
      \   'left':  [ ['filepath', 'filename_inactive'] ],
      \   'right': [ ['lineinfo'], ['filetype'], ['fileinfo'] ]
      \ },
      \ 'component' : {
      \   'lineinfo': "\ue0a1 %3l:%-2v"
      \ },
      \ 'component_function': {
      \   'modified':     'LightlineModified',
      \   'readonly':     'LightlineReadonly',
      \   'gitbranch':    'LightlineGitBranch',
      \   'filename':     'LightlineFilename',
      \   'fileformat':   'LightlineFileformat',
      \   'filetype':     'LightlineFiletype',
      \   'fileencoding': 'LightlineFileencoding',
      \   'mode':         'LightlineMode',
      \ },
      \ 'separator':    { 'left': "\ue0b0", 'right': "\ue0b2" },
      \ 'subseparator': { 'left': "\ue0b1", 'right': "\ue0b3" }
      \ }

function! LightlineModified()
  if &filetype =~? 'help\|defx\|gundo'
    return ''
  elseif &modified
    return '+'
  elseif &modifiable
    return ''
  else
    return '-'
  endif
endfunction

function! LightlineReadonly()
  if &filetype !~? 'help\|defx\|gundo'
    return ''
  elseif &readonly
    return "\ue0a2"
  else
    return ''
  endif
endfunction

function! LightlineFilename()
  let fname = expand('%:t')
  return &filetype ==? 'denite' ? denite#get_status('sources') . denite#get_status('path') : '' .
        \ ('' !=? LightlineReadonly() ? LightlineReadonly() . ' ' : '') .
        \ ('' !=? fname ? fname : '[No Name]') .
        \ ('' !=? LightlineModified() ? ' ' . LightlineModified() : '')
endfunction

function! LightlineFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

function! LightlineFiletype()
  return winwidth(0) > 70 ? (&filetype !=? '' ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! LightlineFileencoding()
  return winwidth(0) > 70 ? (&fileencoding !=? '' ? &fileencoding : &encoding) : ''
endfunction

function! LightlineMode()
  return  &filetype ==? 'denite' ? 'denite' :
        \ &filetype ==? 'defx' ? 'defx' :
        \ &filetype ==? 'vimshell' ? 'VimShell' :
        \ winwidth(0) > 60 ? lightline#mode() : ''
endfunction

function! LightlineGitBranch()
  " let branch = gitbranch#name()
  let branch = gina#component#repo#branch()
  return branch ==# '' ? '' : " \ue725 " . branch
endfunction

" https://github.com/Lokaltog/vim-powerline/blob/develop/autoload/Powerline/Functions.vim
function! LightlineCharCode()
  if winwidth('.') <= 70
    return ''
  endif

  " Get the output of :ascii
  redir => ascii
  silent! ascii
  redir END

  if match(ascii, 'NUL') != -1
    return 'NUL'
  endif

  " Zero pad hex values
  let nrformat = '0x%02x'

  let encoding = (&fenc == '' ? &enc : &fenc)

  if encoding == 'utf-8'
    " Zero pad with 4 zeroes in unicode files
    let nrformat = '0x%04x'
  endif

  " Get the character and the numeric value from the return value of :ascii
  " This matches the two first pieces of the return value, e.g.
  " "<F>  70" => char: 'F', nr: '70'
  let [str, char, nr; rest] = matchlist(ascii, '\v\<(.{-1,})\>\s*([0-9]+)')

  " Format the numeric value
  let nr = printf(nrformat, nr)

  return "'". char ."' ". nr
endfunction

"----------------------------------------------------------------------------
" vim: expandtab softtabstop=2 shiftwidth=2 foldmethod=marker
