local vim   = vim or {}
local utils = require('vimrc_utils')

--- Environment variables {{{1
local home = os.getenv("HOME")

local function configure_path(new_paths, path_var)
  local path_separator = utils.os.is_windows and ";" or ":"
  local paths = {}

  local function is_empty(str)
    return str == nil or str == ""
  end

  local function add_paths(list)
    for _, x in ipairs(list) do
      if not is_empty(x) then
        y = vim.fn.expand(x)
        if utils.path.is_dir(y) and not vim.tbl_contains(paths, y) then
          paths[#paths+1] = y
        end
      end
    end
  end

  -- Add given directories in the path list.
  add_paths(new_paths)
  -- Split path_var string with the separator, and filter out non-exsiting dirs
  if not is_empty(path_var) then
    add_paths(vim.split(path_var, path_separator, true))
  end
  -- concat paths
  return table.concat(paths, path_separator)
end


local function set_envs()
  -- Directories to store nvim related files
  local config_home = os.getenv("XDG_CONFIG_HOME") or home .. "/.config"
  local cache_home  = os.getenv("XDG_CACHE_HOME")  or home .. "/.cache"
  local data_home   = os.getenv("XDG_DATA_HOME")   or home .. "/.local/share"

  vim.env.VIM_CONFIG_HOME = config_home .. "/nvim"
  vim.env.VIM_CACHE_HOME  = cache_home  .. "/nvim"
  vim.env.VIM_DATA_HOME   = data_home   .. "/nvim"

  -- Set PATH/MANPATH so that Nvim GUI frontend can recognize these variables
  vim.env.PATH = configure_path({
      "~/.poetry/bin",
      "~/.yarn/bin",
      "~/.cargo/bin",
      "~/.goenv/bin",
      "~/.nodenv/bin",
      "~/.rbenv/bin",
      "~/.pyenv/bin",
      "~/.nodenv/shims",
      "~/.rbenv/shims",
      "~/.pyenv/shims",
      "~/.anyenv/envs/goenv/bin",
      "~/.anyenv/envs/rbenv/bin",
      "~/.anyenv/envs/pyenv/bin",
      "~/.anyenv/envs/nodenv/shims",
      "~/.anyenv/envs/rbenv/shims",
      "~/.anyenv/envs/pyenv/shims",
      "~/.local/bin",
      "~/bin",
      "/Library/Tex/texbin",
      "/usr/local/bin",
      "/usr/bin",
      "/bin",
      "/usr/local/sbin",
      "/usr/sbin",
      "/sbin",
    }, os.getenv("PATH"))

  vim.env.MANPATH = configure_path({
      "~/.local/share/man",
      "/usr/share/man/",
      "/usr/local/share/man/ja",
      "/usr/local/share/man/",
      "/Applications/Xcode.app/Contents/Developer/usr/share/man",
      "/opt/intel/man/",
    }, os.getenv("MANPATH"))

  -- Pyenv root directory
  vim.env.PYENV_ROOT = vim.fn.expand('~/.anyenv/envs/pyenv')
end

--- Ensure cache and data directories exist {{{1
local function create_backup_dirs()
  -- NOTE: this function must be called after setting ENVS
  vim.fn.mkdir(vim.env.VIM_CACHE_HOME .. "/backup",  "p")
  vim.fn.mkdir(vim.env.VIM_CACHE_HOME .. "/swap",    "p")
  vim.fn.mkdir(vim.env.VIM_CACHE_HOME .. "/undo",    "p")
  vim.fn.mkdir(vim.env.VIM_CACHE_HOME .. "/view",    "p")
  vim.fn.mkdir(vim.env.VIM_CACHE_HOME .. "/session", "p")
  vim.fn.mkdir(vim.env.VIM_DATA_HOME  .. "/spell",   "p")
end

--- Set nvim built-in global options on startup {{{1
local function set_global_options_on_startup()
  -- Set default text encoding
  vim.o.encoding = "utf-8"
  -- List of character encodings considered when starting to edit an existing file
  vim.o.fileencodings = "ucs-bom,utf-8,euc-jp,iso-2022-jp,cp932,utf-16,utf-16le,cp1250"

  -- IME setting
  if vim.fn.has("multi_byte_ime") then
    vim.o.iminsert = 0
    vim.o.imsearch = 0
  end

  --[[
    Enable true color if supported.

    TODO: We should check if the terminal emulater has truecolor supports, but
    there is no reliable ways to do that. Some terminal emulater provides
    $COLORTERM environment variable set to 'truecolor' or '24bit' so we also
    checkt this variable.
  --]]
  local colorterm = os.getenv("COLORTERM")
  if vim.fn.has("termguicolors") and (colorterm == "truecolor" or colorterm == "24bit") then
    vim.o.termguicolors = true
  end

  --- Directories to find packages
  -- vim.o.packpath = vim.env.VIM_CACHE_HOME
  vim.o.packpath = ""
end

--- Set nvim default global vars on startup {{{1
local function set_global_vars_on_startup()
  --[[
    Set python2/python3 interpretor (required to setup plugins using neovim
    python API).

    It is recommended to create virtualenvs for and only for neovim (install
    pynvim + development tools) and set python3_host_prog and python_host_prog
    to point the corresponding python interpreters.
  --]]
  vim.g.python3_host_prog = vim.env.PYENV_ROOT .. "/versions/neovim3/bin/python"
  vim.g.python_host_prog  = vim.env.PYENV_ROOT .. "/versions/neovim2/bin/python"

  --[[ Leader/Localleader keys ]]
  vim.g.mapleader      = ";"
  vim.g.maplocalleader = ","

  --[[ Disable unnecessary default plugins ]]
  vim.g.loaded_2html_plugin      = 1
  vim.g.loaded_getscript         = 1
  vim.g.loaded_getscriptPlugin   = 1
  vim.g.loaded_gzip              = 1
  vim.g.loaded_logiPat           = 1
  vim.g.loaded_matchit           = 1
  vim.g.loaded_matchparen        = 1
  vim.g.netrw_nogx               = 1
  vim.g.loaded_netrwPlugin       = 1
  vim.g.loaded_netrwSettings     = 1
  vim.g.loaded_netrwFileHandlers = 1
  vim.g.loaded_rrhelper          = 1
  vim.g.loaded_spellfile_plugin  = 1
  vim.g.loaded_tar               = 1
  vim.g.loaded_tarPlugin         = 1
  vim.g.loaded_vimball           = 1
  vim.g.loaded_vimballPlugin     = 1
  vim.g.loaded_zip               = 1
  vim.g.loaded_zipPlugin         = 1
  -- Disable ruby support in neovim
  vim.g.loaded_ruby_provider     = 1
end

--- Set global options in nvim core
local function set_global_options()
  local cache = vim.env.VIM_CACHE_HOME
  local options = {
    -- backup, swap, view, shada files {{{3
    backup         = false;
    writebackup    = false;
    undofile       = true;
    swapfile       = true;
    backupdir      = table.concat({cache .. "/backup", "~/tmp", "/tmp"}, ",");
    directory      = table.concat({cache .. "/swap",   "~/tmp", "/tmp"}, ",");
    undodir        = table.concat({cache .. "/undo",   "~/tmp", "/tmp"}, ",");
    viewdir        = table.concat({cache .. "/view",   "~/tmp", "/tmp"}, ",");
    shada          = [['1000,<50,@100,s10,h]];

    -- Language {{{3
    helplang       = "en,ja";
    spellfile      = vim.env.VIM_DATA_HOME .. "/spell/en.utf-8.add";
    spelllang      = "en_us,cjk";
    spell          = false;

    -- Editting {{{3
    smarttab       = true;
    autoindent     = true;
    smartindent    = true;
    copyindent     = true;
    preserveindent = true;
    shiftround     = true;
    nrformats      = "alpha,hex,bin";
    virtualedit    = "block";
    backspace      = "indent,eol,start";
    showmatch      = true;
    matchtime      = 1;
    matchpairs     = "(:),{:},[:],<:>";

    --- Timing {{{3
    timeoutlen     = 500;    -- Time out for a mapped sequence (ms)
    ttimeoutlen    = 50;     -- Time out for a key code sequence (ms)
    updatetime     = 1000;   -- Idle time to write swap and trigger CursorHold (ms)

    --- Search {{{3
    ignorecase     = true;   -- Ignore cases in pattern
    smartcase      = true;   -- Override 'ignorecase' if pattern contains upper cases.
    infercase      = true;   -- Adjust case in insert completion mode
    hlsearch       = true;   -- Highlight match results
    wrapscan       = true;   -- Searches wrap around the end of the file

    -- Behavior {{{3
    history        = 10000;          -- Amount of command line history
    hidden         = true;           -- Hide buffers when abandoned instead of unload
    autoread       = true;           -- Automatically read a file changed outside Vim
    startofline    = false;          -- Cursor in same column for few commands
    linebreak      = true;           -- Break long lines at 'breakat'
    showbreak      = [[\]];          -- String to put at the start of wrapped lines
    breakat        = [[\ \	;:,!?]]; -- Chars to break long lines
    splitbelow     = true;           -- :split opens new window bottom of current window
    splitright     = true;           -- :vsplit opens new window right of the current window
    breakindent    = true;           -- Every wrapped line will continue visually indented
    wrap           = true;           -- Wrap lines by default
    -- Move to next/prev line on certain keys
    whichwrap      = "b,s,h,l,<,>,[,],b,s~";
    -- Behavior of switching between buffers
    switchbuf      = "useopen,usetab,vsplit";
    -- Keywork completion
    showfulltag    = true;          -- Show tag and tidy search in completion
    complete       = ".";           -- No wins, buffs, tags, include scanning
    completeopt    = "menuone,noselect,noinsert";
    -- Diff mode
    diffopt        = "filler,iwhite,internal,algorithm:histogram,indent-heuristic";
    -- What to save for views:
    viewoptions    = "folds,cursor,curdir,slash,unix";
    -- What to save in sessions:
    sessionoptions = "curdir,tabpages,winsize";

    -- Editor UI Appearances {{{3
    title          = true;        -- Display title on the window (e.g. terminal)
    number         = false;       -- Don't show line numbers
    ruler          = false;       -- Disable default status ruler
    list           = true;        -- Show hidden characters
    showmode       = false;       -- Don't display mode in cmd window
    showcmd        = false;       -- Don't show command in status line
    showtabline    = 1;           -- Always display the tabs line
    laststatus     = 2;           -- Always display a status line
    signcolumn     = "yes";       -- Always draw sign column
    cursorline     = true;        -- Highlight current line
    cursorcolumn   = false;       -- Do not highlight current column
    scrolloff      = 2;           -- Keep at least 2 lines above/below
    sidescrolloff  = 5;           -- Keep at least 5 lines left/right
    winwidth       = 30;          -- Minimum width for active window
    winminwidth    = 10;          -- Minimum width for inactive windows
    winheight      = 1;           -- Minimum height for active window
    pumheight      = 15;          -- Pop-up menu's line height
    helpheight     = 12;          -- Minimum help window height
    previewheight  = 8;           -- Completion preview height
    cmdheight      = 2;           -- Height of the command line
    cmdwinheight   = 5;           -- Command-line lines
    equalalways    = false;       -- Don't resize windows on split or close
    colorcolumn    = "+1";        -- Highlight 'textwidth+1'-th column
    display        = "lastline";  -- Don't omit line in @
    listchars      = [[tab:▸\ ,trail:-,extends:»,precedes:«,nbsp:%,eol:↲]];
    shortmess      = "aoOTIcF";   -- Shorten messages and don't show intro
    -- Disable annoying bells
    errorbells     = false;
    visualbell     = false;
    t_vb           = "";
    belloff        = "all";
    -- Characters to fill the statuslines and vertical separators
    fillchars      = "";
    -- Enable folding
    foldenable     = true;
    foldcolumn     = "0";

    --- Wildmenu: enhanced command line completion (requqires Nvim 0.4.x or later) {{{3
    wildmenu       = true;
    wildmode       = "full";
    wildoptions    = "pum,tagfile";
    pumblend       = 10;
    wildignore     = table.concat({
        ".git", ".hg", ".svn", "*.jpg", "*.JPG", "*.jpeg", "*.JPEG", "*.png",
        "*.PNG", "*.bmp", "*.gif", "*.o", "*.obj", "*.exe", "*.dll", "*.dylib",
        "*.manifest", "*.so", "*.out", "*.class", "*.swp", "*.swo", "*.swn",
        "*.DS_Store", "*.ttf", "*.otf"
      }, ",");
  }

  for k, v in pairs(options) do
    vim.api.nvim_set_option(k, v)
  end

  -- Use system clipboard
  if is_windows or vim.fn.has("clipboard") then
    vim.o.clipboard = "unnamed"
  else
    vim.o.clipboard = "unnamedplus"
  end

  -- Set external commands for grep
  if vim.fn.executable('rg') then
    vim.o.grepprg    = [[rg\ --vimgrep\ --no-heading\ -HS\ --line-number]]
    vim.o.grepformat = "%f:%l:%c:%m"
  end
end

--- Create autocmds {{{1
local function create_autocmds()
  local autocmds = {
    MyAutoCmd = {};
  }
  utils.create_augroups(autocmds)
end

--- Initialize {{{1
set_envs()

if vim.fn.has("vim_starting") then
  create_backup_dirs()
  set_global_options_on_startup()
  set_global_vars_on_startup()
end


-- Global options (Nvim core)
set_global_options()
create_autocmds()

-- Plugins
require("dein")
-- vim.api.nvim_command("command! PackUpdate  lua require('minpac').pack_update()")
-- vim.api.nvim_command("command! PackClean   lua require('minpac').pack_clean()")
-- vim.api.nvim_command("command! PackStatus  lua require('minpac').pack_status()")
