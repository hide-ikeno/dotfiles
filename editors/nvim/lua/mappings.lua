--- ~/.config/nvim/lua/mapping.lua
--- Set global key mappings

local api = vim.api
--[[
-----------------------------------------------------------------------------
| Commands \ Modes | Normal | Insert | Command | Visual | Select | Operator |
|------------------|--------|--------|---------|--------|--------|----------|
| map  / noremap   |    @   |   -    |    -    |   @    |   @    |    @     |
| nmap / nnoremap  |    @   |   -    |    -    |   -    |   -    |    -     |
| vmap / vnoremap  |    -   |   -    |    -    |   @    |   @    |    -     |
| omap / onoremap  |    -   |   -    |    -    |   -    |   -    |    @     |
| xmap / xnoremap  |    -   |   -    |    -    |   @    |   -    |    -     |
| smap / snoremap  |    -   |   -    |    -    |   -    |   @    |    -     |
| map! / noremap!  |    -   |   @    |    @    |   -    |   -    |    -     |
| imap / inoremap  |    -   |   @    |    -    |   -    |   -    |    -     |
| cmap / cnoremap  |    -   |   -    |    @    |   -    |   -    |    -     |
-----------------------------------------------------------------------------
--]]

--- mapleader
vim.g.mapleader = ";"
vim.g.localmapleader = ","

--- Basic mappings {{{
-- Disable Ex-mode, remap to register macros
api.nvim_set_keymap("n", "Q", "q", {noremap = true})

-- Disable dangerous/annoying default mappings
--   ZZ - Save current file and quit
--   ZQ - Quit without checking changes (:q!)
api.nvim_set_keymap("n", "ZZ", "<Nop>", {noremap = true})
api.nvim_set_keymap("n", "ZQ", "<Nop>", {noremap = true})

-- Useless command. M - to middle line of window
api.nvim_set_keymap("n", "M", "m", {noremap = true})

-- Y: yank text from cursor position to the EOL
api.nvim_set_keymap("n", "Y", "y$", {noremap = true})

-- Emacs-like cursor move in insert/command mode
api.nvim_set_keymap("i", "<C-a>", "<Home>",  {noremap = true})
api.nvim_set_keymap("i", "<C-b>", "<Left>",  {noremap = true})
api.nvim_set_keymap("i", "<C-d>", "<Del>",   {noremap = true})
api.nvim_set_keymap("i", "<C-e>", "<End>",   {noremap = true})
api.nvim_set_keymap("i", "<C-f>", "<Right>", {noremap = true})
api.nvim_set_keymap("i", "<C-k>", "<C-o>D",  {noremap = true})

api.nvim_set_keymap("c", "<C-a>", "<Home>",  {noremap = true})
api.nvim_set_keymap("c", "<C-b>", "<Left>",  {noremap = true})
api.nvim_set_keymap("c", "<C-d>", "<Del>",   {noremap = true})
api.nvim_set_keymap("c", "<C-e>", "<End>",   {noremap = true})
api.nvim_set_keymap("c", "<C-f>", "<Right>", {noremap = true})
api.nvim_set_keymap("c", "<C-n>", "<Down>",  {noremap = true})
api.nvim_set_keymap("c", "<C-p>", "<Up>",    {noremap = true})

-- Smart scroll with <C-f>, <C-b>.
api.nvim_set_keymap("n", "<C-f>",
  [[max([winheight(0) - 2, 1]) . "\<C-d>" . (line('w$') >= line('$') ? "L" : "M")]],
  {noremap = true, expr = true})
api.nvim_set_keymap("n", "<C-b>",
  [[max([winheight(0) - 2, 1]) . "\<C-u>" . (line('w0') <= 1 ? "H" : "M")]],
  {noremap = true, expr = true})

-- Enable undo <C-w> and <C-u> in insert mode.
api.nvim_set_keymap("i", "<C-w>", "<C-g>u<C-w>", {noremap = true})
api.nvim_set_keymap("i", "<C-u>", "<C-g>u<C-u>", {noremap = true})

-- <C-y>: paste
api.nvim_set_keymap("c", "<C-y>", "<C-r>*", {noremap = true})
-- <C-g>: exit
api.nvim_set_keymap("c", "<C-g>", "<C-c>",  {noremap = true})

-- Indent by > and < instead of >> and <<
api.nvim_set_keymap("n", ">", ">>", {noremap = true})
api.nvim_set_keymap("n", "<", "<<", {noremap = true})

-- Maintain visual mode after shifting > and <
api.nvim_set_keymap("x", ">", ">gv", {noremap = true})
api.nvim_set_keymap("x", "<", "<gv", {noremap = true})

-- Easy escape
api.nvim_set_keymap("i", "jj", "<ESC>", {noremap = true})
api.nvim_set_keymap("i", "j ", "j",     {noremap = true})
api.nvim_set_keymap("c", "j", [[getcmdline()[getcmdpos()-2] ==# 'j' ? "\<BS>\<C-c>" : 'j']],
                    {noremap = true, expr = true})

-- Start new line from any cursor position
api.nvim_set_keymap("i", "<S-Return>", "<C-o>o", {noremap = true})

-- Change current word in a repeatable manner
api.nvim_set_keymap("n", "cn", "*``cgn", {noremap = true})
api.nvim_set_keymap("n", "cN", "*``cgN", {noremap = true})

-- Change selected word in a repeatable manner
api.nvim_set_keymap("v", "cn", [["y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>" . "``cgn"]],
                    {noremap = true, expr = true})
api.nvim_set_keymap("v", "cN", [["y/\\V\<C-r>=escape(@\", '/')\<CR>\<CR>" . "``cgN"]],
                    {noremap = true, expr = true})

-- Close windows with q
api.nvim_set_keymap("n", "q", [[winnr('$') != 1 ? ':<C-u>close<CR>' : ':<C-u>bdelete<CR>']],
                    {noremap = true, silent = true, expr = true})

-- Turn off search highlight
api.nvim_set_keymap("n", "<ESC><Esc>", [[<Cmd>silent! nohlsearch<CR>]],
                    {noremap = true, silent = true})
--- }}}

--- Open/close folding: {{{
-- Toggle fold
api.nvim_set_keymap("n", "<CR>", "za",         {noremap = true})
-- Focus the current fold by closing all others
api.nvim_set_keymap("n", "<S-Return>", "zMza", {noremap = true})

-- Smart open/close fold
function smart_fold_closer()
  if vim.fn.foldlevel(".") == 0 then
    vim.cmd("normal! zM")
    return
  end

  local foldc_lnum = vim.fn.foldclosed(".")
  vim.cmd("normal! zM")
  if foldc_lnum == -1 then
    return
  end

  if vim.fn.foldclosed('.') == foldc_lnum then
    vim.cmd("normal! zM")
  end
  return
end

api.nvim_set_keymap("n", "l", [[foldclosed('.') != -1 ? 'zo' : 'l']],
                    {noremap = true, expr = true})
api.nvim_set_keymap("x", "l", [[foldclosed(line('.')) != -1 ? 'zogv0' : 'l']],
                    {noremap = true, expr = true})
api.nvim_set_keymap("n", "<C-_>", ":<C-u>lua smart_fold_closer()<CR>",
                    {noremap = true, silent = true})
--- }}}

-- Window/Tabs operation {{{
-- Use 's' key as the prefix to control window/tab

-- new tab
api.nvim_set_keymap("n", "st", ":tabnew<CR>", {noremap = true, silent = true})
-- close window
api.nvim_set_keymap("n", "sc", ":close<CR>",  {noremap = true, silent = true})
-- only current window
api.nvim_set_keymap("n", "so", ":<C-u>only<CR>",  {noremap = true, silent = true})
-- split window horizontally
api.nvim_set_keymap("n", "s-", ":<C-u>split<CR>", {noremap = true, silent = true})
-- split window virtically
api.nvim_set_keymap("n", "s|", ":<C-u>vsplit<CR>", {noremap = true, silent = true})
-- equal size window
api.nvim_set_keymap("n", "s=", "<C-w>=<CR>", {noremap = true, silent = true})

-- Move windown with TAB
api.nvim_set_keymap("n", "<Tab>",   "<C-w>w", {noremap = true, silent = true})
api.nvim_set_keymap("n", "<S-Tab>", "<C-w>W", {noremap = true, silent = true})

-- Resize window by Shift+arrow
api.nvim_set_keymap("n", "<S-Left>",  "<C-w><", {noremap = true})
api.nvim_set_keymap("n", "<S-Right>", "<C-w>>", {noremap = true})
api.nvim_set_keymap("n", "<S-Up>",    "<C-w>+", {noremap = true})
api.nvim_set_keymap("n", "<S-Down>",  "<C-w>-", {noremap = true})
---  }}}

--- Leader mappings {{{
-- ;; to :
-- api.nvim_set_keymap("n", "<Leader>;",  ":", {noremap = true, silent = true})

-- Quit
api.nvim_set_keymap("n", "<Leader>q",  ":quit<CR>",        {noremap = true, silent = true})
api.nvim_set_keymap("v", "<Leader>q",  "<ESC>:quit<CR>",   {noremap = true, silent = true})
api.nvim_set_keymap("n", "<Leader>Q",  ":qall!<CR>",       {noremap = true, silent = true})
api.nvim_set_keymap("v", "<Leader>Q",  "<ESC>:qall!<CR>",  {noremap = true, silent = true})

-- Fast saving
api.nvim_set_keymap("n", "<Leader>w",  ":update<CR>",      {noremap = true, silent = true})
api.nvim_set_keymap("v", "<Leader>w",  "<ESC>:update<CR>", {noremap = true, silent = true})
api.nvim_set_keymap("n", "<Leader>W",  ":wall!<CR>",       {noremap = true, silent = true})
api.nvim_set_keymap("v", "<Leader>W",  "<ESC>:wall!<CR>",  {noremap = true, silent = true})

-- Toggle editor visuals
local function toggle_option(name)
   return (":setlocal %s! %s?<CR>"):format(name, name)
end
api.nvim_set_keymap("n", "<Leader>tc", toggle_option("cursorcolumn"),
                    {noremap = true, silent = true})
api.nvim_set_keymap("n", "<Leader>tl", toggle_option("cursorline"),
                    {noremap = true, silent = true})
api.nvim_set_keymap("n", "<Leader>tn", ":setlocal number! relativenumber!<CR>",
                    {noremap = true, silent = true})
api.nvim_set_keymap("n", "<Leader>th", toggle_option("nolist"),
                    {noremap = true, silent = true})
api.nvim_set_keymap("n", "<Leader>ts", toggle_option("spell"),
                    {noremap = true, silent = true})
api.nvim_set_keymap("n", "<Leader>tw", ":setlocal wrap! breakindent!<CR>",
                    {noremap = true, silent = true})
--- }}}
