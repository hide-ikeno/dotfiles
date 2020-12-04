local M = {}

function M.custom_advance(offset)
  local snip_plug = require("snippets")
  local _, expanded = snip_plug.lookup_snippet_at_cursor()
  if expanded then
    snip_plug.expand_or_advance(offset)
  else
    if offset == 1 then
      vim.cmd[[execute <Left>]]
    else
      vim.cmd[[execute <Right>]]
    end
  end
end

function M.config()
  local snip_plug = require("snippets")
  local indent = require("snippets.utils").match_indentation
  local force_comment = require("snippets.utils").force_comment

  local snips = {}

  -- TODO (H. Ikeno):  add more snippets
  snips._global = {
    ["todo"] = "TODO (H. Ikeno): ",
    ["date"] = [[${=os.date("%Y-%m-%d")}]],
    ["uname"] = function() return vim.loop.os_uname() end,
  }

  snip_plug.snippets = snips

  -- UX
  snip_plug.set_ux(require'snippets.inserters.floaty')

  -- Key mappings
  opts = {noremap = true, silent = true}
  vim.api.nvim_set_keymap("i", "<C-f>", "<cmd>lua require'conf.snippets'.custom_advance(1)<CR>",  opts)
  vim.api.nvim_set_keymap("i", "<C-b>", "<cmd>lua require'conf.snippets'.custom_advance(-1)<CR>", opts)
end

return M
