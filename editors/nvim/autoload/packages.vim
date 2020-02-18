" plugins managed by vim-packeger

function! s:ensure_packager(dir) abort
  if !isdirectory(a:dir)
    echo "Install vim-packager ..."
    execute "!git clone --depth 1 https://github.com/kristijanhusak/vim-packager " . a:dir
  endif
endfunction

function! packages#PackagerInit(...) abort
  let l:packager_dir_default = $VIM_CACHE_HOME . '/pack/packager/opt/vim-packager'
  let l:packager_dir = get(a:, 1, l:packager_dir_default)

  call s:ensure_packager(l:packager_dir)

  packadd vim-packager

  call packager#init()
  " -- default plugins
  call packager#add('thinca/vim-localrc')
  call packager#add('editorconfig/editorconfig-vim')
  call packager#add('itchyny/vim-gitbranch')
  call packager#add('itchyny/vim-parenmatch')
  call packager#add('Yggdroot/indentLine')
  call packager#add('ntpeters/vim-better-whitespace')
  call packager#add('christoomey/vim-tmux-navigator')
  call packager#add('Shougo/context_filetype.vim')
  call packager#add('kana/vim-operator-user')
  call packager#add('kana/vim-textobj-user')
  call packager#add('tpope/vim-repeat')
  call packager#add('Shougo/neosnippet-snippets')
  call packager#add('Shougo/deoplete-lsp')
  call packager#add('tbodt/deoplete-tabnine')
  call packager#add('zchee/deoplete-zsh')
  call packager#add('kristijanhusak/defx-git')
  call packager#add('chemzqm/unite-location')
  call packager#add('itchyny/lightline.vim')
  call packager#add('arcticicestudio/nord-vim')
  call packager#add('sheerun/vim-polyglot')
  call packager#add('vim-jp/vimdoc-ja')
  call packager#add('JesseKPhillips/d.vim')
  call packager#add('vim-scripts/python_match.vim')
  call packager#add('neoclide/jsonc.vim')
  call packager#add('chrisbra/vim-zsh')
  call packager#add('Shirk/vim-gas')
endfunction
