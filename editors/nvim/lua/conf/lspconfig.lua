local M = {}
local globals = require("core.globals")

local function make_on_attach(config)
  return function(client)
    if config.before then
      config.before(client)
    end

    -- omni completion source
    vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

    -- key mappings
    local buf_keymap = vim.api.nvim_buf_set_keymap
    local opt1 = {noremap = true, silent = true}
    local opt2 = {noremap = true, silent = true, nowait = true}

    buf_keymap(0, "n", "<C-f>", "<cmd>lua require'lspsaga.action'.smart_scroll_with_saga(1)<CR>", opt2)
    buf_keymap(0, "n", "<C-b>", "<cmd>lua require'lspsaga.action'.smart_scroll_with_saga(-1)<CR>", opt2)
    buf_keymap(0, "n", "ma", "<cmd>Lspsaga code_action<CR>", opt1)
    buf_keymap(0, "v", "ma", ":<C-u>Lspsaga range_code_action<CR>", opt1)
    buf_keymap(0, "n", "md", "<cmd>Lspsaga preview_definition<CR>", opt1)
    buf_keymap(0, "n", "mf", "<cmd>Lspsaga lsp_finder<CR>",      opt1)
    buf_keymap(0, "n", "mh", "<cmd>Lspsaga hover_doc<CR>",  opt1)
    buf_keymap(0, "n", "m?", "<cmd>Lspsaga signature_help<CR>", opt1)
    buf_keymap(0, "n", "mR", "<cmd>Lspsaga rename<CR>",          opt1)
    buf_keymap(0, "n", "m]", "<cmd>Lspsaga diagnostic_jump_next<CR>", opt1)
    buf_keymap(0, "n", "m[", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opt1)
    buf_keymap(0, "n", "me", "<cmd>Lspsaga show_line_diagnostics<CR>", opt1)

    buf_keymap(0, "n", "mD", "<cmd>lua vim.lsp.buf.declaration()<CR>",     opt1)
    buf_keymap(0, "n", "mi", "<cmd>lua vim.lsp.buf.implementation()<CR>",  opt1)
    buf_keymap(0, "n", "mt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opt1)
    buf_keymap(0, "n", "mr", "<cmd>lua vim.lsp.buf.references()<CR>",      opt1)
    buf_keymap(0, "n", "mo", "<cmd>lua vim.lsp.buf.document_symbol()<cr>", opt1)

    vim.cmd[[augroup user_plugin_lspconfig]]
    vim.cmd[[autocmd! * <buffer>]]
    vim.cmd[[augroup end]]
    -- formatting
    if client.resolved_capabilities.document_formatting then
      vim.cmd[[autocmd user_plugin_lspconfig BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil,1000)]]
    end
    if client.resolved_capabilities.document_range_formatting then
      vim.api.nvim_buf_set_keymap(0, "n", "m=", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opt1)
      vim.api.nvim_buf_set_keymap(0, "x", "m=", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opt1)
    end

    -- automatic highlight
    if client.resolved_capabilities.document_highlight then
      vim.cmd[[autocmd user_plugin_lspconfig CursorHold  <buffer> lua vim.lsp.buf.document_highlight()]]
      vim.cmd[[autocmd user_plugin_lspconfig CursorMoved <buffer> lua vim.lsp.buf.clear_references()]]
    end
    if config.after then
      config.after(client)
    end
  end
end

function M.config()
  -- [[ Configure builtin lsp]]
  local sign_define = vim.fn.sign_define
  sign_define("LspDiagnosticsErrorSign",       { text = "", texthl = "LspDiagnosticError"      })
  sign_define("LspDiagnosticsWarningSign",     { text = "", texthl = "LspDiagnosticWarning"    })
  sign_define("LspDiagnosticsInformationSign", { text = "", texthl = "LspDiagnosticInformtion" })
  sign_define("LspDiagnosticsHintSign",        { text = "", texthl = "LspDiagnosticHint"       })

  vim.lsp.protocol.CompletionItemKind = {
    " [text]",
    "Ƒ [method]",
    " [function]",
    " [constructor]",
    "ﰠ [field]",
    " [variable]",
    " [class]",
    " [interface]",
    " [module]",
    " [property]",
    " [unit]",
    " [value]",
    " [enum]",
    " [key]",
    "﬌ [snippet]",
    " [color]",
    " [file]",
    " [reference]",
    " [folder]",
    " [enum member]",
    " [constant]",
    " [struct]",
    "⌘ [event]",
    " [operator]",
    "♛ [type]"
  }

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

  local lspconfig  = require("lspconfig")
  -- local lsp_status = require("lsp-status")
  -- lsp_status.register_progress()
  local lspsaga = require("lspsaga")
  lspsaga.init_lsp_saga()

  -- Setup language servers
  local servers = {
    bashls = {},
    clangd = {
      cmd = {
        'clangd',
        '--background-index',
        '--clang-tidy',
        -- '--completion-style=bundled',
        '--header-insertion=iwyu',
        '--suggest-missing-includes',
        '--cross-file-rename'
      },
      -- handlers = lsp_status.extensions.clangd.setup(),
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
      init_options = {
        documentFormatting = true,
        hover = true,
        documentSymbol = true,
        codeAction = true,
        completion = true,
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
    -- julials = {},
    pyright = {
      settings = {
        python = {
          formatting = { provider = 'black' }
        }
      },
    },
    rust_analyzer = {},
    solargraph = {},
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
      -- "keep", config.capabilities or {}, lsp_status.capabilities, snippet_capabilities
      "keep", config.capabilities or {}, snippet_capabilities
      )

    lspconfig[server].setup(config)
  end

  -- Lua language server
  local system_name
  if globals.is_mac then
    system_name = "macOS"
  elseif globals.is_linux then
    system_name = "Linux"
  elseif globals.is_windows then
    system_name = "Windows"
  else
    print("Unsupported system for sumneko")
  end
  local sumneko_root_path = vim.fn.expand('$HOME/src/github.com/sumneko/lua-language-server')
  local sumneko_binary = string.format("%s/bin/%s/lua-language-server", sumneko_root_path, system_name)
  lspconfig.sumneko_lua.setup {
    cmd = {sumneko_binary, "-E", sumneko_root_path.."/main.lua" },
    on_attach = make_on_attach({}),
    settings = {
      Lua = {
        diagnostics = {
          globals = {'vim', "packer_plugins"}
        },
        runtime = {
          version = 'LuaJIT',
          path = vim.split(package.path, ";")
        },
        workspace = {
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
          }
        }
      }
    }
  }

end

return M

