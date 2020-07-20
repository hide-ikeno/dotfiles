" Automatically generated packer.nvim plugin loader code

lua << END
local plugins = {
  SimpylFold = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/ikeno/.local/share/nvim/site/pack/packer/opt/SimpylFold"
  },
  ["caw.vim"] = {
    loaded = false,
    only_sequence = true,
    only_setup = true,
    path = "/Users/ikeno/.local/share/nvim/site/pack/packer/opt/caw.vim"
  },
  ["committia.vim"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/ikeno/.local/share/nvim/site/pack/packer/opt/committia.vim"
  },
  ["editorconfig-vim"] = {
    loaded = false,
    only_sequence = true,
    only_setup = true,
    path = "/Users/ikeno/.local/share/nvim/site/pack/packer/opt/editorconfig-vim"
  },
  ["git-messenger.vim"] = {
    commands = { "GitMessenger" },
    config = { "\27LJ\1\2\v\0\0\1\0\0\0\1G\0\1\0\0" },
    keys = { { "n", "<Plug>(git-messenger)" } },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/ikeno/.local/share/nvim/site/pack/packer/opt/git-messenger.vim"
  },
  indentLine = {
    loaded = false,
    only_sequence = true,
    only_setup = true,
    path = "/Users/ikeno/.local/share/nvim/site/pack/packer/opt/indentLine"
  },
  ["packer.nvim"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/ikeno/.local/share/nvim/site/pack/packer/opt/packer.nvim"
  },
  ["poet-v"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/ikeno/.local/share/nvim/site/pack/packer/opt/poet-v"
  },
  ["vim-better-whitespace"] = {
    loaded = false,
    only_sequence = true,
    only_setup = true,
    path = "/Users/ikeno/.local/share/nvim/site/pack/packer/opt/vim-better-whitespace"
  },
  ["vim-gfm-syntax"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/ikeno/.local/share/nvim/site/pack/packer/opt/vim-gfm-syntax"
  },
  ["vim-matchup"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/ikeno/.local/share/nvim/site/pack/packer/opt/vim-matchup"
  },
  ["vim-polyglot"] = {
    loaded = false,
    only_sequence = true,
    only_setup = true,
    path = "/Users/ikeno/.local/share/nvim/site/pack/packer/opt/vim-polyglot"
  },
  ["vim-sandwich"] = {
    config = { "\27LJ\1\2Ú\3\0\0\2\0\6\0\0174\0\0\0007\0\1\0%\1\2\0>\0\2\0014\0\0\0007\0\1\0%\1\3\0>\0\2\0014\0\0\0007\0\1\0%\1\4\0>\0\2\0014\0\0\0007\0\1\0%\1\5\0>\0\2\1G\0\1\0b    let g:sandwich#recipes += [{'buns': ['\\%(', '\\)'], 'filetype': ['vim'], 'nesting': 1}]\n  b    let g:sandwich#recipes += [{'buns': ['\\(',  '\\)'], 'filetype': ['vim'], 'nesting': 1}]\n  Ž\1    let g:sandwich#recipes += [{'buns': ['ã€Œ', 'ã€']}, {'buns': ['ã€', 'ã€‘']}, {'buns': ['ï¼ˆ', 'ï¼‰']}, {'buns': ['ã€Ž', 'ã€']}]\n  D let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes) \bcmd\bvim\0" },
    loaded = false,
    only_sequence = true,
    only_setup = true,
    path = "/Users/ikeno/.local/share/nvim/site/pack/packer/opt/vim-sandwich"
  },
  ["vim-signify"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/ikeno/.local/share/nvim/site/pack/packer/opt/vim-signify"
  },
  ["vim-tmux-navigator"] = {
    loaded = false,
    only_sequence = true,
    only_setup = true,
    path = "/Users/ikeno/.local/share/nvim/site/pack/packer/opt/vim-tmux-navigator"
  },
  ["vinarise.vim"] = {
    commands = { "Vinarise" },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/ikeno/.local/share/nvim/site/pack/packer/opt/vinarise.vim"
  }
}

local function handle_bufread(names)
  for _, name in ipairs(names) do
    local path = plugins[name].path
    for _, dir in ipairs({ 'ftdetect', 'ftplugin', 'after/ftdetect', 'after/ftplugin' }) do
      if #vim.fn.finddir(dir, path) > 0 then
        vim.api.nvim_command('doautocmd BufRead')
        return
      end
    end
  end
end

_packer_load = nil

local function handle_after(name, before)
  local plugin = plugins[name]
  plugin.load_after[before] = nil
  if next(plugin.load_after) == nil then
    _packer_load({name}, {})
  end
end

_packer_load = function(names, cause)
  local some_unloaded = false
  for _, name in ipairs(names) do
    if not plugins[name].loaded then
      some_unloaded = true
      break
    end
  end

  if not some_unloaded then return end

  local fmt = string.format
  local del_cmds = {}
  local del_maps = {}
  for _, name in ipairs(names) do
    if plugins[name].commands then
      for _, cmd in ipairs(plugins[name].commands) do
        del_cmds[cmd] = true
      end
    end

    if plugins[name].keys then
      for _, key in ipairs(plugins[name].keys) do
        del_maps[key] = true
      end
    end
  end

  for cmd, _ in pairs(del_cmds) do
    vim.api.nvim_command('silent! delcommand ' .. cmd)
  end

  for key, _ in pairs(del_maps) do
    vim.api.nvim_command(fmt('silent! %sunmap %s', key[1], key[2]))
  end

  for _, name in ipairs(names) do
    if not plugins[name].loaded then
      vim.api.nvim_command('packadd ' .. name)
      if plugins[name].config then
        for _i, config_line in ipairs(plugins[name].config) do
          loadstring(config_line)()
        end
      end

      if plugins[name].after then
        for _, after_name in ipairs(plugins[name].after) do
          handle_after(after_name, name)
          vim.api.nvim_command('redraw')
        end
      end

      plugins[name].loaded = true
    end
  end

  handle_bufread(names)

  if cause.cmd then
    local lines = cause.l1 == cause.l2 and '' or (cause.l1 .. ',' .. cause.l2)
    vim.api.nvim_command(fmt('%s%s%s %s', lines, cause.cmd, cause.bang, cause.args))
  elseif cause.keys then
    local keys = cause.keys
    local extra = ''
    while true do
      local c = vim.fn.getchar(0)
      if c == 0 then break end
      extra = extra .. vim.fn.nr2char(c)
    end

    if cause.prefix then
      local prefix = vim.v.count and vim.v.count or ''
      prefix = prefix .. '"' .. vim.v.register .. cause.prefix
      if vim.fn.mode('full') == 'no' then
        if vim.v.operator == 'c' then
          prefix = '' .. prefix
        end

        prefix = prefix .. vim.v.operator
      end

      vim.fn.feedkeys(prefix, 'n')
    end

    -- NOTE: I'm not sure if the below substitution is correct; it might correspond to the literal
    -- characters \<Plug> rather than the special <Plug> key.
    vim.fn.feedkeys(string.gsub(cause.keys, '^<Plug>', '\\<Plug>') .. extra)
  elseif cause.event then
    vim.api.nvim_command(fmt('doautocmd <nomodeline> %s', cause.event))
  elseif cause.ft then
    vim.api.nvim_command(fmt('doautocmd <nomodeline> %s FileType %s', 'filetypeplugin', cause.ft))
    vim.api.nvim_command(fmt('doautocmd <nomodeline> %s FileType %s', 'filetypeindent', cause.ft))
  end
end

-- Pre-load configuration
-- Setup for: vim-tmux-navigator
loadstring("\27LJ\1\2ë\3\0\0\6\0\16\0F4\0\0\0007\0\1\0'\1\1\0:\1\2\0003\0\3\0004\1\0\0007\1\4\0017\1\5\1%\2\6\0%\3\a\0%\4\b\0\16\5\0\0>\1\5\0014\1\0\0007\1\4\0017\1\5\1%\2\6\0%\3\t\0%\4\n\0\16\5\0\0>\1\5\0014\1\0\0007\1\4\0017\1\5\1%\2\6\0%\3\v\0%\4\f\0\16\5\0\0>\1\5\0014\1\0\0007\1\4\0017\1\5\1%\2\6\0%\3\r\0%\4\14\0\16\5\0\0>\1\5\0014\1\0\0007\1\4\0017\1\5\1%\2\15\0%\3\a\0%\4\b\0\16\5\0\0>\1\5\0014\1\0\0007\1\4\0017\1\5\1%\2\15\0%\3\t\0%\4\n\0\16\5\0\0>\1\5\0014\1\0\0007\1\4\0017\1\5\1%\2\15\0%\3\v\0%\4\f\0\16\5\0\0>\1\5\0014\1\0\0007\1\4\0017\1\5\1%\2\15\0%\3\r\0%\4\14\0\16\5\0\0>\1\5\1G\0\1\0\6t\31<cmd>TmuxNavigateRight<CR>\n<M-l>\28<cmd>TmuxNavigateUp<CR>\n<M-k>\30<cmd>TmuxNavigateDown<CR>\n<M-j>\30<cmd>TmuxNavigateLeft<CR>\n<M-h>\6n\20nvim_set_keymap\bapi\1\0\2\vsilent\2\fnoremap\2\31tmux_navigator_no_mappings\6g\bvim\0")()
vim.api.nvim_command("packadd vim-tmux-navigator")
-- Setup for: vim-sandwich
loadstring("\27LJ\1\2á\v\0\0\6\0\31\0š\0014\0\0\0007\0\1\0'\1d\0:\1\2\0004\0\0\0007\0\1\0'\1\1\0:\1\3\0004\0\0\0007\0\1\0'\1\1\0:\1\4\0004\0\0\0007\0\1\0'\1\1\0:\1\5\0003\0\6\0004\1\0\0007\1\a\0017\1\b\1%\2\t\0%\3\n\0%\4\v\0\16\5\0\0>\1\5\0014\1\0\0007\1\a\0017\1\b\1%\2\t\0%\3\f\0%\4\r\0\16\5\0\0>\1\5\0014\1\0\0007\1\a\0017\1\b\1%\2\t\0%\3\n\0%\4\14\0\16\5\0\0>\1\5\0014\1\0\0007\1\a\0017\1\b\1%\2\t\0%\3\f\0%\4\15\0\16\5\0\0>\1\5\0014\1\0\0007\1\a\0017\1\b\1%\2\t\0%\3\16\0%\4\17\0002\5\0\0>\1\5\0014\1\0\0007\1\a\0017\1\b\1%\2\18\0%\3\16\0%\4\17\0002\5\0\0>\1\5\0014\1\0\0007\1\a\0017\1\b\1%\2\19\0%\3\16\0%\4\20\0002\5\0\0>\1\5\0014\1\0\0007\1\a\0017\1\b\1%\2\18\0%\3\n\0%\4\21\0002\5\0\0>\1\5\0014\1\0\0007\1\a\0017\1\b\1%\2\18\0%\3\f\0%\4\22\0002\5\0\0>\1\5\0014\1\0\0007\1\a\0017\1\b\1%\2\19\0%\3\23\0%\4\24\0002\5\0\0>\1\5\0014\1\0\0007\1\a\0017\1\b\1%\2\19\0%\3\25\0%\4\26\0002\5\0\0>\1\5\0014\1\0\0007\1\a\0017\1\b\1%\2\18\0%\3\23\0%\4\24\0002\5\0\0>\1\5\0014\1\0\0007\1\a\0017\1\b\1%\2\18\0%\3\25\0%\4\26\0002\5\0\0>\1\5\0014\1\0\0007\1\a\0017\1\b\1%\2\19\0%\3\27\0%\4\28\0002\5\0\0>\1\5\0014\1\0\0007\1\a\0017\1\b\1%\2\19\0%\3\29\0%\4\30\0002\5\0\0>\1\5\0014\1\0\0007\1\a\0017\1\b\1%\2\18\0%\3\27\0%\4\28\0002\5\0\0>\1\5\0014\1\0\0007\1\a\0017\1\b\1%\2\18\0%\3\29\0%\4\30\0002\5\0\0>\1\5\1G\0\1\0%<Plug>(textobj-sandwich-query-i)\ais%<Plug>(textobj-sandwich-query-a)\aas$<Plug>(textobj-sandwich-auto-i)\aib$<Plug>(textobj-sandwich-auto-a)\aab&<Plug>(operator-sandwich-replace)%<Plug>(operator-sandwich-delete)!<Plug>(operator-sandwich-g@)\6o\6x\"<Plug>(operator-sandwich-add)\asal<Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)k<Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)m<Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)\asrl<Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)\asd\6n\20nvim_set_keymap\bapi\1\0\1\vsilent\2-textobj_sandwich_no_default_key_mappings.operator_sandwich_no_default_key_mappings%sandwich_no_default_key_mappings!textobj#sandwich#stimeoutlen\6g\bvim\0")()
vim.api.nvim_command("packadd vim-sandwich")
-- Setup for: editorconfig-vim
vim.g.EditorConfig_exclude_patterns = {'scp://.*', 'term://.*'}
vim.api.nvim_command("packadd editorconfig-vim")
-- Setup for: indentLine
loadstring("\27LJ\1\2Ö\1\0\0\2\0\b\0\0174\0\0\0007\0\1\0'\1\1\0:\1\2\0004\0\0\0007\0\1\0%\1\4\0:\1\3\0004\0\0\0007\0\1\0'\1\0\0:\1\5\0004\0\0\0007\0\1\0003\1\a\0:\1\6\0G\0\1\0\1\6\0\0\thelp\vdenite\18denite-filter\nvista\15vista_kind\31indentLine_fileTypeExclude\26indentLine_setConceal\aÂ¦\20indentLine_char\22indentLine_enable\6g\bvim\0")()
vim.api.nvim_command("packadd indentLine")
-- Setup for: caw.vim
loadstring("\27LJ\1\2æ\5\0\0\5\0\29\0U4\0\0\0007\0\1\0'\1\1\0:\1\2\0004\0\0\0007\0\3\0007\0\4\0%\1\5\0%\2\6\0%\3\a\0003\4\b\0>\0\5\0014\0\0\0007\0\3\0007\0\4\0%\1\t\0%\2\6\0%\3\a\0003\4\n\0>\0\5\0014\0\0\0007\0\3\0007\0\4\0%\1\5\0%\2\v\0%\3\f\0003\4\r\0>\0\5\0014\0\0\0007\0\3\0007\0\4\0%\1\t\0%\2\v\0%\3\f\0003\4\14\0>\0\5\0014\0\0\0007\0\3\0007\0\4\0%\1\5\0%\2\15\0%\3\16\0003\4\17\0>\0\5\0014\0\0\0007\0\3\0007\0\4\0%\1\t\0%\2\15\0%\3\16\0003\4\18\0>\0\5\0014\0\0\0007\0\3\0007\0\4\0%\1\5\0%\2\19\0%\3\20\0003\4\21\0>\0\5\0014\0\0\0007\0\3\0007\0\4\0%\1\t\0%\2\19\0%\3\20\0003\4\22\0>\0\5\0014\0\0\0007\0\3\0007\0\4\0%\1\5\0%\2\23\0%\3\24\0003\4\25\0>\0\5\0014\0\0\0007\0\3\0007\0\4\0%\1\5\0%\2\26\0%\3\27\0003\4\28\0>\0\5\1G\0\1\0\1\0\1\vsilent\2\"<Plug>(caw:jump:comment-prev)\15<Leader>c[\1\0\1\vsilent\2\"<Plug>(caw:jump:comment-next)\15<Leader>c]\1\0\1\vsilent\2\1\0\1\vsilent\2\28<Plug>(caw:wrap:toggle)\15<Leader>cw\1\0\1\vsilent\2\1\0\1\vsilent\2\27<Plug>(caw:box:toggle)\15<Leader>cb\1\0\1\vsilent\2\1\0\1\vsilent\2!<Plug>(caw:dollarpos:toggle)\15<Leader>ca\1\0\1\vsilent\2\6x\1\0\1\vsilent\2\30<Plug>(caw:hatpos:toggle)\15<Leader>cc\6n\20nvim_set_keymap\bapi\31caw_no_default_keymappings\6g\bvim\0")()
vim.api.nvim_command("packadd caw.vim")
-- Setup for: vim-polyglot
vim.g.polyglot_disable = {'json', 'markdown'}
vim.api.nvim_command("packadd vim-polyglot")
-- Setup for: vim-signify
loadstring('\27LJ\1\2õ\5\0\0\5\0\31\0I4\0\0\0007\0\1\0007\0\2\0%\1\3\0%\2\4\0%\3\5\0003\4\6\0>\0\5\0014\0\0\0007\0\1\0007\0\2\0%\1\3\0%\2\a\0%\3\b\0003\4\t\0>\0\5\0014\0\0\0007\0\1\0007\0\2\0%\1\3\0%\2\n\0%\3\v\0003\4\f\0>\0\5\0014\0\0\0007\0\1\0007\0\2\0%\1\3\0%\2\r\0%\3\14\0003\4\15\0>\0\5\0014\0\0\0007\0\1\0007\0\2\0%\1\3\0%\2\16\0%\3\17\0003\4\18\0>\0\5\0014\0\0\0007\0\1\0007\0\2\0%\1\19\0%\2\20\0%\3\21\0003\4\22\0>\0\5\0014\0\0\0007\0\1\0007\0\2\0%\1\23\0%\2\20\0%\3\24\0003\4\25\0>\0\5\0014\0\0\0007\0\1\0007\0\2\0%\1\19\0%\2\26\0%\3\27\0003\4\28\0>\0\5\0014\0\0\0007\0\1\0007\0\2\0%\1\23\0%\2\26\0%\3\29\0003\4\30\0>\0\5\1G\0\1\0\1\0\1\vsilent\2!<Plug>(signify-outer-visual)\1\0\1\vsilent\2"<Plug>(signify-outer-pending)\aah\1\0\1\vsilent\2!<Plug>(signify-inner-visual)\6x\1\0\1\vsilent\2"<Plug>(signify-inner-pending)\aih\6o\1\0\1\vsilent\2\30<Plug>(signify-next-hunk)\15\\<Space>g]\1\0\1\vsilent\2\30<Plug>(signify-prev-hunk)\15\\<Space>g[\1\0\2\fnoremap\2\vsilent\2\29<cmd>SignifyHunkUndo<CR>\15\\<Space>gu\1\0\2\fnoremap\2\vsilent\2\29<cmd>SignifyHunkDiff<CR>\15\\<Space>gp\1\0\2\fnoremap\2\vsilent\2\25<cmd>SignifyDiff<CR>\15\\<Space>gd\6n\20nvim_set_keymap\bapi\bvim\0')()
-- Setup for: vinarise.vim
vim.g.vinarise_enable_auto_detect = 1
-- Setup for: git-messenger.vim
loadstring("\27LJ\1\2\1\0\0\5\0\t\0\r4\0\0\0007\0\1\0)\1\2\0:\1\2\0004\0\0\0007\0\3\0007\0\4\0%\1\5\0%\2\6\0%\3\a\0003\4\b\0>\0\5\1G\0\1\0\1\0\1\vsilent\2\26<Plug>(git-messenger)\agm\6n\20nvim_set_keymap\bapi&git_messenger_no_default_mappings\6g\bvim\0")()
-- Setup for: vim-better-whitespace
loadstring("\27LJ\1\2ï\2\0\0\5\0\r\0\0254\0\0\0007\0\1\0'\1\1\0:\1\2\0004\0\0\0007\0\1\0'\1\1\0:\1\3\0004\0\0\0007\0\1\0'\1\1\0:\1\4\0004\0\0\0007\0\1\0003\1\6\0:\1\5\0004\0\0\0007\0\a\0007\0\b\0%\1\t\0%\2\n\0%\3\v\0003\4\f\0>\0\5\1G\0\1\0\1\0\2\vsilent\2\fnoremap\2\29<cmd>StripWhitespace<CR>\14<Leader>x\6n\20nvim_set_keymap\bapi\1\t\0\0\tdiff\14gitcommit\tdefx\vdenite\aqf\thelp\rmarkdown\14which_key*better_whitespace_filetypes_blacklist\"show_spaces_that_precede_tabs\29strip_whitespace_on_save\30better_whitespace_enabled\6g\bvim\0")()
vim.api.nvim_command("packadd vim-better-whitespace")
-- Setup for: committia.vim
vim.g.committia_min_window_width = 100
-- Setup for: poet-v
vim.g.poetv_auto_activate = 1
-- Post-load configuration
-- Config for: nvim-colorizer.lua
loadstring("\27LJ\1\0027\0\0\2\0\3\0\0064\0\0\0%\1\1\0>\0\2\0027\0\2\0>\0\1\1G\0\1\0\nsetup\14colorizer\frequire\0")
-- Conditional loads
END

function! s:load(names, cause) abort
  call luaeval('_packer_load(_A[1], _A[2])', [a:names, a:cause])
endfunction

" Load plugins in order defined by `after`

" Command lazy-loads
command! -nargs=* -range -bang -complete=file GitMessenger call s:load(['git-messenger.vim'], { "cmd": "GitMessenger", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file Vinarise call s:load(['vinarise.vim'], { "cmd": "Vinarise", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })

" Keymap lazy-loads
nnoremap <silent> <Plug>(git-messenger) <cmd>call <SID>load(['git-messenger.vim'], { "keys": "<Plug>(git-messenger)", "prefix": "" })<cr>

augroup packer_load_aucmds
  au!
  " Filetype lazy-loads
  au FileType markdown ++once call s:load(['vim-gfm-syntax'], { "ft": "markdown" })
  au FileType python ++once call s:load(['poet-v', 'SimpylFold'], { "ft": "python" })
  " Event lazy-loads
  au VimEnter * ++once call s:load(['vim-matchup'], { "event": "VimEnter *" })
  au BufRead COMMIT_EDITMSG ++once call s:load(['committia.vim'], { "event": "BufRead COMMIT_EDITMSG" })
  au BufEnter * ++once call s:load(['vim-signify'], { "event": "BufEnter *" })
augroup END

" Runtimepath customization
