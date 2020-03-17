local vim = vim or {}
local utils = require("vimrc_utils")
local icons = require("devicons")
local M = {}

-- Separators
local separator = {
  -- left  = "";
  -- right = "";
  left  = "";
  right = "";
  sub_left  = "";
  sub_right = "";
  edge  = "";
}

-- -- Colors
local colors = {
  -- iceberg color theme
  base     = {"#3e445e", "#0f1117", 238, 233};
  edge     = {"#17171b", "#818596", 234, 245};
  gradient = {"#6b7089", "#2e313f", 242, 236};
  nc       = {"#3e445e", "#0f1117", 238, 233};
  normal   = {"#161821", "#b4be82", 234, 150};
  error    = {"#161821", "#e27878", 234, 203};
  warning  = {"#161821", "#e2a478", 234, 216};
  insert   = {"#161821", "#84a0c6", 234, 110};
  replace  = {"#161821", "#e2a478", 234, 216};
  visual   = {"#161821", "#a093c7", 234, 140};
  misc     = {"#17171b", "#818596", 234, 245};
  tabfill  = {"#3e445e", "#0f1117", 238, 233};
  tabsel   = {"#17171b", "#818596", 234, 245};
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
  vim.api.nvim_command('highlight '..table.concat(parts, ' '))
end

-------------------------------------------------------------------------------
-- Statusline
-------------------------------------------------------------------------------

-- Mode colors
highlight("StatusLineModeNormal", colors.normal[1], colors.normal[2], colors.normal[3], colors.normal[4], nil, nil)
highlight("StatusLineModeNormalSep", colors.normal[2], nil, colors.normal[4], nil, nil, nil)
highlight("StatusLineModeInsert", colors.insert[1], colors.insert[2], colors.insert[3], colors.insert[4], nil, nil)
highlight("StatusLineModeInsertSep", colors.insert[2], nil, colors.insert[4], nil, nil, nil)
highlight("StatusLineModeVisual", colors.visual[1], colors.visual[2], colors.visual[3], colors.visual[4], nil, nil)
highlight("StatusLineModeVisualSep", colors.visual[2], nil, colors.visual[4], nil, nil, nil)
highlight("StatusLineModeReplace", colors.replace[1], colors.replace[2], colors.replace[3], colors.replace[4], nil, nil)
highlight("StatusLineModeReplaceSep", colors.replace[2], nil, colors.replace[4], nil, nil, nil)
highlight("StatusLineModeMisc", colors.misc[1], colors.misc[2], colors.misc[3], colors.misc[4], nil, nil)
highlight("StatusLineModeMiscSep", colors.misc[2], nil, colors.misc[4], nil, nil, nil)

-- Gradient color
highlight("StatusLineGradient", colors.gradient[1], colors.gradient[2], colors.gradient[3], colors.gradient[4], nil, nil)
highlight("StatusLineGradientSep", colors.gradient[2], nil, colors.gradient[4], nil, nil, nil)

-- Base color
highlight("StatusLineBase", colors.base[1], colors.base[2], colors.base[3], colors.base[4], nil, nil)
highlight("StatusLineBaseSep", colors.base[2], nil, colors.base[4], nil, nil, nil)

-- Edge color
highlight("StatusLineEdge", colors.edge[1], colors.edge[2], colors.edge[3], colors.edge[4], nil, nil)
highlight("StatusLineEdgeSep", colors.edge[2], nil, colors.edge[4], nil, nil, nil)

-- NC color
highlight("StatusLineBaseNC", colors.nc[1], colors.nc[2], colors.nc[3], colors.nc[4], nil, nil)
highlight("StatusLineBaseNCSep", colors.nc[2], nil, colors.nc[4], nil, nil, nil)

-- Mode hightlight
local current_mode_label = setmetatable({
    ["n"]  = " NORMAL ";
    ["no"] = " N-Operator Pending ";
    ["v"]  = " VISUAL ";
    ["V"]  = " V-Line ";
    [""] = " V-Block ";
    ["s"]  = " SELECT ";
    ["S"]  = " S-Line ";
    [""] = " S-Block ";
    ["i"]  = " INSERT ";
    ["ic"] = " INSERT ";
    ["ix"] = " INSERT ";
    ["R"]  = " REPLACE ";
    ["Rv"] = " V-REPLACE ";
    ["c"]  = " COMMAND ";
    ["cv"] = " Vim Ex ";
    ["ce"] = " Ex ";
    ["r"]  = " Prompt ";
    ["rm"] = " More ";
    ["r?"] = " Confirm ";
    ["!"]  = " Shell ";
    ["t"]  = " TERMINAL ";
  }, {
    -- fix wired issues
    __index = function(_, _)
      return "V-BLOCK"
    end
  })

local current_mode_hi_groups = setmetatable({
    ["n"]  = {"Normal",  "NormalSep"};
    ["i"]  = {"Insert",  "InsertSep"};
    ["v"]  = {"Visual",  "VisualSep"};
    ["V"]  = {"Visual",  "VisualSep"};
    [""] = {"Visual",  "VisualSep"};
    ["R"]  = {"Replace", "ReplaceSep"};
    ["Rv"] = {"Replace", "ReplaceSep"};
  }, {
    __index = function(_, _)
      return {"Misc", "MiscSep"}
    end
  })

local function statusline_mode()
  local ft = vim.fn.filetype
  if ft == "denite" then
    return " Denite "
  elseif ft == "defx" then
    return " Defx "
  end

  local mode = vim.fn.mode()
  -- redraw_mode_color(mode)
  return current_mode_label[mode]
end


local function statusline_readonly()
  local ft = vim.bo.filetype
  if ft ~= "help" and vim.bo.readonly then
    return " "
  else
    return ""
  end
end


local function statusline_modified()
  return vim.bo.modified and "  " or (vim.bo.modifiable and "" or " - ")
end


local function statusline_gitbranch()
  -- local branch = vim.fn["gitbranch#name"]()
  local branch = utils.os.capture("git rev-parse --abbrev-ref HEAD 2>/dev/null")
  branch = vim.trim(branch)
  return branch == "" and "-" or " " .. branch
end


local function statusline_filename()
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

  local fname = vim.fn.expand("%:t")
  if fname == "" then
    return " [No Name] "
  end

  local icon = #ft ~= 0 and icons.filetype_icons[fname] or "no ft"
  local ro = statusline_readonly()
  local mo = statusline_modified()
  return string.format(" %s %s%s %s", icon, ro, fname, mo)
end


-- local function statusline_filetype()
--   if vim.api.nvim_win_get_width(0) < 80 then
--     return ""
--   end
--   local ft = vim.ft.filetype
--   return #ft ~= 0 and vim.fn.WebDevIconsGetFileTypeSymbol() .. " " .. ft or "no ft"
-- end


local function statusline_fileformat()
  if vim.api.nvim_win_get_width(0) < 80 then
    return ""
  end
  local ff = vim.bo.fileformat
  local icon = icons.fileformat_icons[ff]
  return string.format(" %s %s ", icon, ff)
end


local function statusline_fileencoding()
  if vim.api.nvim_win_get_width(0) < 80 then
    return ""
  end
  local fenc = vim.bo.fileencoding
  if fenc == "" then
    fenc = vim.o.encoding
  end
  return string.format(" %s", fenc)
end


-- Build the string for statusline
function M.activeLine()
  local mode = vim.api.nvim_get_mode()['mode']
  local mode_label = current_mode_label[mode]
  local mode_hi = current_mode_hi_groups[mode]
  local filename = statusline_filename()
  local branch = statusline_gitbranch()
  local fenc = statusline_fileencoding()
  local ff = statusline_fileformat()
  local parts = {
    --[[ Left segment ]]
    -- current mode
    "%#StatusLineMode".. mode_hi[2] .. "#" .. separator.left;
    "%#StatusLineMode".. mode_hi[1] .. "#" .. mode_label;
    "%#StatusLineMode".. mode_hi[2] .. "#" .. separator.right;
    -- filename
    " %#StatusLineGradientSep#" .. separator.left;
    "%#StatusLineGradient#" .. filename;
    "%#StatusLineGradientSep#" .. separator.right;
    -- git branch
    " %#StatusLineBaseSep#" .. separator.left;
    "%#StatusLineBase# " .. branch;
    " %#StatusLineBaseSep#" .. separator.right;
    "%=";
    --[[ Right segment ]]
    -- spell or paste mode
    " %#StatusLineBaseSep#" .. separator.left;
    "%#StatusLineBase#%{&paste ?' PASTE ':' '}%{&spell?' SPELL ':' '}";
    "%#StatusLineBaseSep#" .. separator.right;
    " %#StatusLineGradientSep#" .. separator.left;
    "%#StatusLineGradient#" .. fenc .. " " .. ff;
    "%#StatusLineGradientSep#" .. separator.right;
    " %#StatusLineEdgeSep#" .. separator.left;
    "%#StatusLineEdge#  %3l  %-2v (%P) " .. separator.edge;
    "%#StatusLineEdgeSep#" .. separator.right;
  }
  return table.concat(parts, "")
end

function M.inActiveLine()
  return "%#StatusLineBaseNC#  %n: %f"
end

function M.defxLine()
  return "%  %n: Defx"
end

-------------------------------------------------------------------------------
-- Tabline
-------------------------------------------------------------------------------

-- -- https://github.com/haorenW1025/dotfiles/blob/130dbf80e73e71cc8f6b89066f536417f455b088/nvim/lua/status-line.lua
-- local function get_tab_label(n)
--   local current_win = vim.api.nvim_tabpage_get_win(n)
--   local current_buf = vim.api.nvim_win_get_buf(current_win)
--   local filename = vim.api.nvim_buf_get_name(current_buf)
--   if string.find(filename, 'term://') ~= nil then
--     return ' ' .. vim.api.nvim_call_function('fnamemodify', {filename, ":p:t"})
--   end
--   filename = vim.api.nvim_call_function('fnamemodify', {filename, ":p:t"})
--   if filename == '' then
--     return "No Name"
--   end
--   -- local icon = icons.deviconTable[filename]
--   local icon = vim.fn.WebDevIconsGetFileTypeSymbol(filename) or ""
--   if icon ~= nil then
--     return icon .. " " .. filename
--   end
--   return filename
-- end
--
-- -- Tabfill
-- highlight("TabLineSel", colors.tabsel[1], colors.tabsel[2], colors.tabsel[3], colors.tabsel[4], nil, nil)
-- highlight("TabLineSelSep", colors.tabsel[2], nil, colors.tabsel[4], nil, nil, nil)
--
-- -- Tabsel
-- highlight("TabLineFill", colors.tabfill[1], colors.tabfill[2], colors.tabfill[3], colors.tabfill[4], nil, nil)
-- highlight("TabLineFillSep", colors.tabfill[2], nil, colors.tabfill[4], nil, nil, nil)
--
-- function M.TabLine()
--   local tabline = ''
--   local tab_list = vim.api.nvim_list_tabpages()
--   local current_tab = vim.api.nvim_get_current_tabpage()
--   for _, val in ipairs(tab_list) do
--     local filename = get_tab_label(val)
--     if val == current_tab then
--       tabline = tabline.."%#TabLineSelSep# " .. separator.left
--       tabline = tabline.."%#TabLineSel# "    .. filename
--       tabline = tabline.." %#TabLineSelSep#" .. separator.right
--     else
--       tabline = tabline.."%#TabLineFillSep# " .. separator.left
--       tabline = tabline.."%#TabLine# "        .. filename
--       tabline = tabline.." %#TabLineFillSep#" .. separator.right
--     end
--   end
--   return tabline
-- end

return M

