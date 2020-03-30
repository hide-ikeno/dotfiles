local M = {}

function M.hook_add()
  vim.g.expand_region_text_objects = {
    ['iw'] = 0,
    ['iW'] = 0,
    ['iu'] = 0,
    ['ad'] = 1,
    ['ib'] = 1,
    ['il'] = 1,
    ['ip'] = 0,
    ['ie'] = 0,
  }

  vim.api.nvim_set_keymap("x", "v", "<Plug>(expand_region_expand)", {})
  vim.api.nvim_set_keymap("x", "V", "<Plug>(expand_region_shrink)", {})
end

return M
