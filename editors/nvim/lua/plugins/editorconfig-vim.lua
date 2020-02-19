-- EditorConfig
local function setup()
  vim.g.EditorConfig_exclude_patterns = { "fugitive://.*", "scp://.*", "term://.*" }
end

return { setup = setup }
