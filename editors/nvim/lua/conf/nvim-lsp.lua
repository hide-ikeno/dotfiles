local M = {}

local nvim_lsp   = require("nvim_lsp")
local lsp_status = require("lsp-status")
local diagnostic = require("diagnostic")

local function on_attach_callback(client)
  -- Omni completion source
  vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"
  lsp_status.on_attach(client)
  diagnostic.on_attach()
end

local servers = {
  bashls = {},
  clangd = {
    cmd = {
      'clangd', -- '--background-index',
      '--clang-tidy', '--completion-style=bundled', '--header-insertion=iwyu',
      '--suggest-missing-includes', '--cross-file-rename'
    },
    callbacks = lsp_status.extensions.clangd.setup(),
    capabilities = {
      textDocument = {
        completion = {
          completionItem = {
            snippetSupport = true
          }
        }
      }
    },
    init_options = {
      clangdFileStatus = true,
      usePlaceholders = true,
      completeUnimported = true
    }
  },
  cssls = {
    filetypes = {"css", "scss", "less", "sass"},
    root_dir = nvim_lsp.util.root_pattern("package.json", ".git")
  },
}

function M.setup()
  -- Variables
  vim.g.enable_nvim_lsp_diagnostics   = true
  vim.g.LspDiagnosticsErrorSign       = ""
  vim.g.LspDiagnosticsWarningSign     = ""
  vim.g.LspDiagnosticsInformationSign = ""
  vim.g.LspDiagnosticsHintSign        = ""

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

  -- auto commands

  vim.cmd("augroup user-plugin-nvim-lsp")
  vim.cmd("autocmd!")
  vim.cmd("autocmd FileType c,cpp,objc,objcpp lua require('plugins.nvim-lsp')._on_filetype_c_cpp()")
  vim.cmd("autocmd FileType fortran           lua require('plugins.nvim-lsp')._on_filetype_fortran()")
  vim.cmd("autocmd FileType go                lua require('plugins.nvim-lsp')._on_filetype_go()")
  vim.cmd("autocmd FileType lua               lua require('plugins.nvim-lsp')._on_filetype_lua()")
  vim.cmd("autocmd FileType python            lua require('plugins.nvim-lsp')._on_filetype_python()")
  vim.cmd("autocmd FileType ruby              lua require('plugins.nvim-lsp')._on_filetype_ruby()")
  vim.cmd("autocmd FileType rust              lua require('plugins.nvim-lsp')._on_filetype_rust()")
  vim.cmd("autocmd FileType sh                lua require('plugins.nvim-lsp')._on_filetype_sh()")
  vim.cmd("autocmd FileType vim               lua require('plugins.nvim-lsp')._on_filetype_vim()")
  vim.cmd("autocmd FileType yaml              lua require('plugins.nvim-lsp')._on_filetype_yaml()")
  local efm_ft = {
    "eruby", "vim", "make", "markdown", "rst", "yaml", "python",
    "dockerfile", "javascript", "php", "html", "css", "json", "csv"
  }
  vim.cmd("autocmd FileType " .. table.concat(efm_ft, ",") .. " lua require('plugins.nvim-lsp')._configure_efm()")
  vim.cmd("augroup end")
end

function M._on_filetype_c_cpp()
  require'nvim_lsp'.clangd.setup{
    cmd = {"clangd", "--background-index"};
    on_attach = on_attach_callback;
  }
end

function M._on_filetype_fortran()
  require'nvim_lsp'.dockerls.setup{
    on_attach = on_attach_callback;
  }
end

function M._on_filetype_fortran()
  require'nvim_lsp'.fortls.setup{
    on_attach = on_attach_callback;
  }
end

function M._on_filetype_go()
  require'nvim_lsp'.gopls.setup{
    capabilities = {
      textDocument = {
        completion = {
          completionItem = {
            snippetSupport = true
          }
        }
      }
    };
    init_options = {
      usePlaceholders = true,
      completeUnimported = true
    };
    on_attach = on_attach_callback;
  }
end

function M._on_filetype_lua()
  require'nvim_lsp'.sumneko_lua.setup{
    on_attach = on_attach_callback
  }
end

function M._on_filetype_python()
  -- require'nvim_lsp'.jedi_language_server.setup{
  --   on_attach = on_attach_callback;
  -- }
  require'nvim_lsp'.pyls.setup{
    -- cmd = { vim.env.PYENV_ROOT .. "/versions/neovim3/bin/pyls" };
    settings = {
      pyls = {
        plugins = {
          flake8 = { enabled = true };
          pycodestyle = { enabled = true };
          pydocstyle = { enabled = false };
          pylint = { enabled = false };
          yapf = { enabled = false };
          jedi_definition = {
            follow_imports = true;
            follow_builtin_imports = true;
          }
        }
      }
    };
    on_attach = on_attach_callback;
  }
end

function M._on_filetype_ruby()
  require'nvim_lsp'.solargraph.setup{
    on_attach = on_attach_callback
  }
end

function M._on_filetype_rust()
  if vim.fn.executable("rust-analylzer") then
    require'nvim_lsp'.rls.setup{
      on_attach = on_attach_callback
    }
  else
    require'nvim_lsp'.rls.setup{
      cmd = {"rustup", "run", "stable", "rls"};
      settings = {
        rust = {
          enableMultiProjectSetup = true;
          all_features = true;
          all_targets = true;
          full_docs = true;
          jobs = 2;
          unstable_features = true;
          wait_to_build = 1500;
        };
      };
      on_attach = on_attach_callback
    }
  end
end

function M._on_filetype_sh()
  require'nvim_lsp'.bashls.setup{
    on_attach = on_attach_callback
  }
end

function M._on_filetype_sh()
  require'nvim_lsp'.texlab.setup{
    on_attach = on_attach_callback
  }
end

function M._on_filetype_vim()
  require'nvim_lsp'.vimls.setup{
    on_attach = on_attach_callback
  }
end

function M._on_filetype_yaml()
  require'nvim_lsp'.yamlls.setup{
    on_attach = on_attach_callback
  }
end

function M._configure_efm()
  require'nvim_lsp'.efm.setup{
    on_attach = on_attach_callback
  }
end

return M

