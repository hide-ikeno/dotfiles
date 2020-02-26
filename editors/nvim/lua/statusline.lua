-- Statusline colors
local vim = vim or {}

local current_mode_label = {
  ["n"]  = "NORMAL ";
  ["no"] = "N-OP ";
  ["v"]  = "VISUAL ";
  ["V"]  = "V-LINE ";
  [""] = "V-BLOCK ";
  ["s"]  = "SELECT ";
  ["S"]  = "S-LINE ";
  [""] = "S-BLOCK ";
  ["i"]  = "INSERT ";
  ["R"]  = "REPLACE ";
  ["Rv"] = "V-REPLACE ";
  ["c"]  = "COMMAND ";
  ["cv"] = "VIM EX ";
  ["ce"] = "EX ";
  ["r"]  = "PROMPT ";
  ["rm"] = "MORE ";
  ["r?"] = "CONFIRM ";
  ["!"]  = "SHELL ";
  ["t"]  = "TERMINAL ";
}

local separator = {
  left  = "";
  right = "";
  sub_left  = "";
  sub_right = "";
  edge  = "";
}

local colors = {
  -- iceberg color theme
  base     = {"#3e445e", "#0f1117", 238, 233};
  edge     = {"#17171b", "#818596", 234, 245};
  gradient = {"#6b7089", "#2e313f", 242, 236};
  nc       = {"#3e445e", "#0f1117", 238, 233};
  normal   = {"#17171b", "#818596", 234, 245};
  error    = {"#161821", "#e27878", 234, 203};
  warning  = {"#161821", "#e2a478", 234, 216};
  insert   = {"#161821", "#84a0c6", 234, 110};
  replace  = {"#161821", "#e2a478", 234, 216};
  visual   = {"#161821", "#b4be82", 234, 150};
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


local function redraw_mode_color(mode)
  if mode == "i" then
    highlight("StatusLineMode", colors.insert[1], colors.insert[2], colors.insert[3], colors.insert[4], nil, nil)
    highlight("StatusLineModeSep", colors.insert[2], colors.gradient[2], colors.insert[4], colors.gradient[4], nil, nil)
  elseif mode == "R" then
    highlight("StatusLineMode", colors.replace[1], colors.replace[2], colors.replace[3], colors.replace[4], nil, nil)
    highlight("StatusLineModeSep", colors.replace[2], colors.gradient[2], colors.replace[4], colors.gradient[4], nil, nil)
  elseif mode == "v" or mode == "V" or mode == "" then
    highlight("StatusLineMode", colors.visual[1], colors.visual[2], colors.visual[3], colors.visual[4], nil, nil)
    highlight("StatusLineModeSep", colors.visual[2], colors.gradient[2], colors.visual[4], colors.gradient[4], nil, nil)
  else
    highlight("StatusLineMode", colors.normal[1], colors.normal[2], colors.normal[3], colors.normal[4], nil, nil)
    highlight("StatusLineModeSep", colors.normal[2], colors.gradient[2], colors.normal[4], colors.gradient[4], nil, nil)
  end
end


local function highlight_active()
  highlight("StatusLineBase", colors.base[1], colors.base[2], colors.base[3], colors.base[4], nil, nil)
  highlight("StatusLineGradient", colors.gradient[1], colors.gradient[2], colors.gradient[3], colors.gradient[4],  nil, nil)
  highlight("StatusLineEdge", colors.edge[1], colors.edge[2], colors.edge[3], colors.edge[4], nil, nil)

  highlight("StatusLineGradientSep", colors.gradient[2], colors.base[2], colors.gradient[4], colors.base[4], nil, nil)
  highlight("StatusLineEdgeSep", colors.edge[2], colors.gradient[2], colors.edge[4], colors.gradient[4], nil, nil)
end


local function highlight_inactive()
  highlight("StatusLineBaseNC", colors.nc[1],  colors.nc[2],  colors.nc[3],  colors.nc[4],  nil, nil)
end


function StatuslineMode()
  local ft = vim.fn.filetype
  if ft == "denite" then
    return " Denite "
  elseif ft == "defx" then
    return " Defx "
  end

  local mode = vim.fn.mode()
  redraw_mode_color(mode)
  return current_mode_label[mode]
end


function StatuslineReadonly()
  local ft = vim.bo.filetype
  if ft ~= "help" and vim.bo.readonly then
    return " "
  else
    return ""
  end
end


function StatuslineModified()
  return vim.bo.modified and "  " or (vim.bo.modifiable and "" or " - ")
end


function StatuslineGitbranch()
  local branch = vim.fn["gitbranch#name"]()
  return branch == "" and "" or "  "..branch
end


function StatuslineFilename()
  if vim.bo.buftype == "terminal" then
    local title = vim.api.nvim_buf_get_var(0, "term_title")
    local pid   = vim.api.nvim_buf_get_var(0, "terminal_job_pid")
    return string.format("%s (%s)", title, pid);
  end

  local ft_lean = { "tagbar", "vista", "defx", "coc-explorer", "magit" }
  local ft = vim.bo.filetype
  if vim.tbl_contains(ft_lean, ft) then
    return ""
  end

  local fname = vim.fn.expand("%:t")
  if fname == "" then
    return "[No Name]"
  end

  local icon = #ft ~= 0 and vim.fn.WebDevIconsGetFileTypeSymbol() or "no ft"
  local ro = StatuslineReadonly()
  local mo = StatuslineModified()
  return string.format("%s %s%s %s", icon, ro, fname, mo)
end


function StatuslineFiletype()
  if vim.api.nvim_win_get_width(0) < 80 then
    return ""
  end
  local ft = vim.ft.filetype
  return #ft ~= 0 and vim.fn.WebDevIconsGetFileTypeSymbol() .. " " .. ft or "no ft"
end


function StatuslineFileformat()
  if vim.api.nvim_win_get_width(0) < 80 then
    return ""
  end
  local ff = vim.bo.fileformat
  local icon = vim.fn.WebDevIconsGetFileFormatSymbol()
  return string.format("%s %s", icon, ff)
end


function StatuslineFileencoding()
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
function StatuslineActive()
  highlight_active()
  local parts = {
    -- Left segment
    "%#StatusLineMode# %{v:lua.StatuslineMode()}";
    "%#StatusLineModeSep#" .. separator.left;
    "%#StatusLineGradient# %{v:lua.StatuslineFilename()} ";
    "%#StatusLineGradientSep#" .. separator.left;
    "%#StatusLineBase# %{v:lua.StatuslineGitbranch()}";
    "%=";
    -- Right segment
    "%{&paste ?'PASTE ':''}%{&spell?'SPELL ':''}";
    "%#StatusLineGradientSep#" .. separator.right;
    "%#StatusLineGradient# %{v:lua.StatuslineFileencoding()} %{v:lua.StatuslineFileformat()} ";
    "%#StatusLineEdgeSep#" .. separator.right;
    "%#StatusLineEdge#  %3l  %-2v (%P) " .. separator.edge;
  }
  return table.concat(parts, "")
end


function StatuslineInactive()
  highlight_inactive()
  return "%#StatusLineBaseNC#  %n: %f"
end


function StatuslineDefx()
  return "%  %n: Defx"
end

