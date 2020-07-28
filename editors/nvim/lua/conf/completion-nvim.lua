local M = {}

function M.setup()
  vim.g.completion_enable_snippet = "vim-vsnip"
  vim.g.completion_auto_change_source = 1

  vim.g.completion_chain_complete_list = {
    default = {
      default = {
        {complete_items = {"lsp", "snippet"}},
        {mode = "<C-p>"},
        {mode = "<C-n>"}
      },
      comment = {},
      string = {
        {complete_items = {"path"}, triggered_only = {"/"}}
      }
    },
    cpp = {
      default = {
        {complete_items = {"ts", "lsp"}},
        {mode = "<C-p>"},
        {mode = "<C-n>"}
      },
      comment = {},
      string = {
        {complete_items = {"path"}, triggered_only = {"/"}}
      }
    },
    python = {
      default = {
        {complete_items = {"ts"}},
        {complete_items = {"lsp", "snippet"}},
        {mode = "<C-p>"},
        {mode = "<C-n>"}
      },
      comment = {},
      string = {
        {complete_items = {"path"}, triggered_only = {"/"}}
      }
    },
  }

  vim.g.completion_customize_lsp_label = {
    Function      = "",
    Method        = "",
    Variable      = "",
    Constant      = "",
    Struct        = "פּ",
    Class         = "",
    Interface     = "禍",
    Text          = "",
    Enum          = "",
    EnumMember    = "",
    Module        = "",
    Color         = "",
    Property      = "襁",
    Field         = "綠",
    Unit          = "",
    File          = "",
    Value         = "",
    Event         = "鬒",
    Folder        = "",
    Keyword       = "",
    Snippet       = "",
    Operator      = "洛",
    Reference     = " ",
    TypeParameter = "",
    Default       = ""
  }

end

function M.config()
  vim.cmd[[ augroup completion_nvim_autocmd ]]
  vim.cmd[[ autocmd! ]]
  vim.cmd[[ autocmd BufEnter *         lua require'completion'.on_attach()]]
  vim.cmd[[ autocmd BufEnter *         let g:completion_trigger_character = ['.'] ]]
  vim.cmd[[ autocmd BufEnter *.c,*.cpp let g:completion_trigger_character = ['.', '::', '->'] ]]
  vim.cmd[[ augroup END ]]
end

return M
