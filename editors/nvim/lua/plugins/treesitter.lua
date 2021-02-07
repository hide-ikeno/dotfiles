return {
  "nvim-treesitter/nvim-treesitter",
  event = "BufRead *",
  run = ":TSUpdate",
  requires = {
    -- nvim-treesitter plugins
    {"nvim-treesitter/nvim-treesitter-refactor",    after="nvim-treesitter"},
    {"nvim-treesitter/nvim-treesitter-textobjects", after="nvim-treesitter"},
  },
  config = function()
    require'nvim-treesitter.configs'.setup{
      -- one of 'all', 'language', or a list of languages
      ensure_installed = "all",
      -- [[ Highlight ]]
      highlight = {
        enable = true,
        disable = {},
        custom_captures = {
          -- ["foo.bar"] = "Identifier"
        }
      },
      -- [[ Incremental selection ]]
      incremental_selection = {
        enable = true,
        disable = {},
        keymaps = {                    -- mappings for incremental selection (visual mappings)
          init_selection = "<M-v>",      -- maps in normal mode to init the node/scope selection
          node_incremental = "<M-v>",    -- increment to the upper named parent
          scope_incremental = "<C-M-v>", -- increment to the upper scope (as defined in locals.scm)
          node_decremental = "<M-V>",    -- decrement to the previous node
        }
      },
      -- [[ Refactor ]]
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
      -- [[ Text objects ]]
      textobjects = {
        select = {
          enable = true,
          disable = {},
          keymaps = {
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
          }
        },
        swap = {
          enable = true,
          swap_next = {
            ["<Leader>s"] = "@parameter.inner",
          },
          swap_previous = {
            ["<Leader>S"] = "@parameter.inner",
          },
        },
      },
    }
  end
}
