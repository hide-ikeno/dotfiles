local M = {}

function M.setup()
  vim.g.sandwich_no_default_key_mappings = 1
  vim.g.operator_sandwich_no_default_key_mappings = 1
  vim.g.textobj_sandwich_no_default_key_mappings = 1

  -- Key mappings
  local opts = { silent = true }

  vim.api.nvim_set_keymap(
    "n", "sd",
    "<Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)",
    opts
  )
  vim.api.nvim_set_keymap(
    "n", "sr",
    "<Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-query-a)",
    opts
  )
  vim.api.nvim_set_keymap(
    "n", "sd",
    "<Plug>(operator-sandwich-delete)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)",
    opts
  )
  vim.api.nvim_set_keymap(
    "n", "sr",
    "<Plug>(operator-sandwich-replace)<Plug>(operator-sandwich-release-count)<Plug>(textobj-sandwich-auto-a)",
    opts
  )

  vim.api.nvim_set_keymap("n", "sa", "<Plug>(operator-sandwich-add)", {})
  vim.api.nvim_set_keymap("x", "sa", "<Plug>(operator-sandwich-add)", {})
  vim.api.nvim_set_keymap("o", "sa", "<Plug>(operator-sandwich-g@)", {})
  vim.api.nvim_set_keymap("x", "sd", "<Plug>(operator-sandwich-delete)", {})
  vim.api.nvim_set_keymap("x", "sr", "<Plug>(operator-sandwich-replace)", {})

  vim.api.nvim_set_keymap("o", "ab", "<Plug>(textobj-sandwich-auto-a)", {})
  vim.api.nvim_set_keymap("o", "ib", "<Plug>(textobj-sandwich-auto-i)", {})
  vim.api.nvim_set_keymap("x", "ab", "<Plug>(textobj-sandwich-auto-a)", {})
  vim.api.nvim_set_keymap("x", "ib", "<Plug>(textobj-sandwich-auto-i)", {})
  vim.api.nvim_set_keymap("o", "as", "<Plug>(textobj-sandwich-query-a)", {})
  vim.api.nvim_set_keymap("o", "is", "<Plug>(textobj-sandwich-query-i)", {})
  vim.api.nvim_set_keymap("x", "as", "<Plug>(textobj-sandwich-query-a)", {})
  vim.api.nvim_set_keymap("x", "is", "<Plug>(textobj-sandwich-query-i)", {})
end

function M.config()
  vim.g["textobj#sandwich#stimeoutlen"] = 100
  vim.api.nvim_exec(
    [=[
      let g:sandwich#recipes = deepcopy(g:sandwich#default_recipes)
      let g:sandwich#recipes += [{'buns': ['「', '」']}, {'buns': ['【', '】']}]
      let g:sandwich#recipes += [{'buns': ['（', '）']}, {'buns': ['『', '』']}]
      let g:sandwich#recipes += [{'buns': ['\(',  '\)'], 'filetype': ['vim'], 'nesting': 1}]
      let g:sandwich#recipes += [{'buns': ['\%(', '\)'], 'filetype': ['vim'], 'nesting': 1}]
    ]=], false
  )
end

return M
