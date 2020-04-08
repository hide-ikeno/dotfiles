local vim = vim or {}

local M = {}

function M.hook_add()
  local options      = {silent = true, noremap = true}
  local options_expr = {silent = true, noremap = true, expr = true}

  -- Replace default search mappings
  vim.api.nvim_set_keymap("n", "/",
    [[line('$') > 10000 ? '/' : ":\<C-u>Denite -buffer-name=search -start-filter line\<CR>"]],
    options_expr)

  vim.api.nvim_set_keymap("n", "n",
    [[line('$') > 10000 ? 'n' : ":\<C-u>Denite -buffer-name=search -resume -refresh -no-start-filter\<CR>"]],
    options_expr)

  vim.api.nvim_set_keymap("n", "*",
    [[line('$') > 10000 ? '/' : ":\<C-u>DeniteCursorWord -buffer-name=search -start-filter line\<CR>"]],
    options_expr)

  vim.api.nvim_set_keymap("x", "*",
    [["qy:Denite -input=`@q` -buffer-name=search -search line<CR>]], options)

  -- <Space> mappings
  vim.api.nvim_set_keymap("n", "<Space>b",
    [[<cmd>Denite buffer file_mru -default-action=switch<CR>]], options)
  vim.api.nvim_set_keymap("n", "<Space>f",
    [[<cmd>Denite file/point file/old -sorters=sorter/rank file/rec file file:new<CR>]],
    options)
  vim.api.nvim_set_keymap("n", "<Space>h", [[<cmd>Denite help<CR>]], options)
  vim.api.nvim_set_keymap("n", "<Space>l", [[<cmd>Denite location_list<CR>]], options)
  vim.api.nvim_set_keymap("n", "<Space>q", [[<cmd>Denite quickfix<CR>]], options)
  vim.api.nvim_set_keymap("n", "<Space>r",
    [[<cmd>Denite -resume -refresh -no-start-filter<CR>]], options)

  vim.api.nvim_set_keymap("n", "<Space>/",
    [[<cmd>Denite -buffer-name=search -no-empty grep<CR>]], options)
  vim.api.nvim_set_keymap("n", "<Space>*",
    [[<cmd>DeniteCursorWord -buffer-name=search -no-empty grep<CR>]], options)

  vim.api.nvim_set_keymap("n", "<Space>]",
    [[&filetype == 'help' ?  "g\<C-]>" : ":\<C-u>DeniteCursorWord -buffer-name=tag -immediately tag:include\<CR>"]],
    options_expr)
  vim.api.nvim_set_keymap("n", "<Space>[",
    [[&filetype == 'help' ? ":\<C-u>pop\<CR>" : ":\<C-u>Denite jump\<CR>"]],
    options_expr)

  -- <Leader> mappings
  vim.api.nvim_set_keymap("n", "<Leader>r",
    [[<cmd>Denite -buffer-name=register register yank<CR>]], options)
  vim.api.nvim_set_keymap("x", "<Leader>r",
    [[<cmd>Denite -default-action=replace -buffer-name=register register yank<CR>]], options)
  vim.api.nvim_set_keymap("n", "<Leader><Leader>", [[<cmd>Denite command command_history<CR>]], options)
end

function M.hook_source()
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
  local width = vim.api.nvim_get_option("columns")
  local height = vim.api.nvim_get_option("lines")
  local win_width
  if width > 150 then
    win_width = math.ceil(width * 0.85)
  else
    win_width = width - 8
  end
  local win_height = math.ceil(height * 0.75)
  local wincol = math.ceil((width - win_width) / 2)
  local winrow = math.ceil((height - win_height) / 2)


  vim.fn["denite#custom#option"]("default", {
      highlight_filter_background = "CursorLine",
      prompt                      = "> ",
      source_names                = "short",
      split                       = "floating",
      filter_split_direction      = "floating",
      vertical_preview            = true,
      floating_preview            = true,
      winwidth                    = win_width,
      winheight                   = win_height,
      wincol                      = wincol,
      winrow                      = winrow,
    })

  vim.fn["denite#custom#option"]("search", {
      highlight_filter_background = "CursorLine",
      source_names                = "short",
      split                       = "floating",
      filter_split_direction      = "floating",
      vertical_preview            = true,
      floating_preview            = true,
    })

  -- Denite events
  vim.api.nvim_command("augroup user-plugin-denite")
  vim.api.nvim_command("autocmd!")
  vim.api.nvim_command("autocmd FileType denite        lua require('plugins.denite')._on_filetype_denite()")
  vim.api.nvim_command("autocmd FileType denite_filter lua require('plugins.denite')._on_filetype_denite_filter()")
  vim.api.nvim_command("augroup END")
end

function M._on_filetype_denite()
  vim.wo.winblend   = 20
  vim.wo.signcolumn = "no"
  vim.wo.cursorline = true

  local options        = {noremap = true, silent = true, expr = true}
  local options_nowait = {noremap = true, silent = true, expr = true, nowait = true}

  local buf = vim.api.nvim_get_current_buf()
  vim.api.nvim_buf_set_keymap(buf, "n", "<CR>",  "denite#do_map('do_action')",            options)
  vim.api.nvim_buf_set_keymap(buf, "n", "a",     "denite#do_map('open_filter_buffer')",   options)
  vim.api.nvim_buf_set_keymap(buf, "n", "i",     "denite#do_map('open_filter_buffer')",   options)
  vim.api.nvim_buf_set_keymap(buf, "n", "/",     "denite#do_map('open_filter_buffer')",   options)
  vim.api.nvim_buf_set_keymap(buf, "n", "'",     "denite#do_map('quick_move')",           options)
  vim.api.nvim_buf_set_keymap(buf, "n", "p",     "denite#do_map('do_action', 'preview')", options)
  vim.api.nvim_buf_set_keymap(buf, "n", "q",     "denite#do_map('quit')",                 options)
  vim.api.nvim_buf_set_keymap(buf, "n", "r",     "denite#do_map('redraw')",               options)
  vim.api.nvim_buf_set_keymap(buf, "n", "dd",    "denite#do_map('do_action', 'delete')",  options)
  vim.api.nvim_buf_set_keymap(buf, "n", "yy",    "denite#do_map('do_action', 'yank')",    options)
  vim.api.nvim_buf_set_keymap(buf, "n", "<Esc>", "denite#do_map('quit')",                 options)
  vim.api.nvim_buf_set_keymap(buf, "n", "<Tab>", "denite#do_map('choose_action')",        options)
  vim.api.nvim_buf_set_keymap(buf, "n", "<C-n>", "j", options)
  vim.api.nvim_buf_set_keymap(buf, "n", "<C-p>", "k", options)
  vim.api.nvim_buf_set_keymap(buf, "n", "<Space>", "denite#do_map('toggle_select').'j'", options_nowait)
end

function M._on_filetype_denite_filter()
  vim.wo.winblend       = 20
  vim.wo.signcolumn     = "yes"
  vim.wo.cursorline     = false
  vim.wo.number         = false
  vim.wo.relativenumber = false

  local buf = vim.api.nvim_get_current_buf()
  local options = {silent = true}
  vim.api.nvim_buf_set_keymap(buf, "n", "<C-g>", "<Plug>(denite_filter_quit)", options)
  vim.api.nvim_buf_set_keymap(buf, "i", "<C-g>", "<Plug>(denite_filter_quit)", options)
  vim.api.nvim_buf_set_keymap(buf, "n", "<C-c>", "<Plug>(denite_filter_quit)", options)
  vim.api.nvim_buf_set_keymap(buf, "i", "<C-c>", "<Plug>(denite_filter_quit)", options)
end

return M
