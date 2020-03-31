local vim = vim
local plug = require("core.plug")

local layer = {}

function layer.register_plugins()
  plug.add_plugin("Shougo/defx.nvim",          {type = "opt"})
  plug.add_plugin('kristijanhusak/defx-icons', {type = "opt"})
  plug.add_plugin('kristijanhusak/defx-git')
end

function layer.init_config()
  -- keybind
  vim.api.nvim_set_keymap("n", "<Space>d",
    [[<cmd>Defx -listed -buffer-name=tab`tabpagenr()`<CR>]], {silent = true, noremap = true})

  -- auto commands
  vim.api.nvim_command("augroup user_plugin_defx")
  vim.api.nvim_command("autocmd!")
  -- Load defx plugin on demand
  vim.api.nvim_command("autocmd CmdUndefined Defx lua require('layer.tools.defx')._defx_load()")
  -- Define defx window mappings
  vim.api.nvim_command("autocmd FileType defx lua require('layer.tools.defx')._defx_mappings()")
  -- Delete defx buffer if it's the only buffer left in the window
  vim.api.nvim_command("autocmd WinEnter * if &filetype == 'defx' && winnr('$') == 1 | bdelete | endif")
  vim.api.nvim_command("augroup END")
end

function layer._defx_load()
  vim.api.nvim_command("packadd defx")
  vim.api.nvim_command("packadd defx-icons")

  vim.fn["defx#custom#option"]("_", {
      columns     = "icons:git:filename:type";
      winwidth    = 40;
      split       = "vertical";
      direction   = "topleft";
      root_marker = " ";
    })

  vim.fn["defx#custom#column"]("mark", {
      readonly_icon = "";
      selected_icon = "✓";
    })

  vim.fn["defx#custom#column"]("icon", {
      directory_icon = "▸";
      opened_icon    = "▾";
      root_icon      = " ";
    })
end

function layer._defx_mappings()
  local buf = vim.api.nvim_get_current_buf()
  local options = {silent = true, expr = true}
  local options_nowait = {silent = true, expr = true, nowait = true}
  -- navigation
  vim.api.nvim_buf_set_keymap(buf, "n", "<CR>",
    [[defx#async_action('drop')]], options)
  vim.api.nvim_buf_set_keymap(buf, "n", "l",
    [[defx#async_action('open')]], options)
  vim.api.nvim_buf_set_keymap(buf, "n", "o",
    [[defx#async_action('open_or_close_tree')]],  options)
  vim.api.nvim_buf_set_keymap(buf, "n", "O",
    [[defx#async_action('open_tree_recursive')]], options)
  vim.api.nvim_buf_set_keymap(buf, "n", "~",
    [[defx#async_action('cd')]], options)
  vim.api.nvim_buf_set_keymap(buf, "n", "h",
    [[defx#async_action('cd', '..')]], options)
  vim.api.nvim_buf_set_keymap(buf, "n", "\\",
    [[defx#do_action('cd', getcwd())]], options_nowait)
  vim.api.nvim_buf_set_keymap(buf, "n", "<TAB>",
    [[winnr('$') != 1 ? '<cmd>wincmd w<CR>' : '<cmd>Defx -buffer-name=temp -split=vertical<CR>']],
    options_nowait)

  -- exec command
  vim.api.nvim_buf_set_keymap(buf, "n", "!",
    [[defx#do_action('execute_command')]], options)
  vim.api.nvim_buf_set_keymap(buf, "n", "x",
    [[defx#do_action('execute_system')]], options)

  -- file/dir management
  vim.api.nvim_buf_set_keymap(buf, "n", "c",
    [[defx#do_action('copy')]], options_nowait)
  vim.api.nvim_buf_set_keymap(buf, "n", "m",
    [[defx#do_action('move')]], options_nowait)
  vim.api.nvim_buf_set_keymap(buf, "n", "p",
    [[defx#do_action('paste')]], options_nowait)
  vim.api.nvim_buf_set_keymap(buf, "n", "r",
    [[defx#do_action('rename')]], options_nowait)
  vim.api.nvim_buf_set_keymap(buf, "n", "dd",
    [[defx#do_action('remove_trash')]], options)
  vim.api.nvim_buf_set_keymap(buf, "n", "yy",
    [[defx#do_action('yank_path')]], options)
  vim.api.nvim_buf_set_keymap(buf, "n", "K",
    [[defx#do_action('rename')]], options)
  vim.api.nvim_buf_set_keymap(buf, "n", "M",
    [[defx#do_action('new_multiple_files')]], options)
  vim.api.nvim_buf_set_keymap(buf, "n", "N",
    [[defx#do_action('new_file')]], options)

  -- Selection
  vim.api.nvim_buf_set_keymap(buf, "n", "<Space>",
    [[defx#do_action('toggle_select') . 'j']], options_nowait)
  vim.api.nvim_buf_set_keymap(buf, "x", "<CR>",
    [[defx#do_action('toggle_select_visual')]], options)
  vim.api.nvim_buf_set_keymap(buf, "n", "*",
    [[defx#do_action('toggle_select_all')]], options)
  vim.api.nvim_buf_set_keymap(buf, "n", "<C-c>",
    [[defx#do_action('clear_select_all')]], options)

  -- Display
  vim.api.nvim_buf_set_keymap(buf, "n", "<C-g>",
    [[defx#do_action('print')]], options)
  vim.api.nvim_buf_set_keymap(buf, "n", "<C-l>",
    [[defx#do_action('redraw')]], options)
  vim.api.nvim_buf_set_keymap(buf, "n", ".",
    [[defx#do_action('toggle_ignored_files')]], options)
  vim.api.nvim_buf_set_keymap(buf, "n", "S",
    [[defx#do_action('toggle_sort', 'Time')]], options)
  vim.api.nvim_buf_set_keymap(buf, "n", "C",
    [[defx#do_action('toggle_columns', 'indent:mark:filename:type:size:time')]],
    options)
end

return layer
