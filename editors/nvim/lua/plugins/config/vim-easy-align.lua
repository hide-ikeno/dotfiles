local M = {}

function M.setup()
  -- key mappings
  vim.api.nvim_set_keymap(
    "n", "<Leader>a", "<Plug>(EasyAlign)", { silent = true }
  )
  vim.api.nvim_set_keymap(
    "v", "<Leader>a", "<Plug>(EasyAlign)", { silent = true }
  )
  -- extending alignment rules
  vim.g.easy_align_delimiters = {
    ['>'] = { pattern = [[>>\|=>\|>]] },
    ['/'] = { pattern = [[//\+\|/\*\|\*/]], ignore_groups = { 'String' } },
    ['#'] = {
      pattern = [[#\+]],
      ignore_groups = { 'String' },
      delimiter_align = 'l',
    },
    [']'] = {
      pattern = [=[[[\]]]=],
      left_margin = 0,
      right_margin = 0,
      stick_to_left = 0,
    },
    [')'] = {
      pattern = '[()]',
      left_margin = 0,
      right_margin = 0,
      stick_to_left = 0,
    },
    ['d'] = {
      pattern = [[ \(\S\+\s*[;=]\)\@=]],
      left_margin = 0,
      right_margin = 0,
    },
  }
end

return M
