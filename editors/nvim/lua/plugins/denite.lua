-- Denite: Dark powered asynchronous unite all interfaces for Neovim/Vim8

local function setup()
  -- lazy load
  local cmds = {"Denite", "DeniteBufferDir", "DeniteCursorWord", "DentieProjectDir"}
  vim.api.nvim_command(
    "autocmd MyAutoCmd CmdUndefined " .. table.concat(cmds, ",") ..
    " lua require('plugins.denite').setup_lazy()"
  )

  -- Replace default search mappings
  vim.api.nvim_set_keymap(
    "n", "/", "line('$') > 10000 ? '/' : <cmd>Denite -buffer-name=search -start-filter line<CR>",
    {noremap = true, expr = true}
  )
  vim.api.nvim_set_keymap(
    "n", "n", "line('$') > 10000 ? 'n' : <cmd>Denite -buffer-name=search -resume -refresh -no-start-filter<CR>",
    {noremap = true, expr = true}
  )
  vim.api.nvim_set_keymap(
    "n", "*", "line('$') > 10000 ? '*' : <cmd>DeniteCursorWord -buffer-name=search line<CR>",
    {noremap = true, expr = true}
  )
  vim.api.nvim_set_keymap(
    "x", "*", "qy:Denite -input=`@q` -buffer-name=search line<CR>",
    {noremap = true, silent = true}
  )

  -- <Space> mappings
  vim.api.nvim_set_keymap(
  "n", "<Space>b", "<cmd>Denite buffer file_mru -default-action=switch<CR>",
  {noremap = true, silent = true}
  )
  vim.api.nvim_set_keymap(
  "n", "<Space>f",
  "<cmd>Denite file/point file/old -sorters=sorter/rank `finddir('.git', ';') != '' ? 'file/rec/git' : 'file/rec'` file file:new<CR>",
  {noremap = true, silent = true}
  )
  vim.api.nvim_set_keymap("n", "<Space>h", "<cmd>Denite help<CR>",         {noremap = true, silent = true})
  vim.api.nvim_set_keymap("n", "<Space>l", "<cmd>Denite locaton_list<CR>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap("n", "<Space>q", "<cmd>Denite quick_fix<CR>",    {noremap = true, silent = true})
  vim.api.nvim_set_keymap("n", "<Space>r", "<cmd>Denite -resume -refresh -no-start-filter<CR>", {noremap = true, silent = true})

  vim.api.nvim_set_keymap("n", "<Space>/", "<cmd>Denite -buffer-name=search -no-empty grep<CR>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap("n", "<Space>*", "<cmd>DeniteCursorWord -buffer-name=search -no-empty grep<CR>", {noremap = true, silent = true})
  --   nnoremap <silent><expr> <Space>]  &filetype == 'help' ?  "g\<C-]>" :
  --         \ ":\<C-u>DeniteCursorWord -buffer-name=tag -immediately tag:include\<CR>"
  --   nnoremap <silent><expr> <Space>[  &filetype == 'help' ?
  --         \ ":\<C-u>pop\<CR>" : ":\<C-u>Denite jump\<CR>"
  --
  --   -- <Leader> mappings
  --   nnoremap <silent> <Leader>r
  --         \ :<C-u>Denite -buffer-name=register register neoyank<CR>
  --   xnoremap <silent> <Leader>r
  --         \ :<C-u>Denite -default-action=replace -buffer-name=register register neoyank<CR>
  --   nnoremap <silent> <Leader><Leader>  :<C-u>Denite command command_history<CR>
  --
end

-- Hook before load

local function setup_lazy()
  vim.api.nvim_command[[ packadd denite.nvim ]]
  vim.api.nvim_command[[ packadd fruzzy ]]
  vim.api.nvim_command[[ packadd neoyank.vim ]]
  vim.api.nvim_command[[ packadd neomru.vim ]]
end

return { setup = setup, setup_lazy = setup_lazy }
