" ~/.config/nvim/init.vim -- configuration file for NeoVim

if &compatible
  set nocompatible
endif

set encoding=utf-8
scriptencoding utf-8

lua << EOF
  require('init')
  -- vim.api.nvim_command [[ execute 'source' $VIM_CONFIG_HOME . '/dein.vim' ]]
  require('options')
  require('mappings')
  -- vim.api.nvim_command [[ execute 'source' $VIM_CONFIG_HOME . '/ui.vim' ]]
  vim.api.nvim_command [[command! PackagerInstall call packages#PackagerInit() | call packager#install()]]
  vim.api.nvim_command [[command! -bang PackagerUpdate call packages#PackagerInit() | call packager#update({ 'force_hooks': '<bang>'  })]]
  vim.api.nvim_command [[command! PackagerClean call packages#PackagerInit() | call packager#clean()]]
  vim.api.nvim_command [[command! PackagerStatus call packages#PackagerInit() | call packager#status()]]
EOF

" Do not allow run some commands from vimrc or exrc when they are not owned by
" you. You better set 'secure' at the end of .vimrc or init.vim
set secure

