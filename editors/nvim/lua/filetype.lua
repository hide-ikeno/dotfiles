local M = {}

function M.setup()
  --- Global options for filetypes
  -- Bash
  vim.g.is_bash = 1
  vim.g.sh_fold_enabled = 1

  -- C++
  vim.g.cpp_class_scope_highlight = 1

  -- Markdown
  vim.g.markdown_fenced_languages = {
    'css', 'javascript', 'js=javascript', 'json=javascript',
    'python', 'py=python', 'rust', 'sh', 'sass', 'xml', 'vim', 'help'
  }

  -- Perl
  vim.g.perl_fold   = 1
  vim.g.perl_blocks = 1

  -- php
  vim.g.php_folding = 1

  -- Python
  vim.g.python_highlight_all = 1

  -- Ruby
  vim.g.ruby_fold = 1

  -- TeX
  vim.g.tex_stylish = 1
  vim.g.tex_conceal = ""
  vim.g.tex_flavor  = "latex"
  vim.g.tex_isk     = "48-57,a-z,A-Z,192-255,:"
  vim.g.tex_fold_enabled = 1

  -- XML
  vim.g.xml_syntax_folding = 1

  --- Register filetype events
  vim.cmd("augroup user_filetype_event")
  vim.cmd("autocmd!")
  vim.cmd("autocmd FileType *       lua require('filetype').ftplugin_common()")
  vim.cmd("autocmd FileType c,cpp   lua require('filetype').ftplugin_c_cpp()")
  vim.cmd("autocmd FileType fortran lua require('filetype').ftplugin_fortran()")
  vim.cmd("autocmd FileType ruby    lua require('filetype').ftplugin_ruby()")
  vim.cmd("autocmd FileType toml    lua require('filetype').ftplugin_toml()")
  vim.cmd("autocmd FileType vim     lua require('filetype').ftplugin_vim()")
  vim.cmd("augroup END")
end

--- ftplugin
-- common
function M.ftplugin_common()
  vim.bo.formatoptions = "jtcqmMBl"

  if not vim.bo.modifiable then
    vim.wo.foldenable  = false
    vim.wo.foldcolumn  = "0"
    vim.wo.colorcolumn = ""
  end
end

-- C/C++
function M.ftplugin_c_cpp()
  vim.bo.foldignore = "#/"
end

-- Fortran
function M.ftplugin_fortran()
  local ext = vim.fn.expand("%:e")
  if ext == "f" or ext == "for" then
    vim.bo.fortran_free_source  = 0
    vim.bo.fortran_fixed_source = 1
  else
    vim.bo.fortran_free_source  = 1
    vim.bo.fortran_fixed_source = 0
  end
  vim.bo.fortran_fold              = 1
  vim.bo.fortran_fold_conditionals = 1
  vim.bo.fortran_do_enddo          = 1
end

-- Ruby
function M.ftplugin_ruby()
  vim.bo.iskeyword = vim.bo.iskeyword .. ",!,?"
end

-- TOML
function M.ftplugin_toml()
  vim.cmd("syntax sync minlines=500")
end

-- VIM
function M.ftplugin_vim()
  if vim.fn.line("$") > 5000 then
    vim.cmd("syntax sync minlines=500")
  end
  vim.wo.foldmethod = "indent"
end

-- VIM help
function M.ftplugin_help()
  vim.bo.iskeyword = vim.bo.iskeyword .. ",:,#,-"
end

return M
