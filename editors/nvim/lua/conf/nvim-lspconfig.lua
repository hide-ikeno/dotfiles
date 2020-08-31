local M = {}

local function make_on_attach(config)
  return function(client)
    if config.before then
      config.before(client)
    end
    --
    -- Omni completion source
    vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

    -- Setup extensions
    -- if client.resolved_capabilities.document_symbol then
    --   require'lsp-status'.on_attach(client)
    -- end
    require'diagnostic'.on_attach()

    -- Key mappings
    local opts = {noremap = true, silent = true}
    vim.api.nvim_buf_set_keymap(0, "n", "mA", "<cmd>lua vim.lsp.buf.code_action()<CR>",            opts)
    vim.api.nvim_buf_set_keymap(0, "n", "md", "<cmd>lua vim.lsp.buf.definition()<CR>",             opts)
    vim.api.nvim_buf_set_keymap(0, "n", "mD", "<cmd>lua vim.lsp.buf.declaration()<CR>",            opts)
    vim.api.nvim_buf_set_keymap(0, "n", "me", "<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>", opts)
    vim.api.nvim_buf_set_keymap(0, "n", "mi", "<cmd>lua vim.lsp.buf.implementation()<CR>",         opts)
    vim.api.nvim_buf_set_keymap(0, "n", "mt", "<cmd>lua vim.lsp.buf.type_definition()<CR>",        opts)
    vim.api.nvim_buf_set_keymap(0, "n", "mr", "<cmd>lua vim.lsp.buf.references()<CR>",             opts)
    vim.api.nvim_buf_set_keymap(0, "n", "mp", "<cmd>lua vim.lsp.buf.peek_definition()<CR>",        opts)
    vim.api.nvim_buf_set_keymap(0, "n", "mR", "<cmd>lua vim.lsp.buf.rename()<CR>",                 opts)
    vim.api.nvim_buf_set_keymap(0, "n", "mh", "<cmd>lua vim.lsp.buf.hover()<CR>",                  opts)
    vim.api.nvim_buf_set_keymap(0, "n", "mH", "<cmd>lua vim.lsp.buf.signature_help()<CR>",         opts)
    vim.api.nvim_buf_set_keymap(0, "n", "mo", "<cmd>lua vim.lsp.buf.document_symbol()<CR>",        opts)

    if client.resolved_capabilities.document_formatting then
      vim.api.nvim_buf_set_keymap(0, "n", "mF", "<cmd>lua vim.lsp.buf.formatting()<CR>",       opts)
    end
    if client.resolved_capabilities.document_range_formatting then
      vim.api.nvim_buf_set_keymap(0, "n", "mf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
      vim.api.nvim_buf_set_keymap(0, "x", "mf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opts)
    end
    -- diagnostics-lsp
    vim.api.nvim_buf_set_keymap(0, "n", "m]", "<cmd>NextDiagnosticCycle<CR>", opts)
    vim.api.nvim_buf_set_keymap(0, "n", "m[", "<cmd>PrevDiagnosticCycle<CR>", opts)
    vim.api.nvim_buf_set_keymap(0, "n", "mq", "<cmd>OpenDiagnostic<CR>",      opts)

    -- automatic highlight
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
  vim.fn.sign_define("LspDiagnosticsErrorSign",       { text = "", texthl = "LspDiagnosticError"      })
  vim.fn.sign_define("LspDiagnosticsWarningSign",     { text = "", texthl = "LspDiagnosticWarning"    })
  vim.fn.sign_define("LspDiagnosticsInformationSign", { text = "", texthl = "LspDiagnosticInformtion" })
  vim.fn.sign_define("LspDiagnosticsHintSign",        { text = "", texthl = "LspDiagnosticHint"       })

  -- Debug mode
  --vim.lsp.set_log_level("debug")
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

    nvim_lsp[server].setup(config)
  end

end

return M

