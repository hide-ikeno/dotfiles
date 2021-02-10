local packer

local function init()
  if packer == nil then
    packer = require("packer")
    packer.init {
      disable_commands = true,
      max_jobs = 50,
    }
  end
  packer.reset()

  for _, name in pairs{
    "basic",
    "appearance",
    "editor",
    "enhance",
    "filetype",
    "program",
    "vcs",
    "completion",
    "telescope",
  } do packer.use(require('plugins.' .. name)) end
end

return setmetatable({}, {
  __index = function(_, key)
    init()
    return packer[key]
  end,
})
