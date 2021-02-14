local M = {}

-- [[ Themes ]]
M.theme = "sonokai"
local theme_set = {}

-- [[ Components ]]
-- Separators
local separator = {
  left  = "";
  right = "";
}

-- Vi mode
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
  ["t"]  = "Terminal";
}, {
  __index = function(_, _)
    return "Normal"
  end
})

local function vi_mode(inactive)
  local mode = vim.api.nvim_get_mode()['mode']
  local label = current_mode_label[mode]
  local hl = inactive and "Inactive" or current_mode_hi_groups[mode]
  return string.format("%%#StatusLine%s# %s ", hl, label)
end

-- File info
local function file_readonly(inactive)
  if vim.bo.filetype == "help" then
    return ""
  end
  local hl = inactive and "Inactive" or "FileReadonly"
  if vim.bo.readonly then
    return string.format("%%#StatusLine%s# ", hl)
  else
    return ""
  end
end

local function file_modified(inactive)
  if vim.tbl_contains({"help", "denite", "fzf", "tagbar"}, vim.bo.filetype) then
    return ""
  end
  local hl = inactive and "Inactive" or "FileModified"
  if vim.bo.modifiable then
    if vim.bo.modified then
      return string.format("%%#StatusLine%s# ", hl)
    end
  end
  return ""
end

local function file_icon(inactive)
  local hl = inactive and "Inactive" or "FileIcon"
  local ft = vim.bo.filetype
  if #ft > 0 then
    local ok, devicons = pcall(require, "nvim-web-devicons")
    if ok then
      local f_name = vim.fn.expand("%:t")
      local f_ext = vim.fn.expand("%:e")
      local icon = devicons.get_icon(f_name, f_ext)
      if icon ~= nil then
        return string.format("%%#StatusLine%s# %s", hl, icon)
      elseif ft == "help" then
        return string.format("%%#StatusLine%s# ", hl)
      end
    end
  end
  return ""
end

local function file_size(inactive)
  local file = vim.fn.expand('%:p')
  if string.len(file) == 0 then
    return ""
  end
  -- Format file size
  local hl = inactive and "Inactive" or "FileSize"
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
  return string.format("%%#StatusLine%s# %s", hl, size)
end

local function file_name(inactive)
  local ft_lean = { "tagbar", "vista", "defx", "coc-explorer", "magit" }
  local ft = vim.bo.filetype
  if vim.tbl_contains(ft_lean, ft) then
    return " "
  end

  local hl = inactive and "Inactive" or "FileName"
  local name = vim.api.nvim_buf_get_name(0) -- full path
  if name == "" then
    name = "[No Name]"
  else
    name = vim.fn.fnamemodify(name, ":.") -- path relative to current directory
    if #name > 24 then
      name = vim.fn.pathshorten(name)
    end
  end

  return string.format("%%#StatusLine%s# %s ", hl, name)
end

local function file_encoding(inactive)
  local fenc = vim.bo.fileencoding
  if fenc == "" then
    fenc = vim.o.encoding
  end
  local hl = inactive and "Inactive" or "FileEncoding"
  return string.format("%%#StatusLine%s# %s", hl, fenc)
end

local function file_format(inactive)
  local ff = vim.bo.fileformat
  local hl = inactive and "Inactive" or "FileFormat"
  local icon
  if ff == "mac" then
    icon =' '
  elseif ff == "unix" then
    icon =' '
  elseif ff == "dos" then
    icon =' '
  end
  return string.format("%%#StatusLine%s# %s", hl, icon)
end

-- Lines/columns
local function line_colmun_info(inactive)
  local hl_lincol  = inactive and "Inactive" or "LineColumn"
  return string.format("%%#StatusLine%s#  %%3l/%%L  %%-2v ", hl_lincol)
  -- local hl_percent = inactive and "Inactive" or "LinePercent"
  -- return string.format(
  --   "%%#StatusLine%s# %%3l  %%-2v %%#StatusLine%s# %%P ",
  --   hl_lincol, hl_percent
  -- )
end

-- VCS
local function git_info(inactive)
  if not inactive then
    local icon = {
      branch        = ' ',
      diff_added    = ' ',
      diff_removed  = ' ',
      diff_modified = ' ',
    }
    local ok, data = pcall(vim.api.nvim_buf_get_var, 0, "gitsigns_status_dict")
    if ok then
      local s = "%#StatusLineBranchIcon# " .. icon.branch
      s = s .. "%#StatusLineBranchName#" .. data.head
      if data.added ~= nil and data.added > 0 then
        s = s .. " %#StatusLineDiffAdded#" .. icon.diff_added .. data.added
      end
      if data.changed ~= nil and data.changed > 0 then
        s = s .. " %#StatusLineDiffModified#" .. icon.diff_modified .. data.changed
      end
      if data.removed ~= nil and data.removed > 0 then
        s = s .. " %#StatusLineDiffRemoved#" .. icon.diff_removed .. data.removed
      end
      s = s .. ' '
      return s
    end
  end
  return ""
end

-- LSP status
local function diagnostic_info(inactive)
  if inactive or #vim.lsp.buf_get_clients(0) == 0 then
    return ""
  end
  local active_clients = vim.lsp.get_active_clients()

  if active_clients then
    local levels = {
      error = "Error",
      warn = "Warnings",
      -- info = "Information",
      -- hint = "Hint",
    }
    local icons = {
      error = " ",
      warn  = " ",
      -- info  = " ",
      -- hint  = " ",
    }
    local data = {}
    local bufnr = vim.api.nvim_get_current_buf()
    for k, level in pairs(levels) do
      local count = 0
      for _, client in ipairs(active_clients) do
        count = count + vim.lsp.diagnostic.get_count(bufnr, level, client.id)
      end
      data[k] = count
    end

    local s = ""
    if data.error ~= nil and data.error > 0 then
      s = s .. string.format("%%#StatusLineDiagnosticError# %s %s ", icons.error, data.error)
    end
    if data.warn ~= nil and data.warn > 0 then
      s = s .. string.format("%%#StatusLineDiagnosticWarn# %s %s ", icons.warn, data.warn)
    end
    -- if data.info ~= nil and data.info > 0 then
    --   s = s .. string.format("%%#StatusLineDiagnosticInfo# %s %s ", icons.info, data.info)
    -- end
    -- if data.hint ~= nil and data.hint > 0 then
    --   s = s .. string.format("%%#StatusLineDiagnosticHint# %s %s ", icons.hint, data.hint)
    -- end
    -- s = #s > 0 and s .. ' ' or ''
    return s
  end
  return ""
end

-- [[ Utility functions ]]

-- Colors
local function highlight(group, guifg, ctermfg, guibg, ctermbg, attr)
  local parts = {group} if guifg then table.insert(parts, "guifg="..guifg) end
  if guibg then table.insert(parts, "guibg="..guibg) end
  if ctermfg then table.insert(parts, "ctermfg="..ctermfg) end
  if ctermbg then table.insert(parts, "ctermbg="..ctermbg) end
  if attr then
    table.insert(parts, "gui="..attr)
    table.insert(parts, "cterm="..attr)
  end
  --if guisp then table.insert(parts, "guisp=#"..guisp) end
  vim.cmd('highlight '..table.concat(parts, ' '))
end

local function apply_theme()
  if type(M.theme) == 'string' then
    M.theme = require('appearance.themes.'.. M.theme)
  end
  for group, colors in pairs(M.theme) do
    highlight("StatusLine" .. group, colors.fg[1], colors.fg[2], colors.bg[1], colors.bg[2], colors.attr)
  end
  theme_set = M.theme
end

-- build statusline
local function make_statusline(inactive)
  if M.theme ~= theme_set then
    apply_theme()
  end
  inactive = inactive or false
  local space = "%#StatusLineBase# "
  local s = space
  s = s .. vi_mode(inactive)
  s = s .. file_icon(inactive)
  s = s .. file_name(inactive)
  s = s .. file_modified(inactive)
  s = s .. file_readonly(inactive)
  s = s .. file_size(inactive)
  s = s .. git_info(inactive)
  s = s .. space
  s = s .. "%="
  s = s .. diagnostic_info(inactive)
  if vim.api.nvim_win_get_width(0) > 80 then
    s = s .. file_encoding(inactive)
    s = s .. file_format(inactive)
  end
  s = s .. line_colmun_info(inactive)
  s = s .. space
  -- return s
  vim.wo.statusline = s
end

-- Create augroup for updating statusline
local function statusline_augroup()
  vim.cmd("augroup statusline_autocmd")
  vim.cmd("autocmd!")
  vim.cmd("autocmd VimEnter,ColorScheme * lua require'appearance.statusline'.statusline_apply_theme()")
  local events = {
    "VimEnter", "WinEnter", "BufEnter", "BufWritePost",
    "FileChangedShellPost","VimResized","TermOpen"
  }
  vim.cmd("autocmd ".. table.concat(events, ",") .. " * lua require'appearance.statusline'.statusline_active()")
  vim.cmd("autocmd WinLeave,BufLeave * lua require'appearance.statusline'.statusline_inactive()")
  vim.cmd("augroup END")
end

-- [[ API ]]
function M.statusline_active()
  make_statusline(false)
end

function M.statusline_inactive()
  make_statusline(true)
end

M.statusline_apply_theme = apply_theme

function M.setup(theme_name)
  M.theme = theme_name
  statusline_augroup()
end

return M

