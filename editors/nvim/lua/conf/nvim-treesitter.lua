local M = {}

function M.config()
  require'nvim-treesitter.configs'.setup{
    -- Setup
    -- one of 'all', 'language', or a list of languages
    ensure_installed = "all",
    -- [[ Highlight ]] {{{
    highlight = {
      -- temporary disable highlight until
      -- https://github.com/nvim-treesitter/nvim-treesitter/issues/423
      -- is fixed
      enable = false,
      disable = {},
      custom_captures = {
        -- ["foo.bar"] = "Identifier"
      }
    },
    -- }}}
    -- [[ Incremental selection ]] {{{
    incremental_selection = {
      enable = true,
      disable = {},
      keymaps = {                       -- mappings for incremental selection (visual mappings)
        init_selection = "gnn",         -- maps in normal mode to init the node/scope selection
        node_incremental = "grn",       -- increment to the upper named parent
        scope_incremental = "grc",      -- increment to the upper scope (as defined in locals.scm)
        node_decremental = "grm",       -- decrement to the previous node
      }
    },
    -- }}}
    -- [[ Refactor ]] {{{
    refactor = {
      highlight_definitions = {
        enable = true
      },
      highlight_current_scope = {
        enable = true
      },
      smart_rename = {
        enable = true,
        keymaps = {
          smart_rename = "grr"            -- mapping to rename reference under cursor
        }
      },
      navigation = {
        enable = true,
        keymaps = {
          goto_definition = "gnd",        -- mapping to go to definition of symbol under cursor
          list_definitions = "gnD"        -- mapping to list all definitions in current file
        }
      }
    },
    -- }}}
    -- [[ Text objects ]] {{{
    textobjects = { -- syntax-aware textobjects
      select = {
        enable = true,
        disable = {},
        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["aC"] = "@class.outer",
          ["iC"] = "@class.inner",
          ["ac"] = "@conditional.outer",
          ["ic"] = "@conditional.inner",
          ["ae"] = "@block.outer",
          ["ie"] = "@block.inner",
          ["al"] = "@loop.outer",
          ["il"] = "@loop.inner",
          ["is"] = "@statement.inner",
          ["as"] = "@statement.outer",
          ["am"] = "@call.outer",
          ["im"] = "@call.inner",
          ["ad"] = "@comment.outer",
          ["id"] = "@comment.inner",
          -- Or you can define your own textobjects like this
          -- [[
          ["iF"] = {
            python = "(function_definition) @function",
            cpp = "(function_definition) @function",
            c = "(function_definition) @function",
            java = "(method_declaration) @function",
          },
          -- ]]
        }
      }
    },
    -- }}}
  }
end

return M
