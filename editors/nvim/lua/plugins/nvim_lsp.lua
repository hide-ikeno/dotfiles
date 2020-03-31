local M = {}

local function on_attach_callback(client, bufnr)
  vim.api.nvim_buf_set_var(bufnr, "lsp_client_id", client.id)
  -- Key mappings
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-]>", "<cmd>lua vim.lsp.buf.definition()<CR>",       {silent = true;})
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gd",    "<cmd>lua vim.lsp.buf.declaration()<CR>",      {silent = true;})
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gD",    "<cmd>lua vim.lsp.buf.implementation()<CR>",   {silent = true;})
  vim.api.nvim_buf_set_keymap(bufnr, "n", "1gD",   "<cmd>lua vim.lsp.buf.type_definition()<CR>",  {silent = true;})
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gr",    "<cmd>lua vim.lsp.buf.references()<CR>",       {silent = true;})
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<F2>",  "<cmd>lua vim.lsp.buf.rename()<CR>",           {silent = true;})
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gQ",    "<cmd>lua vim.lsp.buf.formatting()<CR>",       {silent = true;})
  vim.api.nvim_buf_set_keymap(bufnr, "n", "gq",    "<cmd>lua vim.lsp.buf.range_formatting()<CR>", {silent = true;})
  vim.api.nvim_buf_set_keymap(bufnr, "n", "K",     "<cmd>lua vim.lsp.buf.hover()<CR>",            {silent = true;})
  vim.api.nvim_buf_set_keymap(bufnr, "n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>",   {silent = true;})
  vim.api.nvim_buf_set_keymap(bufnr, "n", "g0",    "<cmd>lua vim.lsp.buf.document_symbol()<CR>",  {silent = true;})
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
  vim.api.nvim_set_keymap("n", "mh", "<cmd>lua vim.lsp.buf.hover()<CR>",            options)
  vim.api.nvim_set_keymap("n", "mH", "<cmd>lua vim.lsp.buf.signature_help()<CR>",   options)
  vim.api.nvim_set_keymap("n", "mo", "<cmd>lua vim.lsp.buf.document_symbol()<CR>",  options)
  -- Extensions
  if vim.fn["dein#tap"]("diagnostic-nvim") ~= 0 then
    vim.g.diagnostic_enable_virtual_text = 1
    vim.api.nvim_set_keymap("n", "m]", "<cmd>NextDiagnostic<CR>",  options)
    vim.api.nvim_set_keymap("n", "m[", "<cmd>PrevDiagnostic<CR>",  options)
    vim.api.nvim_set_keymap("n", "mq", "<cmd>OpenDiagnostic<CR>",  options)
  end
end

function M.hook_post_source()
  vim.lsp.set_log_level("debug")

  -- vim.lsp.callbacks['textDocument/publishDiagnostics'] = function(_, _, result)
  --   if vim.g.enable_nvim_lsp_diagnostics then
  --     local util = vim.lsp.util
  --     if not result then return end
  --     local uri = result.uri
  --     local bufnr = vim.uri_to_bufnr(uri)
  --     if not bufnr then
  --       err_message("LSP.publishDiagnostics: Couldn't find buffer for ", uri)
  --       return
  --     end
  --     util.buf_clear_diagnostics(bufnr)
  --     util.buf_diagnostics_save_positions(bufnr, result.diagnostics)
  --     util.buf_diagnostics_virtual_text(bufnr, result.diagnostics)
  --     util.buf_diagnostics_signs(bufnr, result.diagnostics)
  --     -- util.set_loclist(result.diagnostics)
  --   end
  -- end

  -- LSP setup

  local nvim_lsp = require'nvim_lsp'
  nvim_lsp.ccls.setup{
    on_attach = on_attach_callback
  }

  nvim_lsp.fortls.setup{
    on_attach = on_attach_callback
  }

  nvim_lsp.gopls.setup{
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
      usePlaceholders = true,
      completeUnimported = true
    },
    on_attach = on_attach_callback
  }

  nvim_lsp.flow.setup{
    on_attach = on_attach_callback
  }

  nvim_lsp.sumneko_lua.setup{
    on_attach = on_attach_callback
  }

  nvim_lsp.pyls.setup{
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

  nvim_lsp.solargraph.setup{
    on_attach = on_attach_callback
  }

  nvim_lsp.rls.setup{
    cmd = {"rustup", "run", "nightly", "rls"};
    settings = {
      rls = {
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

   nvim_lsp.bashls.setup{
     on_attach = on_attach_callback
   }

   nvim_lsp.texlab.setup{
     on_attach = on_attach_callback
   }

   nvim_lsp.tsserver.setup{
     on_attach = on_attach_callback
   }

   nvim_lsp.vimls.setup{
     on_attach = on_attach_callback
   }

   nvim_lsp.yamlls.setup{
     on_attach = on_attach_callback
   }
end

function M.get_language_client_status()
  vim.inspect(vim.lsp.get_client_by_id(1))
end

return M

