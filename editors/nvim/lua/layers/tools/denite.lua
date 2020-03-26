local plug = require("core.plug")

local layer = {}

function layer.register_plugins()
  -- Dark powered asynchronous unite all interfaces for Neovim/Vim8
  plug.add_plugin("Shougo/denite.nvim", { type = "opt" })
  -- External denite.nvim mathcer
  plug.add_plugin("raghur/fruzzy", { type = "opt", ["do"] = "call fruzzy#install()" })
  -- register/yank for denite
  plug.add_plugin("Shougo/neoyank.vim", { type = "opt" })
  -- Denite source for Most recently used files (MRU)
  plug.add_plugin("Shougo/neomru.vim", { type = "opt" })
  -- Denite sources for quickfix, location_list
  plug.add_plugin("chemzqm/unite-location", { type = "opt" })
end

function layer.init_config()
  --- Key mappings
  local function apply_mapping(mode, lhs, rhs)
    vim.api.nvim_set_keymap(mode, lhs, rhs,
      {noremap = true, silent = true})
  end

  -- Replace default search mappings
  vim.api.nvim_set_keymap("n", "/",
    [[line('$') > 10000 ? '/' : ":\<C-u>Denite -buffer-name=search -start-filter line\<CR>"]],
    {noremap = true, silent = true, expr = true})

  vim.api.nvim_set_keymap("n", "n",
    [[line('$') > 10000 ? 'n' : ":\<C-u>Denite -buffer-name=search -resume -refresh -no-start-filter\<CR>"]],
    {noremap = true, silent = true, expr = true})

  vim.api.nvim_set_keymap("n", "*",
    [[line('$') > 10000 ? '/' : ":\<C-u>DeniteCursorWord -buffer-name=search -start-filter line\<CR>"]],
    {noremap = true, silent = true, expr = true})

  vim.api.nvim_set_keymap("x", "*",
    [["qy:Denite -input=`@q` -buffer-name=search -search line<CR>]],
    {noremap = true, silent = true})

  -- <Space> mappings
  apply_mapping("n", "<Space>b", [[<cmd>Denite buffer file_mru -default-action=switch<CR>]])
  apply_mapping("n", "<Space>f", [[<cmd>Denite file/point file/old -sorters=sorter/rank file/rec file file:new<CR>]])
  apply_mapping("n", "<Space>h", [[<cmd>Denite help<CR>]])
  apply_mapping("n", "<Space>l", [[<cmd>Denite localtion_list<CR>]])
  apply_mapping("n", "<Space>q", [[<cmd>Denite quickfix<CR>]])
  apply_mapping("n", "<Space>r", [[<cmd>Denite -resume -refresh -no-start-filter<CR>]])

  apply_mapping("n", "<Space>/", [[<cmd>Denite -buffer-name=search -no-empty grep<CR>]])
  apply_mapping("n", "<Space>*", [[<cmd>DeniteCursorWord -buffer-name=search -no-empty grep<CR>]])

  vim.api.nvim_set_keymap("n", "<Space>]",
    [[&filetype == 'help' ?  "g\<C-]>" : ":\<C-u>DeniteCursorWord -buffer-name=tag -immediately tag:include\<CR>"]],
    {noremap = true, silent = true, expr = true})
  vim.api.nvim_set_keymap("n", "<Space>[",
    [[&filetype == 'help' ? ":\<C-u>pop\<CR>" : ":\<C-u>Denite jump\<CR>"]],
    {noremap = true, silent = true, expr = true})

  -- <Leader> mappings
  apply_mapping("n", "<Leader>r", [[<cmd>Denite -buffer-name=register register yank<CR>]])
  apply_mapping("x", "<Leader>r", [[<cmd>Denite -default-action=replace -buffer-name=register register yank<CR>]])
  apply_mapping("n", "<Leader><Leader>", [[<cmd>Denite command command_history<CR>]])

  -- Auto commands
  local on_cmd = {'Denite', 'DeniteBufferDir', 'DeniteCursorWord', 'DeniteProjectDir'}
  vim.api.nvim_command("augroup user-plugin-denite")
  vim.api.nvim_command("autocmd!")
  -- lazy load
  vim.api.nvim_command("autocmd CmdUndefined " .. table.concat(on_cmd, ",") ..
    " ++once lua require('layer.tools.denite')._denite_load()")
  -- buffer local settings
  vim.api.nvim_command("autocmd FileType denite        lua require('layer.tools.denite')._on_filetype_denite()")
  vim.api.nvim_command("autocmd FileType denite_filter lua require('layer.tools.denite')._on_filetype_denite_filter()")
  vim.api.nvim_command("augroup END")

  -- fruzzy
  vim.g["fruzzy#usenative"]   = 1
  vim.g["fruzzy#sortonempty"] = 0
end

function layer._denite_load()
  -- Load packages
  vim.api.nvim_command("packadd denite")
  vim.api.nvim_command("packadd fruzzy")
  vim.api.nvim_command("packadd neoyank")
  vim.api.nvim_command("packadd neomru")
  vim.api.nvim_command("packadd unite-location")

  -- Configure denite
  local ignore_globs = {
    ".git", ".ropeproject", "__pycache__", "venv",
    "node_modules", "images", "*.min.*", "img", "fonts"
  }

  -- command for find file
  if vim.fn.executable("rg") then
    local cmd = {"rg", "--follow", "--hidden", "--files"}
    for _, x in ipairs(ignore_globs) do
      table.insert(cmd, "--glob=!" .. x)
    end
    vim.fn["denite#custom#var"]("file/rec", "command", cmd)
  elseif vim.fn.executable("ag") then
    local cmd = {"ag", "-U", "--hidden", "--follow"}
    for _, x in ipairs(ignore_globs) do
      table.insert(cmd, "--exclude=" .. x)
    end
    for _, x in ipairs({"--nocolor", "--nogroup", "-g", ""}) do
      table.insert(cmd, x)
    end
    vim.fn["denite#custom#var"]("file/rec", "command", cmd)
  end

  -- command for grep
  if vim.fn.executable("rg") then
    vim.fn["denite#custom#var"]("grep", "command", {"rg", "--threads", "1"})
    vim.fn["denite#custom#var"]("grep", "recursive_opts", {})
    vim.fn["denite#custom#var"]("grep", "final_opts", {})
    vim.fn["denite#custom#var"]("grep", "separator", {"--"})
    vim.fn["denite#custom#var"]("grep", "default_opts", {"-i", "--vimgrep", "--no-heading"})
  elseif vim.fn.executable("ag") then
    vim.fn["denite#custom#var"]("grep", "command", {"ag"})
    vim.fn["denite#custom#var"]("grep", "recursive_opts", {})
    vim.fn["denite#custom#var"]("grep", "pattern_opt", {})
    vim.fn["denite#custom#var"]("grep", "separator", {"--"})
    vim.fn["denite#custom#var"]("grep", "final_opts", {})
    vim.fn["denite#custom#var"]("grep", "default_opts", {
      "--skip-vcs-ignores", "--vimgrep", "--smart-case", "--hidden"
    })
  elseif vim.fn.executable("ack") then
    vim.fn["denite#custom#var"]("grep", "command", {"ack"})
    vim.fn["denite#custom#var"]("grep", "recursive_opts", {})
    vim.fn["denite#custom#var"]("grep", "pattern_opt", {"--match"})
    vim.fn["denite#custom#var"]("grep", "separator", {"--"})
    vim.fn["denite#custom#var"]("grep", "final_opts", {})
    vim.fn["denite#custom#var"]("grep", "default_opts", {
      "--ackrc", vim.env.HOME .. "/.config/ackrc", "-H", "--nopager",
      "--nocolor", "--nogroup", "--column"
    })
  end

  -- Matchers
  vim.fn["denite#custom#source"]("file/old", "matchers",
    {"matcher/fruzzy", "matcher/project_files"})
  vim.fn["denite#custom#source"]("file_mru", "matchers", {"matcher/fruzzy"})
  vim.fn["denite#custom#source"]("file/rec", "matchers", {"matcher/fruzzy"})
  vim.fn["denite#custom#source"]("tag", "matchers", {"matcher/substring"})

  -- Converters
  vim.fn["denite#custom#source"]("file/old,ghq", "converters",
    {"converter/devicons", "converter/relative_word", "converter/relative_abbr"})
  vim.fn["denite#custom#source"]("file,file/rec,file_mru,buffer,directory/rec,directory_mru",
    "converters", {"converter/devicons"} )

  -- Aliases
  vim.fn["denite#custom#alias"]("source", "file/rec/git", "file/rec")
  vim.fn["denite#custom#var"]("file/rec/git", "command",
    {"git", "ls-files", "-co", "--exclude-standard"})

  -- Filters
  vim.fn["denite#custom#filter"]("matcher/ignore_globs", "ignore_globs", ignore_globs)

  -- Options
  -- vim.fn["denite#custom#option"]("_", {
  --       \ "wincol":    s:denite_wincol,
  --       \ "winheight": s:denite_winheight,
  --       \ "winrow":    s:denite_winrow,
  --       \ "winwidth":  s:denite_winwidth,
  --       \ })

  vim.fn["denite#custom#option"]("default", {
      highlight_filter_background = "CursorLine",
      prompt                      = "> ",
      source_names                = "short",
      split                       = "floating",
      filter_split_direction      = "floating",
      vertical_preview            = true,
      floating_preview            = true,
    })

  vim.fn["denite#custom#option"]("search", {
      highlight_filter_background = "CursorLine",
      source_names                = "short",
      split                       = "floating",
      filter_split_direction      = "floating",
      vertical_preview            = true,
      floating_preview            = true,
    })
end

function layer._on_filetype_denite()
  vim.wo.winblend   = 20
  vim.wo.signcolumn = "no"
  vim.wo.cursorline = false

  local function apply_mapping(bufnr, lhs, rhs)
    vim.api.nvim_buf_set_keymap(bufnr, "n", lhs, rhs, {noremap = true, silent = true, expr = true})
  end
  local opts = {noremap = true, silent = true, expr = true}
  local opts_nowait = {noremap = true, silent = true, expr = true, nowait = true}

  local buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_keymap(buf, "n", "<CR>",  "denite#do_map('do_action')",            opts)
  vim.api.nvim_buf_set_keymap(buf, "n", "a",     "denite#do_map('open_filter_buffer')",   opts)
  vim.api.nvim_buf_set_keymap(buf, "n", "i",     "denite#do_map('open_filter_buffer')",   opts)
  vim.api.nvim_buf_set_keymap(buf, "n", "/",     "denite#do_map('open_filter_buffer')",   opts)
  vim.api.nvim_buf_set_keymap(buf, "n", "'",     "denite#do_map('quick_move')",           opts)
  vim.api.nvim_buf_set_keymap(buf, "n", "p",     "denite#do_map('do_action', 'preview')", opts)
  vim.api.nvim_buf_set_keymap(buf, "n", "q",     "denite#do_map('quit')",                 opts)
  vim.api.nvim_buf_set_keymap(buf, "n", "r",     "denite#do_map('redraw')",               opts)
  vim.api.nvim_buf_set_keymap(buf, "n", "dd",    "denite#do_map('do_action', 'delete')",  opts)
  vim.api.nvim_buf_set_keymap(buf, "n", "yy",    "denite#do_map('do_action', 'yank')",    opts)
  vim.api.nvim_buf_set_keymap(buf, "n", "<Esc>", "denite#do_map('quit')",                 opts)
  vim.api.nvim_buf_set_keymap(buf, "n", "<Tab>", "denite#do_map('choose_action')",        opts)
  vim.api.nvim_buf_set_keymap(buf, "n", "<C-n>", "j", opts)
  vim.api.nvim_buf_set_keymap(buf, "n", "<C-p>", "k", opts)
  vim.api.nvim_buf_set_keymap(buf, "n", "<Space>", "denite#do_map('toggle_select').'j'", opts_nowait)
end

function layer._on_filetype_denite_filter()
  vim.wo.winblend       = 20
  vim.wo.signcolumn     = "yes"
  vim.wo.cursorline     = false
  vim.wo.number         = false
  vim.wo.relativenumber = false

  local buf = vim.api.nvim_get_current_buf()
  local opts = {silent = true}
  vim.api.nvim_buf_set_keymap(buf, "n", "<C-g>", "<Plug>(denite_filter_quit)", opts)
  vim.api.nvim_buf_set_keymap(buf, "i", "<C-g>", "<Plug>(denite_filter_quit)", opts)
  vim.api.nvim_buf_set_keymap(buf, "n", "<C-c>", "<Plug>(denite_filter_quit)", opts)
  vim.api.nvim_buf_set_keymap(buf, "i", "<C-c>", "<Plug>(denite_filter_quit)", opts)
end

return layer
