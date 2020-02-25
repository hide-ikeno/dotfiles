" ~/.config/nvim/init.vim -- configuration file for NeoVim

if &compatible
  set nocompatible
endif

set encoding=utf-8
scriptencoding utf-8

lua << EOF
  require("init")
  require("options")
  require("mappings")
  vim.api.nvim_command [[ execute 'source' $VIM_CONFIG_HOME . '/dein.vim' ]]
  vim.o.background = "dark"
  vim.api.nvim_command [[colorscheme iceberg]]
  require("statusline")
EOF

" Do not allow run some commands from vimrc or exrc when they are not owned by
" you. You better set 'secure' at the end of .vimrc or init.vim
set secure

