local M = {}

local function on_attach_callback(client, bufnr)
  vim.api.nvim_buf_set_var(bufnr, "lsp_client_id", client.id)
  -- Key mappings
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-]>", "<cmd>lua vim.lsp.buf.definition()<CR>",       {silent = true;})
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gd",    "<cmd>lua vim.lsp.buf.declaration()<CR>",      {silent = true;})
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gD",    "<cmd>lua vim.lsp.buf.implementation()<CR>",   {silent = true;})
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "1gD",   "<cmd>lua vim.lsp.buf.type_definition()<CR>",  {silent = true;})
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gr",    "<cmd>lua vim.lsp.buf.references()<CR>",       {silent = true;})
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<F2>",  "<cmd>lua vim.lsp.buf.rename()<CR>",           {silent = true;})
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gQ",    "<cmd>lua vim.lsp.buf.formatting()<CR>",       {silent = true;})
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "gq",    "<cmd>lua vim.lsp.buf.range_formatting()<CR>", {silent = true;})
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "K",     "<cmd>lua vim.lsp.buf.hover()<CR>",            {silent = true;})
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>",   {silent = true;})
  -- vim.api.nvim_buf_set_keymap(bufnr, "n", "g0",    "<cmd>lua vim.lsp.buf.document_symbol()<CR>",  {silent = true;})

  -- Omni completion source
  vim.bo.omnifunc = "v:lua.vim.lsp.omnifunc"

  -- Extensions
  if vim.fn["dein#tap"]("diagnostic-nvim") ~= 0 then
    require('diagnostic').on_attach()
  end
  if vim.fn["dein#tap"]("completion-nvim") ~= 0 then
    require('completion').on_attach()
  end
end

function M.hook_add()
  -- Variables
  vim.g.enable_nvim_lsp_diagnostics   = true
  vim.g.LspDiagnosticsErrorSign       = ""
  vim.g.LspDiagnosticsWarningSign     = ""
  vim.g.LspDiagnosticsInformationSign = ""
  vim.g.LspDiagnosticsHintSign        = ""

  -- Debug mode
  --vim.lsp.set_log_level("debug")

  -- Key mappings
  local options = {noremap = true, silent = true}
  vim.api.nvim_set_keymap("n", "md", "<cmd>lua vim.lsp.buf.definition()<CR>",       options)
  vim.api.nvim_set_keymap("n", "mD", "<cmd>lua vim.lsp.buf.declaration()<CR>",      options)
  vim.api.nvim_set_keymap("n", "mi", "<cmd>lua vim.lsp.buf.implementation()<CR>",   options)
  vim.api.nvim_set_keymap("n", "mt", "<cmd>lua vim.lsp.buf.type_definition()<CR>",  options)
  vim.api.nvim_set_keymap("n", "mr", "<cmd>lua vim.lsp.buf.references()<CR>",       options)
  vim.api.nvim_set_keymap("n", "mp", "<cmd>lua vim.lsp.buf.peek_definition()<CR>",  options)
  vim.api.nvim_set_keymap("n", "mR", "<cmd>lua vim.lsp.buf.rename()<CR>",           options)
  vim.api.nvim_set_keymap("n", "mF", "<cmd>lua vim.lsp.buf.formatting()<CR>",       options)
  vim.api.nvim_set_keymap("n", "mf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", options)
  vim.api.nvim_set_keymap("x", "mf", "<cmd>lua vim.lsp.buf.range_formatting()<CR>", options)
  vim.api.nvim_set_keymap("n", "mh", "<cmd>lua vim.lsp.buf.hover()<CR>",            options)
  vim.api.nvim_set_keymap("n", "mH", "<cmd>lua vim.lsp.buf.signature_help()<CR>",   options)
  if vim.fn["dein#tap"]("nvim-lsp-denite") ~= 0 then
    vim.api.nvim_set_keymap("n", "mo", "<cmd>Denite lsp_symbols<CR>",  options)
  else
    vim.api.nvim_set_keymap("n", "mo", "<cmd>lua vim.lsp.buf.document_symbol()<CR>",  options)
  end
  -- Extensions
  if vim.fn["dein#tap"]("diagnostic-nvim") ~= 0 then
    vim.g.diagnostic_enable_virtual_text = 1
    vim.api.nvim_set_keymap("n", "m]", "<cmd>NextDiagnostic<CR>",  options)
    vim.api.nvim_set_keymap("n", "m[", "<cmd>PrevDiagnostic<CR>",  options)
    vim.api.nvim_set_keymap("n", "mq", "<cmd>OpenDiagnostic<CR>",  options)
  end

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
  require'nvim_lsp'.jedi_language_server.setup{
    on_attach = on_attach_callback;
  }
  -- require'nvim_lsp'.pyls.setup{
  --   -- cmd = { vim.env.PYENV_ROOT .. "/versions/neovim3/bin/pyls" };
  --   settings = {
  --     pyls = {
  --       plugins = {
  --         flake8 = { enabled = true };
  --         pycodestyle = { enabled = true };
  --         pydocstyle = { enabled = false };
  --         pylint = { enabled = false };
  --         yapf = { enabled = false };
  --         jedi_definition = {
  --           follow_imports = true;
  --           follow_builtin_imports = true;
  --         }
  --       }
  --     }
  --   };
  --   on_attach = on_attach_callback;
  -- }
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

