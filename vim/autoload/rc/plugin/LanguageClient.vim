function! s:languageclient_config() abort
  nnoremap <buffer> <silent> gd    :<C-u>call LanguageClient_textDocument_definition()<CR>
  nnoremap <buffer> <silent> K     :<C-u>call LanguageClient_textDocument_hover()<CR>
  nnoremap <buffer> <silent> <F2>  :<C-u>call LanguageClient_textDocument_rename()<CR>

  " localleader mapping
  nnoremap <buffer> <LocalLeader>d :<C-u>call LanguageClient_textDocument_definition()<CR>
  nnoremap <buffer> <LocalLeader>h :<C-u>call LanguageClient_textDocument_hover()<CR>
  nnoremap <buffer> <LocalLeader>R :<C-u>call LanguageClient_textDocument_rename()<CR>
  " LanguageClient also provides Denite sources
  nnoremap <buffer> <LocalLeader>s  :<C-u>Denite -auto-preview -mode=normal documentSymbol<CR>
  nnoremap <buffer> <LocalLeader>S  :<C-u>Denite -auto-preview workspaceSymbol<CR>
  nnoremap <buffer> <LocalLeader>r  :<C-u>Denite -auto-preview -mode=normal references<CR>

  " setlocal formatexpr=LanguageClient_textDocument_rangeFormatting()
  setlocal cmdheight=3
endfunction

function! rc#plugin#LanguageClient#hook_source() abort
  set hidden
  let g:LanguageClient_autoStart = 1

  " --- Language servers
  " let g:LanguageClient_serverCommands = {
  "       \ 'c':      ['clangd'],
  "       \ 'cpp':    ['clangd'],
  "       \ 'python': [$PYENV_ROOT . '/versions/neovim3/bin/pyls', '--log-file=/tmp/pyls.log'],
  "       \ 'rust':   ['rustup', 'run', 'stable', 'rls'],
  "       \ 'sh':     ['bash-language-server'],
  "       \ }
  " let cquery_exec_path = $HOME . '/src/github.com/cquery-project/cquery/build/cxx-release/bin/cquery'
  let g:LanguageClient_serverCommands = {
        \ 'c':      ['cquery', '--log-file=/tmp/cquery/cquery.log'],
        \ 'cpp':    ['cquery', '--log-file=/tmp/cquery/cquery.log'],
        \ 'python': [$PYENV_ROOT . '/versions/neovim3/bin/pyls', '--log-file=/tmp/pyls.log'],
        \ 'rust':   ['rustup', 'run', 'stable', 'rls'],
        \ 'sh':     ['bash-language-server'],
        \ }

  let g:LanguageClient_loadSettings = 1
  let g:LanguageClient_settingsPath = g:vimrc_root . '/settings.json'
  " let g:LanguageClient_trace = 'verbose'

  autocmd MyVimrc FileType c,cpp,python,rust,sh call s:languageclient_config()
endfunction
