-- Statusline colors

CURRENT_MODE_LABEL = {
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

CURRENT_MODE_HIGHLIGHT_GROUP = {
  ["n"]  = "StatusLineModeNormal";
  ["i"]  = "StatusLineModeInsert";
  ["v"]  = "StatusLineModeVisual";
  ["V"]  = "StatusLineModeVisual";
  [""] = "StatusLineModeVisual";
  ["R"]  = "StatusLineModeReplace";
  ["c"]  = "StatusLineModeCommand";
}

setmetatable(CURRENT_MODE_HIGHLIGHT_GROUP, {
    __index = function () return "StatusLineModeMisc" end
  })

function SetCurrentMode()
  local mode = vim.fn.mode()
  local label = CURRENT_MODE_LABEL[mode]
  local color = CURRENT_MODE_HIGHLIGHT_GROUP[mode]
  vim.api.nvim_command("highlight! link StatusLineMode " .. color)
  return label
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

function SetGitBranch()
  local branch = vim.fn["gitbranch#name"]()
  if branch ~= '' then
    branch = " " .. branch
  end
  return branch
end

function SetStatusLineActive()
  vim.api.nvim_command("highlight StatusLineBase          guibg=NONE    guifg=#929dcb")
  vim.api.nvim_command("highlight StatusLineGit           guibg=#020511 guifg=#A37ACC")
  vim.api.nvim_command("highlight StatusLineLineCol       guibg=#020511 guifg=#929dcb")
  vim.api.nvim_command("highlight StatusLineFiletype      guibg=#020511 guifg=#82b1ff")
  vim.api.nvim_command("highlight StatusLinePowerlineMode guibg=NONE    guifg=#020511")
  vim.api.nvim_command("highlight StatusLineModeNormal    guibg=#020511 guifg=#00AAFF")
  vim.api.nvim_command("highlight StatusLineModeInsert    guibg=#020511 guifg=#88FF88")
  vim.api.nvim_command("highlight StatusLineModeVisual    guibg=#020511 guifg=#967EFB")
  vim.api.nvim_command("highlight StatusLineModeReplace   guibg=#020511 guifg=#FF9A00")
  vim.api.nvim_command("highlight StatusLineModeCommand   guibg=#020511 guifg=#668799")
  vim.api.nvim_command("highlight StatusLineModeMisc      guibg=#020511 guifg=#CCCCCC")
  vim.api.nvim_command("highlight StatusLineMode          guibg=#020511 guifg=#CCCCCC")

  local parts = {
    "%#StatusLineBase#";
    "%#StatusLinePowerlineMode#";
    "%#StatusLineMode#%{v:lua.SetCurrentMode()}";
    "%#StatusLinePowerlineMode#";
    "%#StatusLinePowerlineMode#";
    "%#StatusLineGit# %{v:lua.SetGitBranch()} ";
    "%#StatusLinePowerlineMode#";
    "%=";
    "%#StatusLinePowerlineMode#";
    "%#StatusLineFiletype# %{v:lua.SetFilename()}";
    "%#StatusLinePowerlineMode#";
    "%#StatusLinePowerlineMode#";
    "%#StatusLineLineCol# Ln %l Col %c ";
    "%#StatusLinePowerlineMode#";
  }
  winnr = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_option(winnr, "statusline", table.concat(parts, ""))

  -- return table.concat(parts, "")
  -- return table.concat(parts, "")
  -- winnr = vim.fn.win_getid()
  -- winnr = vim.api.nvim_get_current_win()
  -- vim.api.nvim_win_set_option(winnr, "statusline", string.format("Active win %d", winnr))
end

function SetStatusLineInactive()
  -- local s = ""
  -- vim.wo.statusline = s
  -- winnr = vim.fn.win_getid()
  winnr = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_option(winnr, "statusline", string.format("Inactive win %d", winnr))
end

-- Change statusline automatically
vim.api.nvim_command("augroup StatuLineUpdate")
vim.api.nvim_command("autocmd!")
vim.api.nvim_command("autocmd FocusGained,VimEnter,WinEnter,BufEnter * lua SetStatusLineActive()")
vim.api.nvim_command("autocmd FocusLost,WinLeave,BufLeave            * lua SetStatusLineInactive()")
vim.api.nvim_command("augroup END")

