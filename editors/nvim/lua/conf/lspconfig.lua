local M = {}
local path = require("utils").path

local function make_on_attach(config)
  return function(client)
    if config.before then
      config.before(client)
    end

    -- omni completion source
    vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

    -- key mappings
    local opt1 = {noremap = true, silent = true}
    local opt2 = {noremap = true, silent = true, nowait = true}
    vim.api.nvim_buf_set_keymap(0, "n", "ma", "<cmd>Lspsaga code_action<CR>", opt1)
    vim.api.nvim_buf_set_keymap(0, "v", "ma", ":<C-u>Lspsaga range_code_action<CR>", opt1)
    vim.api.nvim_buf_set_keymap(0, "n", "md", "<cmd>Lspsaga lsp_finder<CR>",      opt1)
    vim.api.nvim_buf_set_keymap(0, "n", "mD", "<cmd>lua vim.lsp.buf.declaration()<CR>",     opt1)
    vim.api.nvim_buf_set_keymap(0, "n", "mi", "<cmd>lua vim.lsp.buf.implementation()<CR>",  opt1)
    vim.api.nvim_buf_set_keymap(0, "n", "mt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opt1)
    -- vim.api.nvim_buf_set_keymap(0, "n", "mr", "<cmd>lua vim.lsp.buf.references()<CR>",      opt1)
    vim.api.nvim_buf_set_keymap(0, "n", "mp", "<cmd>Lspsaga preview_definition<CR>", opt1)
    vim.api.nvim_buf_set_keymap(0, "n", "mR", "<cmd>Lspsaga rename<CR>",          opt1)
    vim.api.nvim_buf_set_keymap(0, "n", "mh", "<cmd>Lspsaga hover_doc<CR>",  opt1)
    -- vim.api.nvim_buf_set_keymap(0, "n", "<C-f>", "<cmd>lua require'lspsaga.hover'.smart_scroll_hover(1)<CR>", opt2)
    -- vim.api.nvim_buf_set_keymap(0, "n", "<c-b>", "<cmd>lua require'lspsaga.hover'.smart_scroll_hover(-1)<cr>", opt2)
    vim.api.nvim_buf_set_keymap(0, "n", "mo", "<cmd>lua vim.lsp.buf.document_symbol()<cr>", opt1)
    vim.api.nvim_buf_set_keymap(0, "n", "m?", "<cmd>lspsaga show_line_diagnostics<cr>", opt1)
    vim.api.nvim_buf_set_keymap(0, "n", "m]", "<cmd>Lspsaga diagnostic_jump_next<CR>", opt1)
    vim.api.nvim_buf_set_keymap(0, "n", "m[", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opt1)
    vim.api.nvim_buf_set_keymap(0, "n", "me", "<cmd>Lspsaga show_line_diagnostics<CR>", opt1)
    vim.api.nvim_buf_set_keymap(0, "n", "m?", "<cmd>Lspsaga signature_help<CR>", opt1)

    vim.cmd[[augroup nvim_lspconfig_user_autocmds]]
    vim.cmd[[autocmd! * <buffer>]]
    vim.cmd[[augroup end]]
    -- formatting
    if client.resolved_capabilities.document_formatting then
      vim.cmd[[autocmd nvim_lspconfig_user_autocmds BufWritePre <buffer> lua vim.lsp.buf.formatting_sync(nil,1000)]]
    end
    if client.resolved_capabilities.document_range_formatting then
      vim.api.nvim_buf_set_keymap(0, "n", "m=", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opt1)
      vim.api.nvim_buf_set_keymap(0, "x", "m=", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", opt1)
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
  -- local lsp_status = require("lsp-status")
  -- lsp_status.register_progress()
  local lspsaga = require("lspsaga")
  lspsaga.init_lsp_saga()

  -- Setup language servers
  local servers = {
    bashls = {},
    clangd = {
      cmd = {
        'clangd', -- '--background-index',
        '--clang-tidy',
        '--completion-style=bundled',
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
    vimls = {},
    yamlls = {},
  }

  local system_name
  if vim.fn.has("mac") == 1 then
    system_name = "macOS"
  elseif vim.fn.has("unix") == 1 then
    system_name = "Linux"
  elseif vim.fn.has('win32') == 1 then
    system_name = "Windows"
  else
    print("Unsupported system for sumneko")
  end
  -- set the path to the sumneko installation; if you previously installed via the now deprecated :LspInstall, use
  local sumneko_root_path = vim.fn.expand('$HOME/src/github.com/sumneko/lua-language-server')
  local sumneko_binary = path.join(sumneko_root_path, "bin", system_name, "lua-language-server")
  servers.sumneko_lua = {
    cmd = {sumneko_binary, "-E", path.join(sumneko_root_path, "main.lua") },
    settings = {
      Lua = {
        diagnostics = {
          globals = {'vim'}
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

end

return M

