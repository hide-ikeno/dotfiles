local icons = require("devicons")
local git = require("git")

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

local theme = {}

theme["edge_dark_default"] = {
  fg      = { "#c5cdd9", 250 };
  bg      = { "#2c2e34", 235 };
  bg_alt  = { "#363944", 237 };
  bg_grey = { "#414550", 238 };
  red     = { "#ec7279", 203 };
  purple  = { "#d38aea", 176 };
  yellow  = { "#deb974", 179 };
  green   = { "#a0c980", 107 };
  blue    = { "#6cb6eb", 110 };
  cyan    = { "#5dbbc1", 72  };
}

theme["edge_dark_aura"] = {
  fg      = { "#c5cdd9", 250 };
  bg      = { "#2b2d37", 235 };
  bg_alt  = { "#363a49", 237 };
  bg_grey = { "#404455", 238 };
  red     = { "#ec7279", 203 };
  purple  = { "#d38aea", 176 };
  yellow  = { "#deb974", 179 };
  green   = { "#a0c980", 107 };
  blue    = { "#6cb6eb", 110 };
  cyan    = { "#5dbbc1", 72  };
}

theme["edge_dark_neon"] = {
  fg      = { "#c5cdd9", 250 };
  bg      = { "#2b2d3a", 235 };
  bg_alt  = { "#363a4e", 237 };
  bg_grey = { "#3f445b", 238 };
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
function M.apply_theme(theme_name)
  local c = theme[theme_name]
  highlight("StatusLineModeNormal",  c.bg_grey[1], c.green[1],  c.bg_grey[2], c.green[2],  "bold", nil)
  highlight("StatusLineModeInsert",  c.bg_grey[1], c.blue[1],   c.bg_grey[2], c.blue[2],   "bold", nil)
  highlight("StatusLineModeVisual",  c.bg_grey[1], c.purple[1], c.bg_grey[2], c.purple[2], "bold", nil)
  highlight("StatusLineModeReplace", c.bg_grey[1], c.red[1],    c.bg_grey[2], c.red[2],    "bold", nil)
  highlight("StatusLineModeCommand", c.bg_grey[1], c.yellow[1], c.bg_grey[2], c.yellow[2], "bold", nil)

  highlight("StatusLineModeSepNormal",  c.green[1],  nil, c.green[2],  nil, nil, nil)
  highlight("StatusLineModeSepInsert",  c.blue[1],   nil, c.blue[2],   nil, nil, nil)
  highlight("StatusLineModeSepVisual",  c.purple[1], nil, c.purple[2], nil, nil, nil)
  highlight("StatusLineModeSepReplace", c.red[1],    nil, c.red[2],    nil, nil, nil)
  highlight("StatusLineModeSepCommand", c.yellow[1], nil, c.yellow[2], nil, nil, nil)

  highlight("StatusLineFileName",   c.fg[1],     c.bg_grey[1], c.fg[2],     c.bg_grey[2], nil, nil)
  highlight("StatusLineFileType",   c.blue[1],   c.bg_alt[1],  c.blue[2],   c.bg_alt[2],  nil, nil)
  highlight("StatusLineFileFormat", c.fg[1],     c.bg_alt[1],  c.fg[2],     c.bg_alt[2],  nil, nil)
  highlight("StatusLineVCS",        c.purple[1], c.bg_alt[1],  c.purple[2], c.bg_alt[2],  nil, nil)
  highlight("StatusLineLinCol",     c.fg[1],     c.bg_alt[1],  c.fg[2],     c.bg_alt[2],  nil, nil)
  highlight("StatusLineLspStatus",  c.fg[1],     c.bg_grey[1], c.fg[2],     c.bg_grey[2], nil, nil)

  highlight("StatusLineSep1", c.bg_grey[1], nil, c.bg_grey[2], nil, nil, nil)
  highlight("StatusLineSep2", c.bg_alt[1],  nil, c.bg_alt[2],  nil, nil, nil)
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
  return string.format("%s %s %s", ro, fname, mo)
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

local function statusline_git_info(path)
  local branch_sign = ''
  local git_info = git.info(path)
  if not git_info or git_info.branch == '' then
    return ''
  end
  -- local changes  = git_info.stats
  -- local added    = changes.added > 0 and ('+' .. changes.added .. ' ') or ''
  -- local modified = changes.modified > 0 and ('~' .. changes.modified .. ' ') or ''
  -- local removed  = changes.removed > 0 and ('-' .. changes.removed) or ''
  -- local pad      = ((added ~= '') or (removed ~= '') or (modified ~= '')) and ' ' or ''
  -- local diff_str = string.format('%s%s%s%s', added, removed, modified, pad)
  -- return string.format('%s%s %s ', diff_str, branch_sign, git_info.branch)
  return string.format("%s %s ", branch_sign, git_info.branch)
end

local function statusline_lsp_status()
  if #vim.lsp.buf_get_clients() > 0 then
    return require'lsp-status'.status()
  end
  return ""
end

function M.statusline_active()
  local mode = vim.api.nvim_get_mode()['mode']
  local mode_label = current_mode_label[mode]
  local mode_hi = current_mode_hi_groups[mode]

  local s = "%#StatusLineModeSep" .. mode_hi .. "#" .. separator.left
  s = s .. "%#StatusLineMode"    .. mode_hi .. "#" .. mode_label
  s = s .. "%#StatusLineModeSep" .. mode_hi .. "#" .. separator.right

  local filename = statusline_filename()
  s = s .. "%#StatusLineSep1#" .. separator.left
  s = s .. "%#StatusLineFileName#" .. filename
  s = s .. "%#StatusLineSep1#" .. separator.right

  -- local branch = statusline_gitbranch()
  -- if #branch > 0 then
  --   s = s .. "%#StatusLineSep2#" .. separator.left
  --   s = s .. "%#StatusLineVCS#" .. branch
  --   s = s .. "%#StatusLineSep2#" .. separator.right
  -- end
  local buf_name = vim.fn.bufname()
  local buf_path = vim.fn.resolve(vim.fn.fnamemodify(buf_name, ":p"))
  local vcs = statusline_git_info(buf_path)
  if #vcs > 0 then
    s = s .. "%#StatusLineSep2#" .. separator.left
    s = s .. "%#StatusLineVCS#" .. vcs
    s = s .. "%#StatusLineSep2#" .. separator.right
  end

  s = s .. "%="

  local width = vim.api.nvim_win_get_width(0)
  if width > 80 then
    local ft = statusline_filetype()
    s = s .. "%#StatusLineSep2#" .. separator.left
    s = s .. "%#StatusLineFileType#" .. ft
    s = s .. "%#StatusLineSep2#" .. separator.right
    if width > 100 then
      local fenc = statusline_fileencoding()
      local ff = statusline_fileformat()
      s = s .. "%#StatusLineSep2#" .. separator.left
      s = s .. "%#StatusLineFileFormat#" .. fenc .. ff
      s = s .. "%#StatusLineSep2#" .. separator.right
    end
  end

  s = s .. "%#StatusLineSep2#" .. separator.left;
  s = s .. "%#StatusLineLinCol# %3l %-2v (%P) %#StatusLineSep2#";
  s = s .. "%#StatusLineSep2#" .. separator.right;

  local lsp_status = statusline_lsp_status()
  if #lsp_status > 0 then
    s = s .. "%#StatusLineSep1#" .. separator.left;
    s = s .. "%#StatusLineLspStatus# " .. lsp_status;
    s = s .. "%#StatusLineSep1#" .. separator.right;
  end

  return s
end

function M.statusline_inactive()
  return "%#StatusLineNC#  %n: %f"
end

function M.statusline_defx()
  return "%  %n: Defx"
end

return M


