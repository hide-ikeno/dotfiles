-- indentLine
local function setup()
  vim.g.indentLine_enable     = 1
  vim.g.indentLine_char       = '¦'
  vim.g.indentLine_setConceal = 0
end

return { setup = setup }
