local M = {}

local function make_on_attach(config)
  return function(client)
    if config.before then
      config.before(client)
    end

    -- omni completion source
    vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

    -- key mappings
    local opts = {noremap = true, silent = true}
    vim.api.nvim_buf_set_keymap(0, "n", "ma", "<cmd>lua vim.lsp.buf.code_action()<cr>",     opts)
    vim.api.nvim_buf_set_keymap(0, "n", "md", "<cmd>lua vim.lsp.buf.definition()<cr>",      opts)
    vim.api.nvim_buf_set_keymap(0, "n", "md", "<cmd>lua vim.lsp.buf.declaration()<cr>",     opts)
    vim.api.nvim_buf_set_keymap(0, "n", "mi", "<cmd>lua vim.lsp.buf.implementation()<cr>",  opts)
    vim.api.nvim_buf_set_keymap(0, "n", "mt", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
    vim.api.nvim_buf_set_keymap(0, "n", "mr", "<cmd>lua vim.lsp.buf.references()<cr>",      opts)
    vim.api.nvim_buf_set_keymap(0, "n", "mp", "<cmd>lua vim.lsp.buf.peek_definition()<cr>", opts)
    vim.api.nvim_buf_set_keymap(0, "n", "mr", "<cmd>lua vim.lsp.buf.rename()<cr>",          opts)
    vim.api.nvim_buf_set_keymap(0, "n", "mh", "<cmd>lua vim.lsp.buf.hover()<cr>",           opts)
    vim.api.nvim_buf_set_keymap(0, "n", "mh", "<cmd>lua vim.lsp.buf.signature_help()<cr>",  opts)
    vim.api.nvim_buf_set_keymap(0, "n", "mo", "<cmd>lua vim.lsp.buf.document_symbol()<cr>", opts)
    -- diagnostics
    vim.api.nvim_buf_set_keymap(0, "n", "m]", "<cmd>lua vim.lsp.diagnostic.goto_next()<cr>",             opts)
    vim.api.nvim_buf_set_keymap(0, "n", "m[", "<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",             opts)
    vim.api.nvim_buf_set_keymap(0, "n", "me", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<cr>", opts)
    vim.api.nvim_buf_set_keymap(0, "n", "mq", "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>",           opts)

    -- formatting
    if client.resolved_capabilities.document_formatting then
      vim.api.nvim_buf_set_keymap(0, "n", "mF", "<cmd>lua vim.lsp.buf.formatting()<cr>",       opts)
    end
    if client.resolved_capabilities.document_range_formatting then
      vim.api.nvim_buf_set_keymap(0, "n", "mf", "<cmd>lua vim.lsp.buf.range_formatting()<cr>", opts)
      vim.api.nvim_buf_set_keymap(0, "x", "mf", "<cmd>lua vim.lsp.buf.range_formatting()<cr>", opts)
    end

    -- automatic highlight
    if client.resolved_capabilities.document_highlight then
      vim.cmd[[augroup nvim_lspconfig_user_autocmds]]
      vim.cmd[[autocmd!]]
      vim.cmd[[autocmd cursorhold  <buffer> lua vim.lsp.buf.document_highlight()]]
      vim.cmd[[autocmd cursormoved <buffer> lua vim.lsp.buf.clear_references()]]
      vim.cmd[[augroup end]]
    end
    if config.after then
      config.after(client)
    end
  end
end

function M.setup()
  -- Variables
  vim.fn.sign_define("LspDiagnosticsErrorSign",       { text = "", texthl = "LspDiagnosticError"      })
  vim.fn.sign_define("LspDiagnosticsWarningSign",     { text = "", texthl = "LspDiagnosticWarning"    })
  vim.fn.sign_define("LspDiagnosticsInformationSign", { text = "", texthl = "LspDiagnosticInformtion" })
  vim.fn.sign_define("LspDiagnosticsHintSign",        { text = "", texthl = "LspDiagnosticHint"       })

  -- Debug mode
  --vim.lsp.set_log_level("debug")
end

function M.config()
  local lspconfig   = require("lspconfig")
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
      root_dir = lspconfig.util.root_pattern("package.json", ".git")
    },
    efm = {
      filetypes = {
        "csv", "eruby", "json", "make", "markdown", "rst"
      },
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
      callbacks = lsp_status.extensions.pyls_ms.setup(),
      settings = {
        python = {
          jediEnabled = false,
          analysis = {
            cachingLevel = 'Library'
          },
          workspaceSymbols = {
            enabled = true
          }
        }
      },
      root_dir = function(fname)
        return lspconfig.util.root_pattern('pyproject.toml', 'setup.py', 'setup.cfg',
          'requirements.txt', 'mypy.ini', '.pylintrc', '.flake8rc',
          '.gitignore')(fname)
        or lspconfig.util.find_git_ancestor(fname) or vim.loop.os_homedir()
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
          runtime = {
            version = 'LuaJIT'
          }
        }
      }
    },
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

    lspconfig[server].setup(config)
  end

  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      underline = true,
      virtual_text = true,
      signs = {
        priority = 20
      },
      update_in_insert = false,
    }
  )

end

return M

