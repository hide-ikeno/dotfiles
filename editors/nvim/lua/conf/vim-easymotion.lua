local M = {}

function M.hook_add()
  -- Disable default mappings
  vim.g.EasyMotion_do_mapping = 0
  -- Do not shade
  vim.g.EasyMotion_do_shade = 0
  -- Use uppercase target labels (and type as a lowercase)
  vim.g.EasyMotion_use_upper = 1
  -- Characters used for target labels
  vim.g.EasyMotion_keys = ";HKLYUIONM,WERTXCVBASDGJF"
  -- Smartcase ('v' matches both 'v' and 'V', while 'V' does only 'V')
  vim.g.EasyMotion_smartcase = 1
  -- Smartsign ('1' matches both '1' and '!' -> not used)
  vim.g.EasyMotion_use_smartsign_us = 0
  -- keep cursor column
  vim.g.EasyMotion_startofline = 0
  -- Don't skip folded line
  vim.g.EasyMotion_skipfoldedline = 0
  -- pseudo-migemo
  vim.g.EasyMotion_use_migemo = 1
  -- Jump to first with enter & space
  vim.g.EasyMotion_space_jump_first = 1
  -- Prompt
  vim.g.EasyMotion_prompt = "Search for {n} chars> "


  -- Key mappings
  vim.api.nvim_set_keymap("n", "sf", "<Plug>(easymotion-overwin-f)", {})
  vim.api.nvim_set_keymap("n", "ss", "<Plug>(easymotion-overwin-f2)", {})
  vim.api.nvim_set_keymap("v", "ss", "<Plug>(easymotion-s2)", {})
  vim.api.nvim_set_keymap("o", "ss", "<Plug>(easymotion-s2)", {})

  vim.api.nvim_set_keymap("",  "sh", "<Plug>(easymotion-linebackward)", {})
  vim.api.nvim_set_keymap("",  "sj", "<Plug>(easymotion-j)", {})
  vim.api.nvim_set_keymap("",  "sk", "<Plug>(easymotion-k)", {})
  vim.api.nvim_set_keymap("",  "sl", "<Plug>(easymotion-lineforward)", {})

  vim.api.nvim_set_keymap("",  "s/", "<Plug>(easymotion-sn)", {})
  vim.api.nvim_set_keymap("o", "s/", "<Plug>(easymotion-tn)", {})
  vim.api.nvim_set_keymap("",  "sn", "<Plug>(easymotion-next)", {})
  vim.api.nvim_set_keymap("",  "sp", "<Plug>(easymotion-prev)", {})

  -- smart f & F (visual mode and operator mode)
  vim.api.nvim_set_keymap("n", "f", "<Plug>(easymotion-sl)", {})
  vim.api.nvim_set_keymap("o", "f", "<Plug>(easymotion-bd-fl)", {})
  vim.api.nvim_set_keymap("x", "f", "<Plug>(easymotion-bd-fl)", {})
end

return M
