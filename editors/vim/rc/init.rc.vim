"----------------------------------------------------------------------------
" Environments
"----------------------------------------------------------------------------
if has('vim_starting')
  " Set encoding in vim
  set encoding=utf-8
  scriptencoding utf-8
endif

" XDG Base Directory Specification
if empty($XDG_CONFIG_HOME)
  let $XDG_CONFIG_HOME = expand('~/.config')
endif

if empty($XDG_CACHE_HOME)
  let $XDG_CACHE_HOME = expand('~/.cache')
endif

if empty($XDG_DATA_HOME)
  let $XDG_DATA_HOME = expand('~/.local/share')
endif

" --- Query OS type
let s:is_windows = has('win32') || has('win64')

function! IsWindows() abort
  return s:is_windows
endfunction

function! IsMac() abort
  return !s:is_windows && !has('win32unix')
        \ && (has('mac') || has('macunix') || has('gui_macvim')
        \     || (!executable('xdg-open') && system('uname') =~? '^darwin'))
endfunction

" --- Set executable path and manpath.
" These variables might not be set properly in GVim/MacVim
function! s:configure_path(name, pathlist) abort
  let l:path_separator = s:is_windows ? ';' : ':'
  let l:pathlist = split(expand(a:name), l:path_separator)
  for l:path in map(filter(a:pathlist, '!empty(v:val)'), 'expand(v:val)')
    if isdirectory(l:path) && index(l:pathlist, l:path) == -1
      call insert(l:pathlist, l:path, 0)
    endif
  endfor
  execute printf('let %s = join(pathlist, ''%s'')', a:name, l:path_separator)
endfunction

call s:configure_path('$PATH', [
      \ '~/.local/bin',
      \ '~/.cargo/bin',
      \ '~/.ndenv/bin',
      \ '~/.rbenv/bin',
      \ '~/.pyenv/bin',
      \ '~/.ndenv/shims/bin',
      \ '~/.rbenv/shims/bin',
      \ '~/.pyenv/shims/bin',
      \ '~/.anyenv/envs/ndenv/bin',
      \ '~/.anyenv/envs/rbenv/bin',
      \ '~/.anyenv/envs/pyenv/bin',
      \ '~/.anyenv/envs/ndenv/shims',
      \ '~/.anyenv/envs/rbenv/shims',
      \ '~/.anyenv/envs/pyenv/shims',
      \ '~/.zplug/bin',
      \ '~/bin',
      \ '/Library/Tex/texbin',
      \ '/usr/local/bin',
      \ '/usr/bin',
      \ '/bin',
      \ '/usr/local/sbin',
      \ '/usr/sbin',
      \ '/sbin',
      \])
call s:configure_path('$MANPATH', [
      \ '/usr/local/share/man/',
      \ '/usr/share/man/',
      \ '/opt/intel/man/',
      \ '/Applications/Xcode.app/Contents/Developer/usr/share/man',
      \ '/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/share/man',
      \])

"
" Set python2/python3 interpretor (required to setup plugins using neovim
" python API)
"
" Create virtualenvs for and only for neovim (+ development tools) and set
" python3_host_prog and python_host_prog to point the corresponding python
" interpreters.
"
if has('nvim')
  let g:python3_host_prog = $PYENV_ROOT . '/versions/neovim3/bin/python'
  let g:python_host_prog  = $PYENV_ROOT . '/versions/neovim2/bin/python'
endif

" --- Enable Vim to use system clipboard
" -> Disabled because of the problem of lectangular yank
" if has('clipboard')
"   set clipboard&   " <- set to default
"   " - unnamed     : 'selection' in X11; clipboard in Mac OS X and Windows
"   " - unnamedplus : 'clipboard' in X11, Mac OS X, and Windows (but yank)
"   if has('win32') || has('win64') || has('mac')
"     set clipboard^=unnamed
"   else
"     set clipboard^=unnamed,unnamedplus
"   endif
" endif

"----------------------------------------------------------------------------
" Options
"----------------------------------------------------------------------------

if has('multi_byte_ime')
  set iminsert=0 imsearch=0
endif

" Disable packpath
set packpath=

"----------------------------------------------------------------------------
" Prefix keys
"----------------------------------------------------------------------------

" Use 'space' as <Leader> key and ';' as <LocalLeader> key
let g:mapleader = "\<Space>"
let g:maplocalleader = ';'

" Release some keymappings for plugins
nnoremap <Space>  <Nop>
xnoremap <Space>  <Nop>

nnoremap ;  <Nop>
xnoremap ;  <Nop>

nnoremap ,  <Nop>
xnoremap ,  <Nop>

nmap s  <Nop>
xmap s  <Nop>

nnoremap m  <Nop>
xnoremap m  <Nop>

"----------------------------------------------------------------------------
" Disable default plugins
"----------------------------------------------------------------------------
let g:loaded_2html_plugin      = 1
let g:loaded_getscript         = 1
let g:loaded_getscriptPlugin   = 1
let g:loaded_gzip              = 1
let g:loaded_matchit           = 1
let g:loaded_matchparen        = 1
let g:loaded_netrw             = 1
let g:loaded_netrwPlugin       = 1
let g:loaded_netrwSettings     = 1
let g:loaded_netrwFileHandlers = 1
let g:loaded_rrhelper          = 1
let g:loaded_spellfile_plugin  = 1
let g:loaded_tar               = 1
let g:loaded_tarPlugin         = 1
let g:loaded_vimball           = 1
let g:loaded_vimballPlugin     = 1
let g:loaded_zip               = 1
let g:loaded_zipPlugin         = 1
