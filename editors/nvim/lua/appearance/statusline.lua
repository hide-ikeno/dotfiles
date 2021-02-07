local M = {}

-- [[ Configurations ]]

-- Separators
local separator = {
  left  = "";
  right = "";
}

-- Colors
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

palette["sonokai_shusia"] = {
  black       = '#1a181a',
  bg0         = '#2d2a2e',
  bg1         = '#343136',
  bg2         = '#3b383e',
  bg3         = '#423f46',
  bg4         = '#49464e',
  bg_red      = '#ff6188',
  diff_red    = '#55393d',
  bg_green    = '#a9dc76',
  diff_green  = '#394634',
  bg_blue     = '#78dce8',
  diff_blue   = '#354157',
  diff_yellow = '#4e432f',
  fg          = '#e3e1e4',
  red         = '#f85e84',
  orange      = '#ef9062',
  yellow      = '#e5c463',
  green       = '#9ecd6f',
  blue        = '#7accd7',
  purple      = '#ab9df2',
  grey        = '#848089',
  none        = 'NONE',
}

-- local function highlight(group, guifg, guibg, ctermfg, ctermbg, attr, guisp)
local function highlight(group, guifg, guibg, attr, guisp)
  local parts = {group}
  if guifg then table.insert(parts, "guifg="..guifg) end
  if guibg then table.insert(parts, "guibg="..guibg) end
  -- if ctermfg then table.insert(parts, "ctermfg="..ctermfg) end
  -- if ctermbg then table.insert(parts, "ctermbg="..ctermbg) end
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
  highlight("StatusLineBase", c.grey, nil, nil, nil)

  -- Inactive
  highlight("StatusLineInactive",    c.fg,  c.bg2, nil, nil)
  highlight("StatusLineInactiveSep", c.bg2, nil,   nil, nil)

  -- Mode
  highlight("StatusLineNormal",  c.black, c.bg_green, "bold", nil)
  highlight("StatusLineInsert",  c.black, c.bg_blue,  "bold", nil)
  highlight("StatusLineVisual",  c.black, c.purple,   "bold", nil)
  highlight("StatusLineReplace", c.black, c.bg_red,   "bold", nil)
  highlight("StatusLineCommand", c.black, c.yellow,   "bold", nil)

  highlight("StatusLineNormalSep",  c.bg_green, nil, nil, nil)
  highlight("StatusLineInsertSep",  c.bg_blue,  nil, nil, nil)
  highlight("StatusLineVisualSep",  c.purple,   nil, nil, nil)
  highlight("StatusLineReplaceSep", c.bg_red,   nil, nil, nil)
  highlight("StatusLineCommandSep", c.yellow,   nil, nil, nil)

  -- VCS, diff
  highlight("StatusLineVCSBranch",    c.fg,     c.bg2, nil, nil)
  highlight("StatusLineVCSIcon",      c.orange, c.bg2, nil, nil)
  highlight("StatusLineDiffAdded",    c.green,  c.bg2, nil, nil)
  highlight("StatusLineDiffModified", c.blue,   c.bg2, nil, nil)
  highlight("StatusLineDiffRemoved",  c.red,    c.bg2, nil, nil)

  highlight("StatusLineVCSSep", c.bg2,    nil,   nil, nil)

  -- File info
  highlight("StatusLineFileType",    c.black, c.bg_blue, nil, nil)
  highlight("StatusLineFileTypeSep", c.bg_blue, nil, nil, nil)

  highlight("StatusLineFileFormat",    c.fg, c.bg4, nil, nil)
  highlight("StatusLineFileFormatSep", c.bg4, nil, nil, nil)

  highlight("StatusLineFileEncoding",    c.fg, c.bg2, nil, nil)
  highlight("StatusLineFileEncodingSep", c.bg2, nil, nil, nil)

  -- Line column info
  highlight("StatusLineLinCol",  c.fg, c.bg4, nil, nil)
  highlight("StatusLinePercent", c.fg, c.bg2, nil, nil)

  highlight("StatusLineLinColSep",  c.bg4, nil, nil, nil)
  highlight("StatusLinePercentSep", c.bg2, nil, nil, nil)

  -- -- LSP
  -- highlight("StatusLineLsp",    c.black[1], c.lightgrey[1], c.black[2], c.lightgrey[2], nil, nil)
  -- highlight("StatusLineLspSep", c.lightgrey[1], nil, c.lightgrey[2], nil, nil, nil)
end

-- [[ Providers ]]

-- Vim mode
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
  local label = current_mode_label[mode]
  local hl = inactive and "Inactive" or current_mode_hi_groups[mode]
  return string.format(
    "%%#StatusLine%sSep#%s%%#StatusLine%s#%s%%#StatusLine%sSep#%s",
    hl, separator.left, hl, label, hl, separator.right
  )
end

-- VCS info
local function get_git_info(inactive)
  if not inactive then
    local icon = {
      branch        = ' ',
      diff_added    = ' ',
      diff_removed  = ' ',
      diff_modified = ' ',
    }
    local bufnr = vim.api.nvim_get_current_buf()
    local ok, data = pcall(vim.api.nvim_buf_get_var, bufnr, "gitsigns_status_dict")
    if ok then
      local s = "%#StatusLineVCSSep#" .. separator.left
      s = s .. "%#StatusLineVCSIcon#" .. icon.branch
      s = s .. "%#StatusLineVCSBranch#" .. data.head
      if data.added ~= nil and data.added > 0 then
        s = s .. " %#StatusLineDiffAdded#" .. icon.diff_added .. data.added
      end
      if data.changed ~= nil and data.changed > 0 then
        s = s .. " %#StatusLineDiffModified#" .. icon.diff_modified .. data.changed
      end
      if data.removed ~= nil and data.removed > 0 then
        s = s .. " %#StatusLineDiffRemoved#" .. icon.diff_removed .. data.removed
      end
      s = s .. "%#StatusLineVCSSep#" .. separator.right
      return s
    end
  end
  return ""
end

-- File info

-- local function file_readonly()
--   if vim.bo.buftype == "terminal" then
--     return ""
--   end
--   local ft = vim.bo.filetype
--   if ft == "help" then
--     return " "
--   elseif vim.bo.readonly then
--     return " "
--   else
--     return ""
--   end
-- end
--
-- local function file_modified()
--   if vim.bo.buftype == "terminal" then
--     return ""
--   end
--   if vim.tbl_contains({"help", "denite", "fzf", "tagbar"}, vim.bo.filetype) then
--     return ""
--   end
--   return vim.bo.modified and "  " or (vim.bo.modifiable and "" or " - ")
-- end
--
-- local function get_file_name()
--   if vim.bo.buftype == "terminal" then
--     local title = vim.api.nvim_buf_get_var(0, "term_title")
--     local pid   = vim.api.nvim_buf_get_var(0, "terminal_job_pid")
--     return string.format(" %s (%s) ", title, pid);
--   end
--
--   local ft_lean = { "tagbar", "vista", "defx", "coc-explorer", "magit" }
--   local ft = vim.bo.filetype
--   if vim.tbl_contains(ft_lean, ft) then
--     return " "
--   end
--
--   local fname = vim.fn.expand("%")
--   if fname == "" then
--     return " [No Name] "
--   end
--
--   return fname
-- end
--
-- local function get_file_size()
--   local file = vim.fn.expand('%:p')
--   if string.len(file) == 0 then
--     return ""
--   end
--
--   -- Format file size
--   local size = vim.fn.getfsize(file)
--   if size == 0 or size == -1 or size == -2 then
--     return ""
--   end
--   local kb = 1024
--   local mb = 1024 * 1024
--   local gb = 1024 * 1024 * 1024
--   if size < kb then
--     size = size .. "b "
--   elseif size < mb then
--     size = string.format('%.1f%s', size / kb, "k ")
--   elseif size < gb then
--     size = string.format('%.1f%s', size / mb, "m ")
--   else
--     size = string.format('%.1f%s', size / gb, "g ")
--   end
--
--   return size
-- end
--
local function get_file_encoding_and_format(inactive)
  if inactive or vim.api.nvim_win_get_width(0) < 80 then
    return ""
  end
  local fenc = vim.bo.fileencoding
  if fenc == "" then
    fenc = vim.o.encoding
  end
  local ff = vim.bo.fileformat
  return string.format(
    "%%#StatusLineFileEncodingSep#%s%%#StatusLineFileEncoding#%s%%#StatusLineFileFormat#%s%%#StatusLineFileEncodingSep#%s",
    separator.left, fenc, ff, separator.right
  )
end

-- local function get_file_format()
--   -- if vim.api.nvim_win_get_width(0) < 80 then
--   --   return ""
--   -- end
--   local ff = vim.bo.fileformat
--   local icon = icons.fileformat_icons[ff]
--   return string.format(" %s %s ", icon, ff)
-- end
--
-- local function get_file_icon()
--   local ft = vim.bo.filetype
--   local fname = vim.fn.expand("%:t")
--   return #ft ~= 0 and icons.filetype_icons[fname] .. " " .. ft or "no ft"
-- end
--
local function get_filetype(inactive)
  local hl = inactive and "Inactive" or "FileType"
  local ft = vim.bo.filetype
  local icon
  if #ft == 0 then
    ft = "no ft"
    icon = ""
  else
    local ok, devicons = pcall(require, "nvim-web-devicons")
    if ok then
      local f_name = vim.fn.expand("%:t")
      local f_ext = vim.fn.expand("%:e")
      icon = devicons.get_icon(f_name, f_ext)
      if icon ~= nil then
        icon = icon .. " "
      else
        icon = ""
      end
    end
  end
  return string.format(
    "%%#StatusLine%sSep#%s%%#StatusLine%s#%s%s%%#StatusLine%sSep#%s",
    hl, separator.left, hl, icon, ft, hl, separator.right
  )
end

local function get_line_colmun_info(inactive)
  local hl_lincol  = inactive and "Inactive" or "LinCol"
  local hl_percent = inactive and "Inactive" or "Percent"
  return string.format(
    "%%#StatusLine%sSep#%s%%#StatusLine%s#%%3l %%-2v %%#StatusLine%s# %%P%%#StatusLine%sSep#%s",
    hl_lincol, separator.left, hl_lincol, hl_percent, hl_percent, separator.right
  )
end

-- Git branch
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
  -- local s = inactive and "Inactive..." or "Active!"
  local space = "%#StatusLineBase# "
  local s = space
  s = s .. vim_mode(inactive)
  s = s .. space
  s = s .. get_git_info(inactive)
  s = s .. space
  s = s .. "%="
  s = s .. get_filetype(inactive)
  s = s .. space
  s = s .. get_file_encoding_and_format(inactive)
  s = s .. space
  s = s .. get_line_colmun_info(inactive)
  s = s .. space
  -- s = s .. get_lsp_status(inactive)
  -- s = s .. space
  return s
end

function M.statusline_active()
  return make_statusline(false)
end

function M.statusline_inactive()
  return make_statusline(true)
end

return M

