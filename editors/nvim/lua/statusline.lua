local separator = {
  left      = "";
  right     = "";
  left_sub  = "";
  right_sub = "";
}

local function get_file_name()
  local ft = vim.bo.filetype
  local ft_icon = "no ft"
  if #ft ~= 0 then
    ft_icon = " " .. vim.fn.WebDevIconsGetFileTypeSymbol()
  end
  readonly_icon = ""
  if vim.bo.readonly and ft ~= "help" then
    readonly_icon = " "
  end
  return table.concat({ ft_icon, readonly_icon, "%f" })
end


