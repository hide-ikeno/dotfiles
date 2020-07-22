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
    only_sequence = false,
    only_setup = false,
    path = "/Users/ikeno/.local/share/nvim/site/pack/packer/opt/caw.vim"
  },
  ["committia.vim"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/ikeno/.local/share/nvim/site/pack/packer/opt/committia.vim"
  },
  ["completion-treesitter"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/ikeno/.local/share/nvim/site/pack/packer/opt/completion-treesitter"
  },
  ["csv.vim"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/ikeno/.local/share/nvim/site/pack/packer/opt/csv.vim"
  },
  ["d.vim"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/ikeno/.local/share/nvim/site/pack/packer/opt/d.vim"
  },
  ["editorconfig-vim"] = {
    loaded = false,
    only_sequence = true,
    only_setup = true,
    path = "/Users/ikeno/.local/share/nvim/site/pack/packer/opt/editorconfig-vim"
  },
  ["eskk.vim"] = {
    config = { "require'conf.eskk'.config()" },
    keys = { { "i", "<Plug>(eskk:toggle)" }, { "c", "<Plug>(eskk:toggle)" } },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/ikeno/.local/share/nvim/site/pack/packer/opt/eskk.vim"
  },
  ["gina.vim"] = {
    commands = { "Gina" },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/ikeno/.local/share/nvim/site/pack/packer/opt/gina.vim"
  },
  ["git-messenger.vim"] = {
    commands = { "GitMessenger" },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/ikeno/.local/share/nvim/site/pack/packer/opt/git-messenger.vim"
  },
  ["jsonc.vim"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/ikeno/.local/share/nvim/site/pack/packer/opt/jsonc.vim"
  },
  ["nvim-treesitter"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/ikeno/.local/share/nvim/site/pack/packer/opt/nvim-treesitter"
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
  ["python_match.vim"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/ikeno/.local/share/nvim/site/pack/packer/opt/python_match.vim"
  },
  ["requirements.txt.vim"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/ikeno/.local/share/nvim/site/pack/packer/opt/requirements.txt.vim"
  },
  ["startuptime.vim"] = {
    commands = { "StartupTime" },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/ikeno/.local/share/nvim/site/pack/packer/opt/startuptime.vim"
  },
  ["vim-better-whitespace"] = {
    loaded = false,
    only_sequence = true,
    only_setup = true,
    path = "/Users/ikeno/.local/share/nvim/site/pack/packer/opt/vim-better-whitespace"
  },
  ["vim-easy-align"] = {
    keys = { { "n", "<Plug>(EasyAlign)" }, { "v", "<Plug>(EasyAlign)" } },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/ikeno/.local/share/nvim/site/pack/packer/opt/vim-easy-align"
  },
  ["vim-gfm-syntax"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/ikeno/.local/share/nvim/site/pack/packer/opt/vim-gfm-syntax"
  },
  ["vim-gutentags"] = {
    loaded = false,
    only_sequence = true,
    only_setup = true,
    path = "/Users/ikeno/.local/share/nvim/site/pack/packer/opt/vim-gutentags"
  },
  ["vim-indent-guides"] = {
    loaded = false,
    only_sequence = true,
    only_setup = true,
    path = "/Users/ikeno/.local/share/nvim/site/pack/packer/opt/vim-indent-guides"
  },
  ["vim-markdown"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/ikeno/.local/share/nvim/site/pack/packer/opt/vim-markdown"
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
    config = { "require'conf.vim-sandwich'.config()" },
    loaded = false,
    only_sequence = true,
    only_setup = true,
    path = "/Users/ikeno/.local/share/nvim/site/pack/packer/opt/vim-sandwich"
  },
  ["vim-signify"] = {
    loaded = false,
    only_sequence = true,
    only_setup = true,
    path = "/Users/ikeno/.local/share/nvim/site/pack/packer/opt/vim-signify"
  },
  ["vim-tmux-navigator"] = {
    loaded = false,
    only_sequence = true,
    only_setup = true,
    path = "/Users/ikeno/.local/share/nvim/site/pack/packer/opt/vim-tmux-navigator"
  },
  ["vim-vsnip"] = {
    after = { "vim-vsnip-integ" },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/ikeno/.local/share/nvim/site/pack/packer/opt/vim-vsnip"
  },
  ["vim-vsnip-integ"] = {
    load_after = {
      ["vim-vsnip"] = true
    },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/ikeno/.local/share/nvim/site/pack/packer/opt/vim-vsnip-integ"
  },
  ["vim-zsh"] = {
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/ikeno/.local/share/nvim/site/pack/packer/opt/vim-zsh"
  },
  ["vinarise.vim"] = {
    commands = { "Vinarise" },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/ikeno/.local/share/nvim/site/pack/packer/opt/vinarise.vim"
  },
  ["vista.vim"] = {
    commands = { "Vista" },
    loaded = false,
    only_sequence = false,
    only_setup = false,
    path = "/Users/ikeno/.local/share/nvim/site/pack/packer/opt/vista.vim"
  }
}

local function handle_bufread(names)
  for _, name in ipairs(names) do
    local path = plugins[name].path
    for _, dir in ipairs({ 'ftdetect', 'ftplugin', 'after/ftdetect', 'after/ftplugin' }) do
      if #vim.fn.finddir(dir, path) > 0 then
        vim.cmd('doautocmd BufRead')
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
    vim.cmd('silent! delcommand ' .. cmd)
  end

  for key, _ in pairs(del_maps) do
    vim.cmd(fmt('silent! %sunmap %s', key[1], key[2]))
  end

  for _, name in ipairs(names) do
    if not plugins[name].loaded then
      vim.cmd('packadd ' .. name)
      vim._update_package_paths()
      if plugins[name].config then
        for _i, config_line in ipairs(plugins[name].config) do
          loadstring(config_line)()
        end
      end

      if plugins[name].after then
        for _, after_name in ipairs(plugins[name].after) do
          handle_after(after_name, name)
          vim.cmd('redraw')
        end
      end

      plugins[name].loaded = true
    end
  end

  handle_bufread(names)

  if cause.cmd then
    local lines = cause.l1 == cause.l2 and '' or (cause.l1 .. ',' .. cause.l2)
    vim.cmd(fmt('%s%s%s %s', lines, cause.cmd, cause.bang, cause.args))
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
    vim.cmd(fmt('doautocmd <nomodeline> %s', cause.event))
  elseif cause.ft then
    vim.cmd(fmt('doautocmd <nomodeline> %s FileType %s', 'filetypeplugin', cause.ft))
    vim.cmd(fmt('doautocmd <nomodeline> %s FileType %s', 'filetypeindent', cause.ft))
  end
end

-- Pre-load configuration
-- Setup for: vim-tmux-navigator
require'conf.vim-tmux-navigator'.setup()
vim.cmd("packadd vim-tmux-navigator")
-- Setup for: vim-sandwich
require'conf.vim-sandwich'.setup()
vim.cmd("packadd vim-sandwich")
-- Setup for: editorconfig-vim
vim.g.EditorConfig_exclude_patterns = {'scp://.*', 'term://.*'}
vim.cmd("packadd editorconfig-vim")
-- Setup for: vista.vim
require'conf.vista'.setup()
-- Setup for: poet-v
vim.g.poetv_auto_activate = 1
-- Setup for: vim-easy-align
require'conf.vim-easy-align'.setup()
-- Setup for: vinarise.vim
vim.g.vinarise_enable_auto_detect = 1
-- Setup for: git-messenger.vim
require'conf.git-messenger'.setup()
-- Setup for: eskk.vim
require'conf.eskk'.setup()
-- Setup for: vim-gutentags
require'conf.vim-gutentags'.setup()
vim.cmd("packadd vim-gutentags")
-- Setup for: vim-vsnip
require('conf.vim-vsnip').setup()
-- Setup for: caw.vim
require'conf.caw'.setup()
-- Setup for: vim-polyglot
vim.g.polyglot_disable = {'json', 'markdown'}
vim.cmd("packadd vim-polyglot")
-- Setup for: vim-indent-guides
require'conf.vim-indent-guides'.setup()
vim.cmd("packadd vim-indent-guides")
-- Setup for: vim-signify
require'conf.vim-signify'.setup()
vim.cmd("packadd vim-signify")
-- Setup for: vim-better-whitespace
require'conf.vim-better-whitespace'.setup()
vim.cmd("packadd vim-better-whitespace")
-- Setup for: committia.vim
vim.g.committia_min_window_width = 100
-- Post-load configuration
-- Config for: nvim-colorizer.lua
require'colorizer'.setup()
-- Conditional loads
vim._update_package_paths()
END

function! s:load(names, cause) abort
  call luaeval('_packer_load(_A[1], _A[2])', [a:names, a:cause])
endfunction

" Runtimepath customization

" Load plugins in order defined by `after`

" Command lazy-loads
command! -nargs=* -range -bang -complete=file Gina call s:load(['gina.vim'], { "cmd": "Gina", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file Vista call s:load(['vista.vim'], { "cmd": "Vista", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file Vinarise call s:load(['vinarise.vim'], { "cmd": "Vinarise", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file StartupTime call s:load(['startuptime.vim'], { "cmd": "StartupTime", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })
command! -nargs=* -range -bang -complete=file GitMessenger call s:load(['git-messenger.vim'], { "cmd": "GitMessenger", "l1": <line1>, "l2": <line2>, "bang": <q-bang>, "args": <q-args> })

" Keymap lazy-loads
inoremap <silent> <Plug>(eskk:toggle) <cmd>call <SID>load(['eskk.vim'], { "keys": "<Plug>(eskk:toggle)" })<cr>
nnoremap <silent> <Plug>(EasyAlign) <cmd>call <SID>load(['vim-easy-align'], { "keys": "<Plug>(EasyAlign)", "prefix": "" })<cr>
cnoremap <silent> <Plug>(eskk:toggle) <cmd>call <SID>load(['eskk.vim'], { "keys": "<Plug>(eskk:toggle)", "prefix": "" })<cr>
vnoremap <silent> <Plug>(EasyAlign) <cmd>call <SID>load(['vim-easy-align'], { "keys": "<Plug>(EasyAlign)", "prefix": "" })<cr>

augroup packer_load_aucmds
  au!
  " Filetype lazy-loads
  au FileType markdown ++once call s:load(['vim-gfm-syntax', 'vim-markdown'], { "ft": "markdown" })
  au FileType d ++once call s:load(['d.vim'], { "ft": "d" })
  au FileType csv ++once call s:load(['csv.vim'], { "ft": "csv" })
  au FileType jsonc ++once call s:load(['jsonc.vim'], { "ft": "jsonc" })
  au FileType python ++once call s:load(['python_match.vim', 'poet-v', 'SimpylFold'], { "ft": "python" })
  au FileType zsh ++once call s:load(['vim-zsh'], { "ft": "zsh" })
  " Event lazy-loads
  au BufRead requirements.txt ++once call s:load(['requirements.txt.vim'], { "event": "BufRead requirements.txt" })
  au BufRead COMMIT_EDITMSG ++once call s:load(['committia.vim'], { "event": "BufRead COMMIT_EDITMSG" })
  au CursorMoved * ++once call s:load(['caw.vim'], { "event": "CursorMoved *" })
  au InsertCharPre * ++once call s:load(['vim-vsnip'], { "event": "InsertCharPre *" })
  au CursorHold * ++once call s:load(['vim-matchup'], { "event": "CursorHold *" })
augroup END
