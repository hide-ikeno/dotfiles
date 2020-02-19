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

  " -- Make vim-packager to be updated by itself
  call packager#add('kristijanhusak/vim-packager', {'type': 'opt'})

  " === Basic Plugins ===
  call packager#add('thinca/vim-localrc')
  call packager#add('editorconfig/editorconfig-vim')
  call packager#add('itchyny/vim-parenmatch')
  call packager#add('vim-jp/vimdoc-ja')
  call packager#add('Shougo/context_filetype.vim')

  " === Interfaces ===
  call packager#add('itchyny/vim-gitbranch')
  call packager#add('Yggdroot/indentLine')
  call packager#add('ntpeters/vim-better-whitespace')
  call packager#add('christoomey/vim-tmux-navigator')
  call packager#add('norcalli/nvim-colorizer.lua', {'type': 'opt'})

  " --- Themes
  call packager#add('itchyny/lightline.vim')
  call packager#add('cocopon/iceberg.vim')
  call packager#add('arcticicestudio/nord-vim')
  call packager#add('ryanoasis/vim-devicons', {'type': 'opt'})

  " === Editting ===
  call packager#add('tpope/vim-repeat')
  call packager#add('thinca/vim-qfreplace', {'type': 'opt'})
  call packager#add('t9md/vim-choosewin', {'type': 'opt'})
  call packager#add('junegunn/vim-easy-align', {'type': 'opt'})
  call packager#add('AndrewRadev/splitjoin.vim', {'type': 'opt'})
  call packager#add('tyru/eskk.vim', {'type': 'opt'})
  call packager#add('tyru/caw.vim', {'type': 'opt'})
  call packager#add('kana/vim-niceblock', {'type': 'opt'})
  call packager#add('easymotion/vim-easymotion', {'type': 'opt'})
  call packager#add('haya14busa/vim-edgemotion', {'type': 'opt'})
  call packager#add('rhysd/accelerated-jk', {'type': 'opt'})
  call packager#add('osyo-manga/vim-jplus', {'type': 'opt'})
  call packager#add('Konfekt/FastFold', {'type': 'opt'})
  call packager#add('osyo-manga/vim-precious', {'type': 'opt'})
  call packager#add('kkoomen/vim-doge', {'type': 'opt'})
  " -- textobj, operators
  call packager#add('kana/vim-operator-user')
  call packager#add('kana/vim-textobj-user')
  call packager#add('machakann/vim-sandwich', {'type': 'opt'})
  call packager#add('kana/vim-operator-replace', {'type': 'opt'})
  call packager#add('kana/vim-textobj-entire', {'type': 'opt'})
  call packager#add('kana/vim-textobj-line', {'type': 'opt'})
  call packager#add('thinca/vim-textobj-comment', {'type': 'opt'})
  call packager#add('mattn/vim-textobj-url', {'type': 'opt'})
  call packager#add('machakann/vim-textobj-delimited', {'type': 'opt'})
  call packager#add('terryma/vim-expand-region', {'type': 'opt'})

  " -- Auto completion engine and completion sources
  call packager#add('Shougo/deoplete.nvim',  {'type': 'opt'})
  call packager#add('Shougo/neoinclude.vim', {'type': 'opt'})
  call packager#add('Shougo/neco-syntax',    {'type': 'opt'})
  call packager#add('Shougo/neco-vim',       {'type': 'opt'})
  call packager#add('Shougo/neosnippet.vim', {'type': 'opt'})
  call packager#add('Shougo/neosnippet-snippets')
  call packager#add('Shougo/deoplete-lsp')
  call packager#add('tbodt/deoplete-tabnine', {'do': './install.sh'})
  call packager#add('zchee/deoplete-zsh')

  " -- LSP, Tags
  call packager#add('neovim/nvim-lsp',         {'type': 'opt'})
  call packager#add('hrsh7th/vim-vsnip',       {'type': 'opt'})
  call packager#add('hrsh7th/vim-vsnip-integ', {'type': 'opt'})
  call packager#add('liuchengxu/vista.vim',    {'type': 'opt'})
  if executable('ctags')
    call packager#add('ludovicchabant/vim-gutentags ', {'type': 'opt'})
  endif

  " -- Filer, Tree
  call packager#add('Shougo/defx.nvim',          {'type': 'opt'})
  call packager#add('kristijanhusak/defx-icons', {'type': 'opt'})
  call packager#add('kristijanhusak/defx-git')

  " -- Fuzzy finder
  call packager#add('Shougo/denite.nvim', {'type': 'opt'})
  call packager#add('raghur/fruzzy', {'type': 'opt', 'do': function('{-> call fruzzy#install()}')})
  call packager#add('Shougo/neoyank.vim', {'type': 'opt'})
  call packager#add('Shougo/neomru.vim',  {'type': 'opt'})
  call packager#add('Shougo/deol.nvim',   {'type': 'opt'})
  call packager#add('ncm2/float-preview.nvim', {'type': 'opt'})
  call packager#add('chemzqm/unite-location')

  " -- VCS (git)
  call packager#add('lambdalisue/gina.vim',    {'type': 'opt'})
  call packager#add('airblade/vim-gitgutter',  {'type': 'opt'})
  call packager#add('rhysd/committia.vim',     {'type': 'opt'})
  call packager#add('rhysd/git-messenger.vim', {'type': 'opt'})

  " -- Languages (syntax, filetypes)
  call packager#add('bfredl/nvim-luadev')
  call packager#add('sheerun/vim-polyglot')
  call packager#add('JesseKPhillips/d.vim')
  call packager#add('vim-scripts/python_match.vim')
  call packager#add('neoclide/jsonc.vim')
  call packager#add('chrisbra/vim-zsh')
  call packager#add('Shirk/vim-gas')
  call packager#add('lervag/vimtex',                 {'type': 'opt'})
  call packager#add('lambdalisue/vim-pyenv',         {'type': 'opt'})
  call packager#add('tmhedberg/SimpylFold',          {'type': 'opt'})
  call packager#add('raimon49/requirements.txt.vim', {'type': 'opt'})
  call packager#add('rcmdnk/vim-markdown',           {'type': 'opt'})
  call packager#add('rhysd/vim-gfm-syntax',          {'type': 'opt'})
  call packager#add('iamcco/markdown-preview.vim',   {'type': 'opt'})
  call packager#add('Shougo/vinarise.vim',           {'type': 'opt'})
endfunction

