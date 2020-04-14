local vim = vim or {}
local icons = require("devicons")

local M = {}

-- Separators
local separator = {
  left  = "";
  right = "";
  sub_left  = "";
  sub_right = "";
}

-- -- Colors
-- local colors = {
--   -- iceberg color theme
--   base     = {"#3e445e", "#0f1117", 238, 233};
--   edge     = {"#17171b", "#818596", 234, 245};
--   gradient = {"#6b7089", "#2e313f", 242, 236};
--   nc       = {"#3e445e", "#0f1117", 238, 233};
--   normal   = {"#161821", "#b4be82", 234, 150};
--   error    = {"#161821", "#e27878", 234, 203};
--   warning  = {"#161821", "#e2a478", 234, 216};
--   insert   = {"#161821", "#84a0c6", 234, 110};
--   replace  = {"#161821", "#e2a478", 234, 216};
--   visual   = {"#161821", "#a093c7", 234, 140};
--   misc     = {"#17171b", "#818596", 234, 245};
--   tabfill  = {"#3e445e", "#0f1117", 238, 233};
--   tabsel   = {"#17171b", "#818596", 234, 245};
-- }

local colors = {
  fg      = { "#c5cdd9", 250 };
  bg      = { "#2b2d37", 235 };
  bg_alt  = { "#2f323e", 236 };
  bg_grey = { "#404455", 238 };
  red     = { "#ec7279", 203 };
  purple  = { "#d38aea", 176 };
  yellow  = { "#deb974", 179 };
  green   = { "#a0c980", 107 };
  blue    = { "#6cb6eb", 110 };
  cyan    = { "#5dbbc1", 72  };
}

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


-- Mode colors
function M.apply_theme()
  local c = colors
  highlight("SL_ModeNormal",  c.bg_grey[1], c.green[1],  c.bg_grey[2], c.green[2],  "bold", nil)
  highlight("SL_ModeInsert",  c.bg_grey[1], c.blue[1],   c.bg_grey[2], c.blue[2],   "bold", nil)
  highlight("SL_ModeVisual",  c.bg_grey[1], c.purple[1], c.bg_grey[2], c.purple[2], "bold", nil)
  highlight("SL_ModeReplace", c.bg_grey[1], c.red[1],    c.bg_grey[2], c.red[2],    "bold", nil)
  highlight("SL_ModeCommand", c.bg_grey[1], c.yellow[1], c.bg_grey[2], c.yellow[2], "bold", nil)

  highlight("SL_ModeSepNormal",  c.green[1],  nil, c.green[2],  nil, nil, nil)
  highlight("SL_ModeSepInsert",  c.blue[1],   nil, c.blue[2],   nil, nil, nil)
  highlight("SL_ModeSepVisual",  c.purple[1], nil, c.purple[2], nil, nil, nil)
  highlight("SL_ModeSepReplace", c.red[1],    nil, c.red[2],    nil, nil, nil)
  highlight("SL_ModeSepCommand", c.yellow[1], nil, c.yellow[2], nil, nil, nil)

  highlight("SL_FileName",   c.fg[1],     c.bg_grey[1], c.fg[2],     c.bg_grey[2], nil, nil)
  highlight("SL_FileType",   c.blue[1],   c.bg_alt[1],  c.blue[2],   c.bg_alt[2],  nil, nil)
  highlight("SL_FileFormat", c.fg[1],     c.bg_alt[1],  c.fg[2],     c.bg_alt[2],  nil, nil)
  highlight("SL_GitBranch",  c.purple[1], c.bg_alt[1],  c.purple[2], c.bg_alt[2],  nil, nil)
  highlight("SL_LinCol",     c.fg[1],     c.bg_alt[1],  c.fg[2],     c.bg_alt[2],  nil, nil)

  highlight("SL_Sep1", c.bg_grey[1], nil, c.bg_grey[2], nil, nil, nil)
  highlight("SL_Sep2", c.bg_alt[1],  nil, c.bg_alt[2],  nil, nil, nil)
end


local function statusline_readonly()
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


local function statusline_modified()
  if vim.bo.buftype == "terminal" then
    return ""
  end
  if vim.tbl_contains({"help", "denite", "fzf", "tagbar"}, vim.bo.filetype) then
    return ""
  end
  return vim.bo.modified and "  " or (vim.bo.modifiable and "" or " - ")
end


-- local function statusline_filepath()
--   if vim.bo.buftype == "terminal" then
--     return ""
--   end
--
--   local ft = vim.bo.filetype
--   if vim.tbl_contains({"vista", "denite-filter", "tagbar"}, ft) then
--     return ""
--   end
--   if ft == "denite" then
--     return vim.fn["denite#get_status"]("input")
--   end
--
--   local ro = statusline_readonly()
--   local width = vim.api.nvim_win_get_width(0)
--   local saved_shellslash
--   if vim.fn.exists("+shellslash") then
--     saved_shellslash = vim.o.shellslash
--     vim.o.shellslash = true
--   end
--   local path_str = vim.fn.expand("%:h")
--   path_str = string.gsub(path_str, vim.fn.expand("$HOME"))
--   if width < 120 and #path_str > 30 then
--     path_str = vim.fn.substitute(path_str, [[\v([^/])[^/]*%(/)@=]], "\\1", "g")
--   end
--   if vim.fn.exists("+shellslash") then
--     vim.o.shellslash = saved_shellslash
--   end
--
--   return ro .. path_str
-- end
--

local function statusline_gitbranch()
  local branch = vim.fn["gitbranch#name"]()
  -- local branch = utils.os.capture("git rev-parse --abbrev-ref HEAD 2>/dev/null")
  -- branch = vim.trim(branch)
  return branch == "" and "" or " " .. branch
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

  local fname = vim.fn.expand("%")
  if fname == "" then
    return " [No Name] "
  end

  local ro = statusline_readonly()
  local mo = statusline_modified()
  return string.format("%s%s %s", ro, fname, mo)
end


local function statusline_filetype()
  local ft = vim.bo.filetype
  local fname = vim.fn.expand("%:t")
  return #ft ~= 0 and icons.filetype_icons[fname] .. " " .. ft or "no ft"
end

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

function M.statusline_active()
  local mode = vim.api.nvim_get_mode()['mode']
  local mode_label = current_mode_label[mode]
  local mode_hi = current_mode_hi_groups[mode]

  local s = "%#SL_ModeSep" .. mode_hi .. "#" .. separator.left
  s = s .. "%#SL_Mode"    .. mode_hi .. "#" .. mode_label
  s = s .. "%#SL_ModeSep" .. mode_hi .. "#" .. separator.right

  local filename = statusline_filename()
  s = s .. "%#SL_Sep1#" .. separator.left
  s = s .. "%#SL_FileName#" .. filename
  s = s .. "%#SL_Sep1#" .. separator.right

  local branch = statusline_gitbranch()
  if #branch > 0 then
    s = s .. "%#SL_Sep2#" .. separator.left
    s = s .. "%#SL_GitBranch#" .. branch
    s = s .. "%#SL_Sep2#" .. separator.right
  end

  s = s .. "%="

  local width = vim.api.nvim_win_get_width(0)
  if width > 80 then
    local ft = statusline_filetype()
    s = s .. "%#SL_Sep2#" .. separator.left
    s = s .. "%#SL_FileType#" .. ft
    s = s .. "%#SL_Sep2#" .. separator.right
    if width > 100 then
      local fenc = statusline_fileencoding()
      local ff = statusline_fileformat()
      s = s .. "%#SL_Sep2#" .. separator.left
      s = s .. "%#SL_FileFormat#" .. fenc .. ff
      s = s .. "%#SL_Sep2#" .. separator.right
    end
  end

  s = s .. "%#SL_Sep2#" .. separator.left;
  s = s .. "%#SL_LinCol# %3l %-2v (%P) %#SL_Sep2#";
  s = s .. "%#SL_Sep2#" .. separator.right;

  return s
end

function M.statusline_inactive()
  return "%#StatusLineNC#  %n: %f"
end

function M.statusline_defx()
  return "%  %n: Defx"
end

return M


