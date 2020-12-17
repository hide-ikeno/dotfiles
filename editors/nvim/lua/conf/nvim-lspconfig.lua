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

    vim.cmd[[augroup nvim_lspconfig_user_autocmds]]
    vim.cmd[[autocmd! * <buffer>]]
    vim.cmd[[augroup end]]
    -- formatting
    if client.resolved_capabilities.document_formatting then
      vim.cmd[[autocmd nvim_lspconfig_user_autocmds BufWritePost <buffer> lua vim.lsp.buf.formatting()]]
    end
    if client.resolved_capabilities.document_range_formatting then
      vim.api.nvim_buf_set_keymap(0, "n", "mf", "<cmd>lua vim.lsp.buf.range_formatting()<cr>", opts)
      vim.api.nvim_buf_set_keymap(0, "x", "mf", "<cmd>lua vim.lsp.buf.range_formatting()<cr>", opts)
    end

    -- automatic highlight
    if client.resolved_capabilities.document_highlight then
      vim.cmd[[autocmd nvim_lspconfig_user_autocmds CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]]
      vim.cmd[[autocmd nvim_lspconfig_user_autocmds CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]
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

  -- Configure built in LSP
  --vim.lsp.set_log_level("debug")
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

  vim.lsp.handlers["textDocument/formatting"] = function(err, _, result, _, bufnr)
    if err ~= nil or result == nil then
      return
    end
    if not vim.api.nvim_buf_get_option(bufnr, "modified") then
      local view = vim.fn.winsaveview()
      vim.lsp.util.apply_text_edits(result, bufnr)
      vim.fn.winrestview(view)
      if bufnr == vim.api.nvim_get_current_buf() then
        vim.api.nvim_command("noautocmd :update")
      end
    end
  end
end

function M.config()
  local lspconfig  = require("lspconfig")
  local lsp_status = require("lsp-status")
  lsp_status.register_progress()
-- Setup language servers
  local servers = {
    bashls = {},
    clangd = {
      cmd = {
        'clangd', -- '--background-index',
        '--clang-tidy', '--completion-style=bundled', '--header-insertion=iwyu',
        '--suggest-missing-includes', '--cross-file-rename'
      },
      handlers = lsp_status.extensions.clangd.setup(),
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
        "csv", "dockerfile", "eruby", "json", "lua", "make", "markdown", "python", "rst", "sh", "yaml",
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
    pyright = {
      handlers = {
        -- place holder to ignore the registerCapability messages.
        -- See https://github.com/neovim/neovim/issues/13448
        ['client/registerCapability'] = function(_, _, _, _)
          return {
            result = nil;
            error = nil;
          }
        end
      },
      settings = {
        python = {
          formatting = { provider = 'black' }
        }
      },
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

end

return M

