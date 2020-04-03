local vim = vim
local M = {}

function M.hook_add()
  vim.api.nvim_set_keymap("i", "<C-j>", "<Plug>(eskk:toggle)", {silent = true})
  vim.api.nvim_set_keymap("c", "<C-j>", "<Plug>(eskk:toggle)", {silent = true})
end

function M.hook_source()
  vim.g["eskk#directory"] = vim.env.VIM_CACHE_HOME .. "/eskk"

  vim.g["eskk#dictionary"] = {
    path     = vim.env.VIM_CACHE_HOME .. "/skk-jisyo",
    sorted   = 1,
    encoding = "utf-8",
  }

  if vim.fn.has('mac') then
    vim.g["eskk#large_dictionary"] = {
      path= "~/Library/Application Support/AquaSKK/SKK-JISYO.L",
      sorted= 1,
      encoding= "euc-jp",
    }
  elseif vim.fn.has('win32') or vim.fn.has('win64') then
    vim.g["eskk#large_dictionary"] = {
      path= "~/SKK-JISYO.L",
      sorted= 1,
      encoding= "euc-jp",
    }
  else
    vim.g["eskk#large_dictionary"] = {
      path= "/usr/local/share/skk/SKK-JISYO.L",
      sorted= 1,
      encoding= "euc-jp",
    }
  end

  vim.g["eskk#server"] = { host = "localhost", port = 1178 }

  -- Henkan, annotation
  vim.g["eskk#show_annotation"]             = 1
  vim.g["eskk#keep_state"]                  = 0
  vim.g["eskk#debug"]                       = 0
  vim.g["eskk#show_annotation"]             = 1
  vim.g["eskk#egg_like_newline"]            = 1
  vim.g["eskk#egg_like_newline_completion"] = 1
  vim.g["eskk#tab_select_completion"]       = 1
  vim.g["eskk#start_completion_length"]     = 2

  -- easy escape with 'jj'
  vim.api.nvim_command("augroup user-plugin-eskk")
  vim.api.nvim_command("autocmd!")
  vim.api.nvim_command("autocmd User eskk-initialize-post EskkMap -remap jj <ESC>")
  vim.api.nvim_command("augroup END")
end

return M
