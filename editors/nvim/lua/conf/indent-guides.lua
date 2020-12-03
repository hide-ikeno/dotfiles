local M = {}

function M.config()
  require('indent_guides').default_opts = {
    indent_levels = 30;
    indent_guide_size = 0;
    indent_start_level = 2;
    indent_space_guides = true;
    indent_tab_guides = true;
    indent_pretty_guides = false;
    indent_soft_pattern = '\\s';
    exclude_filetypes = {
      "help", "denite", "denite-filter", "startify", "vista", "vista_kind", "tagbar"
    }
  }
end

return M