" ~/.config/nvim/init.vim -- configuration file for NeoVim

if &compatible
  set nocompatible
endif

set encoding=utf-8
scriptencoding utf-8

lua << EOF
  require('init')
  require('options')
  require('mappings')
  require('filetype')
  -- Load plugin configurations
  local plugin_config_dir = vim.env.VIM_CONFIG_HOME .. "/lua/plugins"
  local list = vim.split(vim.fn.globpath(plugin_config_dir, "*.lua"), "\n")
  for _, f in ipairs(list) do
    local name = f:gsub("(.*[/\\])(.*)", "%2"):match("(.+)%..+")
    require('plugins.' .. name).setup()
  end
  -- vim.api.nvim_command [[ execute 'source' $VIM_CONFIG_HOME . '/ui.vim' ]]
EOF

" Do not allow run some commands from vimrc or exrc when they are not owned by
" you. You better set 'secure' at the end of .vimrc or init.vim
set secure

