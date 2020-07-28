local M = {}

local function make_on_attach(config)
  return function(client)
    if config.before then
      config.before(client)
    end
    -- Omni completion source
    vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"
    require'lsp-status'.on_attach(client)
    require'diagnostic'.on_attach()

    if client.resolved_capabilities.document_highlight then
      vim.cmd[[augroup nvim_lsp_user_autocmds]]
      vim.cmd[[autocmd!]]
      vim.cmd[[autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]]
      vim.cmd[[autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]
      vim.cmd[[augroup END]]
    end
    if config.after then
      config.after(client)
    end
  end
end

function M.setup()
  -- Variables
  vim.g.enable_nvim_lsp_diagnostics   = true
  -- vim.g.LspDiagnosticsErrorSign       = ""
  -- vim.g.LspDiagnosticsWarningSign     = ""
  -- vim.g.LspDiagnosticsInformationSign = ""
  -- vim.g.LspDiagnosticsHintSign        = ""
  vim.fn.sign_define("LspDiagnosticsErrorSign",       { text = "", texthl = "LspDiagnosticError"      })
  vim.fn.sign_define("LspDiagnosticsWarningSign",     { text = "", texthl = "LspDiagnosticWarning"    })
  vim.fn.sign_define("LspDiagnosticsInformationSign", { text = "", texthl = "LspDiagnosticInformtion" })
  vim.fn.sign_define("LspDiagnosticsHintSign",        { text = "", texthl = "LspDiagnosticHint"       })

  -- Debug mode
  --vim.lsp.set_log_level("debug")

  -- Key mappings
  local opts = {noremap = true, silent = true}
  vim.api.nvim_set_keymap("n", "mA", "<cmd>lua vim.lsp.buf.code_action()<CR>",            opts)
  vim.api.nvim_set_keymap("n", "md", "<cmd>lua vim.lsp.buf.definition()<CR>",             opts)
  vim.api.nvim_set_keymap("n", "mD", "<cmd>lua vim.lsp.buf.declaration()<CR>",            opts)
  vim.api.nvim_set_keymap("n", "me", "<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>", opts)
  vim.api.nvim_set_keymap("n", "mi", "<cmd>lua vim.lsp.buf.implementation()<CR>",         opts)
  vim.api.nvim_set_keymap("n", "mt", "<cmd>lua vim.lsp.buf.type_definition()<CR>",        opts)
  vim.api.nvim_set_keymap("n", "mr", "<cmd>lua vim.lsp.buf.references()<CR>",             opts)
  vim.api.nvim_set_keymap("n", "mp", "<cmd>lua vim.lsp.buf.peek_definition()<CR>",        opts)
  vim.api.nvim_set_keymap("n", "mR", "<cmd>lua vim.lsp.buf.rename()<CR>",                 opts)
  vim.api.nvim_set_keymap("n", "mF", "<cmd>lua vim.lsp.buf.formatting()<CR>",             opts)
  vim.api.nvim_set_keymap("n", "mf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>",       opts)
  vim.api.nvim_set_keymap("x", "mf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>",       opts)
  vim.api.nvim_set_keymap("n", "mh", "<cmd>lua vim.lsp.buf.hover()<CR>",                  opts)
  vim.api.nvim_set_keymap("n", "mH", "<cmd>lua vim.lsp.buf.signature_help()<CR>",         opts)
  vim.api.nvim_set_keymap("n", "mo", "<cmd>lua vim.lsp.buf.document_symbol()<CR>",  opts)

  -- diagnostics-lsp
  vim.api.nvim_set_keymap("n", "m]", "<cmd>NextDiagnosticCycle<CR>",  opts)
  vim.api.nvim_set_keymap("n", "m[", "<cmd>PrevDiagnosticCycle<CR>",  opts)
  vim.api.nvim_set_keymap("n", "mq", "<cmd>OpenDiagnostic<CR>",       opts)
end

function M.config()
  local nvim_lsp   = require("nvim_lsp")
  local lsp_status = require("lsp-status")

  -- Setup language servers
  local servers = {
    bashls = {},
    clangd = {
      cmd = {
        'clangd', -- '--background-index',
        '--clang-tidy', '--completion-style=bundled', '--header-insertion=iwyu',
        '--suggest-missing-includes', '--cross-file-rename'
      },
      callbacks = lsp_status.extensions.clangd.setup(),
      init_options = {
        clangdFileStatus = true,
        usePlaceholders = true,
        completeUnimported = true
      }
    },
    cmake = {},
    cssls = {
      filetypes = {"css", "scss", "less", "sass"},
      root_dir = nvim_lsp.util.root_pattern("package.json", ".git")
    },
    fortls = {},
    gopls = {
      init_options = {
        usePlaceholders = true,
        completeUnimported = true
      };
    },
    html = {},
    jsonls = {},
    julials = {},
    pyls_ms = {
      -- cmd = {'mspyls'},
      callbacks = lsp_status.extensions.pyls_ms.setup(),
      settings = {
        python = {
          jediEnabled = false,
          analysis = {cachingLevel = 'Library'},
          formatting = {provider = 'black'},
          -- venvFolders = {"envs", ".pyenv", ".direnv", ".cache/pypoetry/virtualenvs"},
          venvPath = "${workspaceFolder}/.venv",
          workspaceSymbols = {enabled = true}
        }
      },
      root_dir = function(fname)
        return nvim_lsp.util.root_pattern('pyproject.toml', 'setup.py', 'setup.cfg',
          'requirements.txt', 'mypy.ini', '.pylintrc', '.flake8rc',
          '.gitignore')(fname)
        or nvim_lsp.util.find_git_ancestor(fname) or vim.loop.os_homedir()
      end
    },
    rust_analyzer = {},
    solargraph = {},
    sumneko_lua = {
      cmd = {'lua-language-server'},
      settings = {
        Lua = {
          diagnostics = {
            globals = {'vim'}
          },
          completion = {
            keywordSnippet = 'Disable'
          },
          runtime = {
            version = 'LuaJIT'
          }
        }
      }
    },
    -- texlab = {
    --   settings = {
    --     latex = {
    --       forwardSearch = {
    --         executable = 'okular',
    --         args = {'--unique', 'file:%p#src:%l%f'}
    --       }
    --     }
    --   },
    --   commands = {
    --     TexlabForwardSearch = {
    --       function()
    --         local pos = vim.api.nvim_win_get_cursor(0)
    --         local params = {
    --           textDocument = {uri = vim.uri_from_bufnr(0)},
    --           position = {line = pos[1] - 1, character = pos[2]}
    --         }
    --
    --         vim.lsp.buf_request(0, 'textDocument/forwardSearch', params, function(err, _, result, _)
    --           if err then error(tostring(err)) end
    --           print('Forward search ' .. vim.inspect(pos) .. ' ' .. texlab_search_status[result])
    --         end)
    --       end,
    --       description = 'Run synctex forward search'
    --     }
    --   }
    -- },
    vimls = {},
    yamlls = {},
  }

  local snippet_capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true
        }
      }
    }
  }

  for server, config in pairs(servers) do
    config.on_attach = make_on_attach(config)
    config.capabilities = vim.tbl_deep_extend(
      "keep", config.capabilities or {}, lsp_status.capabilities, snippet_capabilities
      )

    nvim_lsp[server].setup(config)
  end
end

return M

