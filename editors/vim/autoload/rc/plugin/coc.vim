" List of coc-extensions to be instalBufEnterled
let s:coc_extension_list = [
      \ 'coc-css',
      \ 'coc-emmet',
      \ 'coc-emoji',
      \ 'coc-eslint',
      \ 'coc-html',
      \ 'coc-json',
      \ 'coc-neosnippet',
      \ 'coc-prettier',
      \ 'coc-pyls',
      \ 'coc-rls',
      \ 'coc-tsserver',
      \ 'coc-vetur',
      \ 'coc-word',
      \ 'coc-yaml'
      \ ]

function! s:coc_install_my_extensions() abort
  " Get list of installed extensions
  let list = map(CocAction('extensionStats'), 'v:val["id"]')
  let missing = filter(s:coc_extension_list, 'index(list, v:val) < 0')
  if !empty(missing)
    call coc#util#install_extension(join(missing))
  endif
endfunction

" Utility funcitons for key mapping
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

function! s:show_documentation()
  if &filetype == 'vim'
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Hook functions called from dein
function! rc#plugin#coc#hook_add() abort
endfunction

function! rc#plugin#coc#hook_source() abort
  " Don't open quickfix window when changed by coc
  let g:coc_auto_open = 0

  " Use <TAB> for trigger completion with characters ahead and navigate.
  inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" :
        \ <SID>check_back_space() ? "\<TAB>" : coc#refresh()
  " Use <S-TAB> for completion back
  inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
  " Use <CR> for confirm completion.
  "   `<C-g>u` means break undo chain at current position.
  "    Coc only does snippet and additional edit on confirm.
  inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
  " Use <c-space> for trigger completion.
  inoremap <silent><expr> <C-Space> coc#refresh()
  " Custom complete
  imap <silent> <C-x><C-u>  <Plug>(coc-complete-custom)

  " Use `[c` and `]c` for navigate diagnostics
  nmap <silent> [c <Plug>(coc-diagnostic-prev)
  nmap <silent> ]c <Plug>(coc-diagnostic-next)

  " Use K for show documentation in preview window
  nnoremap <silent> K :<C-u>call <SID>show_documentation()<CR>
  " Remap keys for gotos
  nmap <silent> gd <Plug>(coc-definition)

  " Key mappings: use <LocalLeader> as a prefix key
  " keys for gotos
  nmap     <silent><LocalLeader>d  <Plug>(coc-definition)
  nmap     <silent><LocalLeader>i  <Plug>(coc-implementation)
  nmap     <silent><LocalLeader>t  <Plug>(coc-type-definition)
  " Jump to references
  nmap     <silent><LocalLeader>r   <Plug>(coc-reference)
  " Rename symbol under the cursor to a new word
  nmap     <silent><LocalLeader>R   <Plug>(coc-rename)
  " Show documentation (help)
  nnoremap <silent><LocalLeader>h   :<C-u>call <SID>show_documentation()<CR>
  " Show diagnostic info
  nnoremap <silent><LocalLeader>I   :<Plug>(coc-diagnostic-info)

  " format selected region
  vmap     <silent><LocalLeader>=  <Plug>(coc-format-selected)
  nmap     <silent><LocalLeader>=  <Plug>(coc-format-selected)
  " Fix autofix problem of current line
  nmap     <silent><LocalLeader>f  <Plug>(coc-fix-current)

  " do codeAction for selected region
  nmap     <silent><LocalLeader>a  <Plug>(coc-codeaction-selected)
  vmap     <silent><LocalLeader>a  <Plug>(coc-codeaction-selected)
  " do codeAction for current line
  nmap     <silent><LocalLeader>ca <Plug>(coc-codeaction)
  " do codeLensAction for current line
  nmap     <silent><LocalLeader>cl <Plug>(coc-codelens-action)

  " --- Shortcuts for denite interface (use [Denite]c as prefix)
  " Show extension list
  nnoremap <silent> [Denite]ce  :<c-u>Denite coc-extension<CR>
  " Show symbols of current buffer
  nnoremap <silent> [Denite]co  :<C-u>Denite coc-symbols<CR>
  " Search symbols of current workspace
  nnoremap <silent> [Denite]cw  :<C-u>Denite coc-workspace<CR>
  " Show diagnostics of current workspace
  nnoremap <silent> [Denite]ca  :<C-u>Denite coc-diagnostic<CR>
  " Show available commands
  nnoremap <silent> [Denite]cc  :<C-u>Denite coc-command<CR>
  " Show available services
  nnoremap <silent> [Denite]cs  :<C-u>Denite coc-service<CR>
  " Show links of cursorent buffer
  nnoremap <silent> [Denite]cl  :<C-u>Denite coc-link<CR>
endfunction

function! rc#plugin#coc#hook_post_source() abort
  " --- Custom commands
  " Use `:Format` for format current buffer
  command! -nargs=0 Format :call CocAction('format')
  " Use `:Fold` for fold current buffer
  command! -nargs=? Fold   :call CocAction('fold', <f-args>)
  " Install extensions not installed yet
  command! -nargs=0 CocInstallMyExtensions :call s:coc_install_my_extensions()

  " --- Autocmd
  augroup MyAutoCmd
    " Highlight symbols under cursor.
    autocmd CursorHold * silent call CocActionAsync('highlight')
    " Trigger signature help
    autocmd CursorHoldI,CursorMovedI call CocActionAsync('showSignatureHelp')
    autocmd User CocJumpPlaceholder  call CocActionAsync('showSignatureHelp')
    " Open quickfix using denite.vim
    autocmd User CocQuickfixChange :Denite -mode=normal quickfix

    autocmd FileType typescript,c,cpp,python,ruby,rust,sh
          \ setlocal formatexpr=CocAction('formatSelected')
  augroup END
endfunction

function! rc#plugin#coc#hook_post_update() abort
  call coc#util#install()
  call coc#util#update()
endfunction

