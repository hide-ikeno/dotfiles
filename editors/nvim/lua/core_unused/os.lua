--- OS specific settings
local M = {}

M.is_windows = vim.loop.os_uname().version:match("Windows")
M.is_mac     = vim.loop.os_uname().version:match("Darwin")

-- Get back the output of an external command
function M.capture(cmd, raw)
  local f = assert(io.popen(cmd, 'r'))
  local s = assert(f:read('*a'))
  f:close()
  if raw then return s end
  s = string.gsub(s, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', ' ')
  return s
end

return M
