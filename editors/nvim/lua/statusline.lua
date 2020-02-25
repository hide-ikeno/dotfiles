-- Statusline colors
local vim = vim or {}
local tools = require("tools")

local current_mode_label = {
  ["n"]  = " NORMAL ";
  ["no"] = " N-OP ";
  ["v"]  = " VISUAL ";
  ["V"]  = " V-LINE ";
  [""] = " V-BLOCK ";
  ["s"]  = " SELECT ";
  ["S"]  = " S-LINE ";
  [""] = " S-BLOCK ";
  ["i"]  = " INSERT ";
  ["R"]  = " REPLACE ";
  ["Rv"] = " V-REPLACE ";
  ["c"]  = " COMMAND ";
  ["cv"] = " VIM EX ";
  ["ce"] = " EX ";
  ["r"]  = " PROMPT ";
  ["rm"] = " MORE ";
  ["r?"] = " CONFIRM ";
  ["!"]  = " SHELL ";
  ["t"]  = " TERMINAL ";
}

local current_mode_highlight_group = {
  ["n"]  = "SLModeNormal";
  ["i"]  = "SLModeInsert";
  ["v"]  = "SLModeVisual";
  ["V"]  = "SLModeVisual";
  [""] = "SLModeVisual";
  ["R"]  = "SLModeReplace";
}

local colors = {
  base     = {"#3e445e", "#0f1117", 238, 233};
  edge     = {"#17171b", "#818596", 234, 245};
  gradient = {"#6b7089", "#2e313f", 242, 236};
  nc       = {"#3e445e", "#0f1117", 238, 233};
  tabfill  = {"#3e445e", "#0f1117", 238, 233};
  error    = {"#161821", "#e27878", 234, 203};
  warning  = {"#161821", "#e2a478", 234, 216};
  normal   = {"#818596", "#161821", 245, 234};
  insert   = {"#84a0c6", "#161821", 110, 234};
  replace  = {"#e2a478", "#161821", 216, 234};
  visual   = {"#b4be82", "#161821", 150, 234};
}

setmetatable(current_mode_highlight_group, {
    __index = function () return "SLModeNormal" end
  })

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

function RedrawModeColors()
  local mode = vim.fn.mode()
  -- if mode == "n" then
  --   highlight("StatusLineModeBody", "#17171b", "#818596", 233,    245, nil, nil)
  --   highlight("StatusLineModeSep",  "#818596", "NONE",    245, "NONE", nil, nil)
  -- elseif mode == "i" then
  --   highlight("StatusLineModeBody", "#161821", "#84a0c6", 234,    110, nil, nil)
  --   highlight("StatusLineModeSep",  "#84a0c6", "NONE",    110, "NONE", nil, nil)
  -- elseif mode == "R" then
  --   highlight("StatusLineModeBody", "#161821", "#e2a478", 234,    216, nil, nil)
  --   highlight("StatusLineModeSep",  "#e2a478", "NONE",    216, "NONE", nil, nil)
  -- elseif mode == "v" or mode == "V" or mode == "" then
  --   highlight("StatusLineModeBody", "#161821", "#b4be82", 234,    150, nil, nil)
  --   highlight("StatusLineModeSep",  "#b4be82", "NONE",    150, "NONE", nil, nil)
  -- else
  --   highlight("StatusLineModeBody", "#17171b", "#3e445e", 233,    238, nil, nil)
  --   highlight("StatusLineModeSep",  "#3e445e", "NONE",    238, "NONE", nil, nil)
  -- end
  if mode == "n" then
    highlight("StatusLineMode", "#b4be82", "#2e313f", 233,    245, "bold", nil)
  elseif mode == "i" then
    highlight("StatusLineMode", "#84a0c6", "#2e313f", 234,    110, "bold", nil)
  elseif mode == "R" then
    highlight("StatusLineMode", "#e2a478", "#2e313f", 234,    216, "bold", nil)
  elseif mode == "v" or mode == "V" or mode == "" then
    highlight("StatusLineMode", "#ada0d3", "#2e313f", 234,    150, "bold", nil)
  else
    highlight("StatusLineMode", "#6b7089", "#2e313f", 233,    238, "bold", nil)
  end
  return ""
end

function StatuslineMode()
  local mode = vim.fn.mode()
  return current_mode_label[mode]
end

function SetFilename()
  local ft = vim.bo.filetype
  local ft_icon = "no ft"
  if #ft ~= 0 then
    ft_icon = " " .. vim.fn.WebDevIconsGetFileTypeSymbol()
  end
  readonly_icon = ""
  if vim.bo.readonly and ft ~= "help" then
    readonly_icon = " "
  end
  return table.concat({ ft_icon, readonly_icon, " %f " })
end

function StatuslineReadonly()
  if vim.bo.readonly then
    return " "
  else
    return ""
  end
end

function StatuslineModified()
  if vim.bo.modified then
    return "●"
  else
    return ""
  end
end

function StatuslineFiletype()
  local width = vim.api.nvim_win_get_width(0)
  if width <= 70 then
    return ""
  end
  local ft = vim.bo.filetype
  if #ft ~= 0 then
    return string.format(" %s %s ", vim.fn.WebDevIconsGetFileTypeSymbol(), ft)
  else
    return "no ft"
  end
end

function StatuslineFileformat()
  local width = vim.api.nvim_win_get_width(0)
  if width <= 70 then
    return ""
  end
  local ff = vim.bo.fileformat
  if ff then
    return string.format(" %s %s ", ff, vim.fn.WebDevIconsGetFileFormatSymbol())
  else
    return ""
  end
end

function StatuslineFileencoding()
  local width = vim.api.nvim_win_get_width(0)
  if width <= 70 then
    return ""
  end
  local fenc = vim.bo.filencoding
  if fenc ~= "" then
    return fenc
  else
    return vim.bo.encoding
  end
end


function StatuslineGitBranch()
  local branch = vim.fn["gitbranch#name"]()
  if branch ~= '' then
    return " " .. branch
  else
    return " - "
  end
end

-- set highlights
local function highlight_active()
  highlight("StatusLineBase",     "#c6c8d1", "NONE")
  highlight("StatusLineSep",      "#17171b", "NONE")
  highlight("StatusLineVCS",      "#ada0d3", "#17171b")
  highlight("StatusLineFilename", "#6b7089", "#17171b")
  highlight("StatusLineFiletype", "#3e445e", "#17171b")
  highlight("StatusLineLinCol",   "#6b7089", "#17171b")
end

local function highlight_inactive()
  highlight("StatusLineBaseNC",    colors.nc[1], colors.nc[2], colors.nc[3], colors.nc[4])
  highlight("StatusLineBaseSepNC", colors.nc[2], "NONE",       colors.nc[4], "NONE")
end

-- set statusline for active window
function SetStatusLineActive()
  highlight_active()

  -- Statusline colors
  -- hi Base guibg=NONE guifg=#929dcb
  -- hi Git guibg=#212333 guifg=#A37ACC
  -- hi LineCol guibg=#212333 guifg=#929dcb
  -- hi Mode guibg=#212333 guifg=#82b1ff
  -- hi Filetype guibg=#212333 guifg=#82b1ff
  -- hi PowerlineMode guibg=NONE guifg=#212333

  -- hi Modi guifg=#efefef guibg=#212333
  -- hi Filename guifg=#efefef guibg=#212333
  -- hi Modi guifg=#929dcb guibg=#212333
  -- hi Filename guifg=#929dcb guibg=#212333
  local parts = {
    "%{v:lua.RedrawModeColors()}";
    "%#StatusLineSep#";
    "%#StatusLineMode#%{v:lua.StatuslineMode()}";
    "%#StatusLineSep#";
    "%#StatusLineSep#";
    "%#StatusLineFilename# %f%{v:lua.StatuslineModified()} ";
    "%#StatusLineSep#";
    "%#StatusLineSep#";
    "%#StatusLineVCS# %{v:lua.StatuslineGitBranch()} ";
    "%#StatusLineSep#";
    "%=";
    "%#StatusLineSep#";
    "%#StatusLineFiletype# %{v:lua.StatuslineFiletype()} ";
    "%#StatusLineSep#";
    "%#StatusLineSep#";
    "%#StatusLineLinCol#  %l  %c ";
    "%#StatusLineSep#";
  }
  local winnr = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_option(winnr, "statusline", table.concat(parts, ""))
end

-- set statusline for inactive window
function SetStatusLineInactive()
  highlight_inactive()
  local parts = {
    "%#StatusLineBaseSepNC#";
    "%#StatusLineBaseNC# %F ";
    "%#StatusLineBaseSepNC#";
  }
  local winnr = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_option(winnr, "statusline", table.concat(parts, ""))
end

