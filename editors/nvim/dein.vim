"----------------------------------------------------------------------------
" ~/.config/nvim/rc/dein.vim -- configure dein.vim plugin manager

" Get directory path where dein.vim is located
let s:dein_dir      = $VIM_CACHE_HOME . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" Install dein.vim from github repository if dein_dir does not exist
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . s:dein_repo_dir
endif


" Set variables for controling dein.vim
let g:dein#install_max_processes = 16
let g:dein#install_progress_type = 'title'
let g:dein#enable_notification = 0
let g:dein#install_log_filename = $VIM_CACHE_HOME . '/dein/dein.log'

let s:base = $VIM_CONFIG_HOME . '/dein/'

" Load dein's state from the chache script
"   REMARK: It overwrites 'runtimepath' completely.
if dein#load_state(s:dein_dir)
  let s:toml = [
        \ { 'name': 'plugins.toml', 'lazy': 0 },
        \ { 'name': 'ftplugin.toml', 'lazy': 0 },
        \ { 'name': 'plugins_lazy.toml', 'lazy': 1 },
        \ { 'name': 'defx.toml', 'lazy': 1 },
        \ { 'name': 'denite.toml', 'lazy': 1 },
        \ { 'name': 'deoplete.toml', 'lazy': 1 },
        \ ]
  " Reaches here if the cache script is old, invalid, or not found.
  " Now initialize dein.vim and start plugin configuration block.
  call dein#begin(s:dein_dir, map(deepcopy(s:toml), {_, t -> s:base . t['name']}))
  call map(s:toml, {_, t -> dein#load_toml(s:base . t['name'], {'lazy': t['lazy']})})
  " REMARK: 'runtimepath' is changed after dein#end()
  call dein#end()
  call dein#save_state()
endif


" Install missing plugin(s) automatically
if has('vim_starting') && dein#check_install()
  call dein#install()
endif
