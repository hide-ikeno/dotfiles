" ~/.config/nvim/init.vim -- configuration file for NeoVim

lua << EOF
  require("init")
  -- require("options")
  -- require("mappings")
  -- vim.api.nvim_command [[ execute 'source' $VIM_CONFIG_HOME . '/dein.vim' ]]
  -- require("theme")
EOF

execute 'source' fnameescape(expand ('$VIM_CONFIG_HOME/rc/appearance.vim'))

" Do not allow run some commands from vimrc or exrc when they are not owned by
" you. You better set 'secure' at the end of .vimrc or init.vim
setglobal secure

