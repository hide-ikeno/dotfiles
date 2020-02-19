-- vim-polyglot
local function setup()
  vim.g.polyglot_disable = { "json", "markdown" }
end

return { setup = setup }
