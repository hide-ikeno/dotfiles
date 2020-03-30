local vim = vim or {}
local M = {}

function M.hook_source()
  vim.g["deoplete#enable_at_startup"] = 1

  vim.api.nvim_command[[
    function! s:check_back_space() abort
      let col = col('.') - 1
      return !col || getline('.')[col - 1]  =~ '\s'
    endfunction
  ]]
  -- Key mappings
  -- <TAB>: completion.
  vim.api.nvim_set_keymap("i", "<TAB>",
    [[pumvisible() ? "\<C-n>" : <SID>check_back_space() ? "\<TAB>" : deoplete#manual_complete()]],
    {noremap = true, expr = true})

  -- <S-TAB>: completion back.
  vim.api.nvim_set_keymap("i", "<S-TAB>",   [[pumvisible() ? "\<C-p>" : "\<C-h>"]],
    {noremap = true, expr = true})
  vim.api.nvim_set_keymap("i", "<C-Space>", [[deoplete#refresh()]],
    {noremap = true, expr = true})
  vim.api.nvim_set_keymap("i", "<C-e>",     [[deoplete#cancel_popup()]],
    {noremap = true, expr = true})
  vim.api.nvim_set_keymap("i", "<C-l>",     [[deoplete#complete_common_string()]],
    {noremap = true, expr = true})

  -- <CR>: close popup and save indent.
  vim.api.nvim_set_keymap("i", "<CR>", [[pumvisible() ? deoplete#close_popup()."\<CR>" : "\<CR>"]],
    {noremap = true, silent = true, expr = true})
end

function M.hook_post_source()
  -- Matchers
  vim.fn["deoplete#custom#source"]("_", "matchers", {
      "matcher_fuzzy",
      "matcher_length"
    })
  vim.fn["deoplete#custom#source"]("denite", "matchers", {
      "matcher_full_fuzzy",
      "matcher_length"
    })
  vim.fn["deoplete#custom#source"]("eskk", "matchers", {})

  -- Filetypes
  vim.fn["deoplete#custom#source"]("zsh", "filetypes", {"zsh", "sh"})

  -- Converters
  vim.fn["deoplete#custom#source"]("_", "converters", {
      "converter_remove_paren",
      "converter_remove_overlap",
      "matcher_length",
      "converter_truncate_abbr",
      "converter_truncate_info",
      "converter_truncate_menu",
    })

  vim.fn["deoplete#custom#source"]("eskk", "converters", {})

  -- Customize options
  vim.fn["deoplete#custom#option"]("ignore_sources", {
      _    = {"buffer"};
      help = {"tabnine"};
    })

  vim.fn["deoplete#custom#option"]("keyword_patterns", {
      _   = [[[a-zA-Z_]\k*\(?]],
      tex = [[[^\w|\s][a-zA-Z_]\w*]],
    })

  vim.fn["deoplete#custom#option"]({
      auto_refresh_delay   = 10,
      camel_case           = true,
      skip_multibyte       = true,
      prev_completion_mode = "length",
      auto_preview         = true,
    })

  -- Customize deoplete-tabnine
  if vim.fn["dein#tap"]("deoplete-tabnine") ~= 0 then
    vim.fn["deoplete#custom#source"]("tabnine", "rank", 300)
    vim.fn["deoplete#custom#source"]("tabnine", "min_pattern_length", 2)
    vim.fn["deoplete#custom#var"]("tabnine", {
        line_limit      = 500,
        max_num_results = 20,
      })
    vim.fn["deoplete#custom#source"]("tabnine", "converters", {
        "converter_remove_overlap",
        "converter_truncate_info",
      })
  end
end

return M
