--- Set global options

--- Vim files & directories {{{
vim.o.backup      = false
vim.o.writebackup = false
vim.o.undofile    = true
vim.o.swapfile    = true

-- Directories to store backup, swap, view, and shada files
local cache = vim.env.VIM_CACHE_HOME
vim.o.backupdir = table.concat({cache .. "/backup", "~/tmp", "/tmp"}, ",")
vim.o.directory = table.concat({cache .. "/swap",   "~/tmp", "/tmp"}, ",")
vim.o.undodir   = table.concat({cache .. "/undo",   "~/tmp", "/tmp"}, ",")
vim.o.viewdir   = table.concat({cache .. "/view",   "~/tmp", "/tmp"}, ",")

-- Customize shada files entries.
-- Shada files are stored to $XDG_DATA_HOME/nvim/shada/main.shada by default
vim.o.shada = [['1000,<50,@100,s10,h]]
--- }}}

--- Language {{{
-- prefer english help
vim.o.helplang  = "en,ja";
-- The words list file where words are added by `zw` and `zg` command
vim.o.spellfile = vim.env.VIM_DATA_HOME .. "/spell/en.utf-8.add";
-- spell check (ignore on check on Asian characters (China, Japan, Korea))
vim.o.spelllang = "en_us,cjk";
vim.o.spell     = false;

-- -- Use double in unicode emoji characters
-- vim.o.emoji
-- -- Use single in ambiguous characters
-- vim.o.ambiwidth = "single"

--- }}}

--- Editting {{{
vim.o.smarttab       = true
vim.o.autoindent     = true
vim.o.smartindent    = true
vim.o.copyindent     = true
vim.o.preserveindent = true
vim.o.shiftround     = true
-- Bases for numbers used by CTRL-A (increment) and CTRL-X (decrement) command.
vim.o.nrformats = "alpha,hex,bin"
-- Allow virtual editing in Visual block mode.
vim.o.virtualedit = "block"
-- Allow backspacing over everything in insert mode
vim.o.backspace = "indent,eol,start"
-- Use system clipboard
if is_windows or vim.fn.has("clipboard") then
  vim.o.clipboard = "unnamed"
else
  vim.o.clipboard = "unnamedplus"
end

vim.o.showmatch  = true  -- Jump to matching bracket
vim.o.matchtime  = 1     -- Tenths of a second to show the matching paren
vim.o.matchpairs = "(:),{:},[:],<:>"
--- }}}

--- Timing {{{
vim.o.timeoutlen  = 500    -- Time out for a mapped sequence (ms)
vim.o.ttimeoutlen = 50     -- Time out for a key code sequence (ms)
vim.o.updatetime  = 1000   -- Idle time to write swap and trigger CursorHold (ms)
--- }}}

--- Search {{{
vim.o.ignorecase = true    -- Ignore cases in pattern
vim.o.smartcase  = true    -- Override 'ignorecase' if pattern contains upper cases.
vim.o.infercase  = true    -- Adjust case in insert completion mode
vim.o.hlsearch   = true    -- Highlight match results
vim.o.wrapscan   = true    -- Searches wrap around the end of the file
-- Set external commands for grep
if vim.fn.executable('rg') then
  vim.o.grepprg    = [[rg\ --vimgrep\ --no-heading\ -HS\ --line-number]]
  vim.o.grepformat = "%f:%l:%c:%m"
end
--- }}}

--- Behavior {{{
vim.o.history=10000           -- Amount of command line history
vim.o.hidden = true           -- Hide buffers when abandoned instead of unload
vim.o.autoread = true         -- Automatically read a file changed outside Vim
vim.o.startofline = false     -- Cursor in same column for few commands
vim.o.linebreak = true        -- Break long lines at 'breakat'
vim.o.showbreak=[[\]]         -- String to put at the start of wrapped lines
vim.o.breakat=[[\ \	;:,!?]] -- Chars to break long lines
vim.o.splitbelow = true       -- :split opens new window bottom of current window
vim.o.splitright = true       -- :vsplit opens new window right of the current window
-- Move to next/prev line on certain keys
vim.o.whichwrap = "b,s,h,l,<,>,[,],b,s~"
if vim.fn.exists("+breakindent") then
  vim.o.breakindent = true    -- Every wrapped line will continue visually indented
  vim.o.wrap        = true    -- Wrap lines by default
else
  vim.o.wrap        = false   -- Don't wrap lines otherwise
end

-- Behavior of switching between buffers
vim.o.switchbuf = "useopen,usetab,vsplit"

-- Keywork completion
vim.o.showfulltag  = true             -- Show tag and tidy search in completion
vim.o.complete     = "."              -- No wins, buffs, tags, include scanning
vim.o.completeopt  = "menuone,noselect,noinsert"

-- Diff mode
vim.o.diffopt      = "filler,iwhite,internal,algorithm:histogram,indent-heuristic"

-- What to save for views:
vim.o.viewoptions = "folds,cursor,curdir,slash,unix"

-- What to save in sessions:
vim.o.sessionoptions = "curdir,tabpages,winsize"
--- }}}

-- Editor UI Appearances {{{
vim.o.title         = true    -- Display title on the window (e.g. terminal)
vim.o.number        = false   -- Don't show line numbers
vim.o.ruler         = false   -- Disable default status ruler
vim.o.list          = true    -- Show hidden characters
vim.o.showmode      = false   -- Don't display mode in cmd window
vim.o.showcmd       = false   -- Don't show command in status line
vim.o.showtabline   = 1       -- Always display the tabs line
vim.o.laststatus    = 2       -- Always display a status line
vim.o.signcolumn    = "yes"   -- Always draw sign column
vim.o.cursorline    = true    -- Highlight current line
vim.o.cursorcolumn  = false   -- Do not highlight current column

vim.o.scrolloff     = 2       -- Keep at least 2 lines above/below
vim.o.sidescrolloff = 5       -- Keep at least 5 lines left/right
vim.o.winwidth      = 30      -- Minimum width for active window
vim.o.winminwidth   = 10      -- Minimum width for inactive windows
vim.o.winheight     = 1       -- Minimum height for active window
vim.o.pumheight     = 15      -- Pop-up menu's line height
vim.o.helpheight    = 12      -- Minimum help window height
vim.o.previewheight = 8       -- Completion preview height
vim.o.cmdheight     = 2       -- Height of the command line
vim.o.cmdwinheight  = 5       -- Command-line lines

vim.o.equalalways   = false   -- Don't resize windows on split or close
vim.o.colorcolumn   = "+1"    -- Highlight 'textwidth+1'-th column
vim.o.display       = "lastline"  -- Don't omit line in @

vim.o.listchars     = [[tab:▸\ ,trail:-,extends:»,precedes:«,nbsp:%,eol:↲]]
vim.o.shortmess     = "aoOTIcF"    -- Shorten messages and don't show intro

-- Disable annoying bells
vim.o.errorbells    = false
vim.o.visualbell    = false
vim.o.t_vb          = ""
vim.o.belloff       = "all"

-- Characters to fill the statuslines and vertical separators
vim.o.fillchars     = ""

-- Enable folding
vim.o.foldenable    = true
vim.o.foldcolumn    = "0"

--- }}}

--- Wildmenu: enhanced command line completion {{{

-- Display candidates by popup menu (requires NeoVim 0.4.x or later)
vim.o.wildmenu    = true
vim.o.wildmode    = "full"
vim.o.wildoptions = "pum,tagfile"
vim.o.pumblend    = 10

-- Ignore compiled files
local wildignore_list = {
  ".git", ".hg", ".svn",
  "*.jpg", "*.JPG", "*.jpeg", "*.JPEG", "*.png", "*.PNG", "*.bmp", "*.gif",
  "*.o", "*.obj", "*.exe", "*.dll", "*.dylib", "*.manifest", "*.so", "*.out", "*.class",
  "*.swp", "*.swo", "*.swn", "*.DS_Store", "*.ttf", "*.otf"
}
vim.o.wildignore = table.concat(wildignore_list, ",")
--- }}}
