local icons = require("devicons")

local M = {}

-- [[ Configurations ]]

-- Separators
local separator = {
  left  = "";
  right = "";
}

-- Colors {{{1
local palette = {}

palette["default"] = {
  fg        = { "White",     "White"     },
  bg        = { "Black",     "Black"     },
  black     = { "Black",     "Black"     },
  blue      = { "Blue",      "Blue"      },
  green     = { "Green",     "Green"     },
  cyan      = { "Cyan",      "Cyan"      },
  red       = { "Red",       "Red"       },
  purple    = { "Magenta",   "Magenta"   },
  yellow    = { "Yellow",    "Yellow"    },
  white     = { "White",     "White"     },
  lightgrey = { "LightGrey", "LightGrey" },
  grey      = { "Grey",      "Grey"      },
  darkgrey  = { "DarkGrey",  "DarkGrey"  },
}

palette["forest-night"] = {
  fg        = { "#d8caac", 223 },
  bg        = { "#323d43", 235 },
  black     = { "#323d43", 235 },
  blue      = { "#83b6af", 109 },
  green     = { "#a7c080", 142 },
  cyan      = { "#87c095", 108 },
  red       = { "#e68183", 167 },
  purple    = { "#d49bb6", 175 },
  yellow    = { "#d9bb80", 214 },
  white     = { "#d8caac", 223 },
  lightgrey = { "#505a60", 238 },
  grey      = { "#465258", 237 },
  darkgrey  = { "#3c474d", 236 },
}

local function highlight(group, guifg, guibg, ctermfg, ctermbg, attr, guisp)
  local parts = {group}
  if guifg then table.insert(parts, "guifg="..guifg) end
  if guibg then table.insert(parts, "guibg="..guibg) end
  if ctermfg then table.insert(parts, "ctermfg="..ctermfg) end
  if ctermbg then table.insert(parts, "ctermbg="..ctermbg) end
  if attr then
    table.insert(parts, "gui="..attr)
    table.insert(parts, "cterm="..attr)
  end
  if guisp then table.insert(parts, "guisp=#"..guisp) end
  vim.cmd('highlight '..table.concat(parts, ' '))
end

function M.apply_theme(theme_name)
  local c = palette[theme_name]
  -- Base
  highlight("StatusLineBase", c.grey[1], nil, c.grey[2], nil,  nil, nil)

  -- Inactive
  highlight("StatusLineInactive", c.white[1], c.darkgrey[1], c.white[2], c.darkgrey[2], nil, nil)
  highlight("StatusLineInactiveSep", c.darkgrey[1], nil, c.darkgrey[2], nil, nil, nil)

  -- Mode
  highlight("StatusLineNormal",  c.darkgrey[1], c.green[1],  c.darkgrey[2], c.green[2],  "bold", nil)
  highlight("StatusLineInsert",  c.darkgrey[1], c.blue[1],   c.darkgrey[2], c.blue[2],   "bold", nil)
  highlight("StatusLineVisual",  c.darkgrey[1], c.purple[1], c.darkgrey[2], c.purple[2], "bold", nil)
  highlight("StatusLineReplace", c.darkgrey[1], c.red[1],    c.darkgrey[2], c.red[2],    "bold", nil)
  highlight("StatusLineCommand", c.darkgrey[1], c.yellow[1], c.darkgrey[2], c.yellow[2], "bold", nil)

  highlight("StatusLineNormalSep",  c.green[1],  nil, c.green[2],  nil, nil, nil)
  highlight("StatusLineInsertSep",  c.blue[1],   nil, c.blue[2],   nil, nil, nil)
  highlight("StatusLineVisualSep",  c.purple[1], nil, c.purple[2], nil, nil, nil)
  highlight("StatusLineReplaceSep", c.red[1],    nil, c.red[2],    nil, nil, nil)
  highlight("StatusLineCommandSep", c.yellow[1], nil, c.yellow[2], nil, nil, nil)

  -- File info
  highlight("StatusLineFileName",   c.fg[1],   c.grey[1], c.fg[2],   c.grey[2], nil, nil)
  highlight("StatusLineFileType",   c.blue[1], c.grey[1], c.blue[2], c.grey[2],  nil, nil)
  highlight("StatusLineFileFormat", c.fg[1],   c.grey[1], c.fg[2],   c.grey[2],  nil, nil)

  -- Line column info
  highlight("StatusLineLinCol",     c.fg[1], c.grey[1], c.fg[2], c.grey[2], nil, nil)
  highlight("StatusLineLinColSep",  c.grey[1], nil, c.grey[2], nil,  nil, nil)
  highlight("StatusLinePercent",    c.fg[1], c.darkgrey[1], c.fg[2], c.darkgrey[2], nil, nil)
  highlight("StatusLinePercentSep", c.darkgrey[1], nil, c.darkgrey[2], nil, nil, nil)

  -- VCS
  highlight("StatusLineVCS",    c.purple[1], c.darkgrey[1], c.purple[2], c.darkgrey[2], nil, nil)
  highlight("StatusLineVCSSep", c.darkgrey[1], nil, c.darkgrey[2], nil, nil, nil)

  -- LSP
  highlight("StatusLineLsp",    c.black[1], c.lightgrey[1], c.black[2], c.lightgrey[2], nil, nil)
  highlight("StatusLineLspSep", c.lightgrey[1], nil, c.lightgrey[2], nil, nil, nil)
end

-- Providers {{{1

-- Vim mode {{{2
local current_mode_label = setmetatable({
    ["n"]  = "NORMAL";
    ["no"] = "NORMAL-OP";
    ["v"]  = "VISUAL";
    ["V"]  = "VISUAL-L";
    [""] = "VISUAL-B";
    ["s"]  = "SELECT";
    ["S"]  = "SELECT-L";
    [""] = "SELECT-B";
    ["i"]  = "INSERT";
    ["ic"] = "INSERT";
    ["ix"] = "INSERT";
    ["R"]  = "REPLACE";
    ["Rv"] = "V-REPLACE";
    ["c"]  = "COMMAND";
    ["cv"] = "VIM EX";
    ["ce"] = "EX";
    ["r"]  = "PROMPT";
    ["rm"] = "MORE";
    ["r?"] = "CONFIRM";
    ["!"]  = "SHELL";
    ["t"]  = "TERMINAL";
  }, {
    -- fix wired issues
    __index = function(_, _)
      return "V-BLOCK"
    end
  })

local current_mode_hi_groups = setmetatable({
    ["n"]  = "Normal";
    ["i"]  = "Insert";
    ["v"]  = "Visual";
    ["V"]  = "Visual";
    [""] = "Visual";
    ["R"]  = "Replace";
    ["Rv"] = "Replace";
    ["c"]  = "Command";
  }, {
    __index = function(_, _)
      return "Normal"
    end
  })

local function vim_mode(inactive)
  local mode = vim.api.nvim_get_mode()['mode']
  local mode_label = current_mode_label[mode]
  local mode_hi = inactive and "Inactive" or current_mode_hi_groups[mode]
  local s = "%#StatusLine" .. mode_hi .. "Sep#" .. separator.left
  s = s .. "%#StatusLine" .. mode_hi .. "#" .. mode_label
  s = s .. "%#StatusLine" .. mode_hi .. "Sep#" .. separator.right
  return s
end

-- File info

local function file_readonly()
  if vim.bo.buftype == "terminal" then
    return ""
  end
  local ft = vim.bo.filetype
  if ft == "help" then
    return " "
  elseif vim.bo.readonly then
    return " "
  else
    return ""
  end
end

local function file_modified()
  if vim.bo.buftype == "terminal" then
    return ""
  end
  if vim.tbl_contains({"help", "denite", "fzf", "tagbar"}, vim.bo.filetype) then
    return ""
  end
  return vim.bo.modified and "  " or (vim.bo.modifiable and "" or " - ")
end

local function get_file_name()
  if vim.bo.buftype == "terminal" then
    local title = vim.api.nvim_buf_get_var(0, "term_title")
    local pid   = vim.api.nvim_buf_get_var(0, "terminal_job_pid")
    return string.format(" %s (%s) ", title, pid);
  end

  local ft_lean = { "tagbar", "vista", "defx", "coc-explorer", "magit" }
  local ft = vim.bo.filetype
  if vim.tbl_contains(ft_lean, ft) then
    return " "
  end

  local fname = vim.fn.expand("%")
  if fname == "" then
    return " [No Name] "
  end

  return fname
end

local function get_file_size()
  local file = vim.fn.expand('%:p')
  if string.len(file) == 0 then
    return ""
  end

  -- Format file size
  local size = vim.fn.getfsize(file)
  if size == 0 or size == -1 or size == -2 then
    return ""
  end
  local kb = 1024
  local mb = 1024 * 1024
  local gb = 1024 * 1024 * 1024
  if size < kb then
    size = size .. "b "
  elseif size < mb then
    size = string.format('%.1f%s', size / kb, "k ")
  elseif size < gb then
    size = string.format('%.1f%s', size / mb, "m ")
  else
    size = string.format('%.1f%s', size / gb, "g ")
  end

  return size
end

local function get_file_encoding_and_format()
  if vim.api.nvim_win_get_width(0) < 80 then
    return ""
  end
  local fenc = vim.bo.fileencoding
  if fenc == "" then
    fenc = vim.o.encoding
  end
  return string.format(" %s", fenc)
end

local function get_file_format()
  -- if vim.api.nvim_win_get_width(0) < 80 then
  --   return ""
  -- end
  local ff = vim.bo.fileformat
  local icon = icons.fileformat_icons[ff]
  return string.format(" %s %s ", icon, ff)
end

local function get_file_icon()
  local ft = vim.bo.filetype
  local fname = vim.fn.expand("%:t")
  return #ft ~= 0 and icons.filetype_icons[fname] .. " " .. ft or "no ft"
end

local function get_file_path(inactive)
  local name = get_file_name()
  local size = get_file_size()
end

local function get_line_colmun_info(inactive)
  local hi_lincol  = inactive and "Inactive" or "LinCol"
  local hi_percent = inactive and "Inactive" or "Percent"
  local s = "%#StatusLine" .. hi_lincol .. "Sep#" .. separator.left
  s = s .. "%#StatusLine" .. hi_lincol .. "# %3l %-2v "
  s = s .. "%#StatusLine" .. hi_percent .. "# %P "
  s = s .. "%#StatusLine" .. hi_percent .. "Sep#" .. separator.right;
  return s
end

local function get_git_branch(inactive)
  if not inactive then
    local icon = ''
    local bufnr = vim.api.nvim_get_current_buf()
    local ok, branch = pcall(vim.api.nvim_buf_get_var, bufnr, "gitsigns_head")
    if ok then
      local s = "%#StatusLineVCSSep#" .. separator.left
      s = s .. "%#StatusLineVCS#" .. string.format("%s %s ", icon, branch)
      s = s .. "%#StatusLineVCSSep#" .. separator.right
      return s
    end
  end
  return ""
end

local function get_lsp_status(inactive)
  if not inactive then
    if #vim.lsp.buf_get_clients() > 0 then
      local stat = require'lsp-status'.status()
      local s = "%#StatusLineLspSep#" .. separator.left
      s = s .. "%#StatusLineLsp#" .. stat
      s = s .. "%#StatusLineLspSep#" .. separator.right
      return s
    end
  end
  return ""
end

local function make_statusline(inactive)
  inactive = inactive or false
  local space = "%#StatusLineBase# "
  local s = space
  s = s .. vim_mode(inactive)
  s = s .. space
  s = s .. get_git_branch(inactive)
  s = s .. space
  s = s .. "%="
  s = s .. get_line_colmun_info(inactive)
  s = s .. space
  s = s .. get_lsp_status(inactive)
  s = s .. space
  return s
end

function M.statusline_active()
  return make_statusline(false)
end

function M.statusline_inactive()
  return make_statusline(true)
end

return M

