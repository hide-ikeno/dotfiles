local util = require("utils")
local M = {}

local function get_os_icon()
  local icon = ""
  if util.os.is_windows then
    icon = ""
  elseif util.os.is_mac then
    icon = ""
  else
    -- unix
    if vim.fn.executable("lsb_release") then
      local lsb = util.os.capture("lsb_release -i")
      if string.find(lsb, "Arch", 1, true) then
        icon = ""
      elseif string.find(lsb, "Ubuntu", 1, true) then
        icon = ""
      elseif string.find(lsb, "Cent", 1, true) then
        icon = ""
      elseif string.find(lsb, "Debian", 1, true) then
        icon = ""
      elseif string.find(lsb, "Dock", 1, true) then
        icon = ""
      end
    end
  end
  return icon
end

local os_icon = get_os_icon()

local default_icon = ''

local filetype_icons = {
  -- Exact Match
  ['gruntfile.coffee']   = '',
  ['gruntfile.js']       = '',
  ['gruntfile.ls']       = '',
  ['gulpfile.coffee']    = '',
  ['gulpfile.js']        = '',
  ['gulpfile.ls']        = '',
  ['mix.lock']           = '',
  ['dropbox']            = '',
  ['.ds_store']          = '',
  ['.gitconfig']         = '',
  ['.gitignore']         = '',
  ['.gitlab-ci.yml']     = '',
  ['.bashrc']            = '',
  ['.zshrc']             = '',
  ['.vimrc']             = '',
  ['.gvimrc']            = '',
  ['_vimrc']             = '',
  ['_gvimrc']            = '',
  ['.bashprofile']       = '',
  ['favicon.ico']        = '',
  ['license']            = '',
  ['node_modules']       = '',
  ['react.jsx']          = '',
  ['procfile']           = '',
  ['dockerfile']         = '',
  ['docker-compose.yml'] = '',
  -- More exact match
  ['requirements.txt']   = '',
  -- Extension
  ['styl']               = '',
  ['sass']               = '',
  ['scss']               = '',
  ['htm']                = '',
  ['html']               = '',
  ['slim']               = '',
  ['ejs']                = '',
  ['css']                = '',
  ['less']               = '',
  ['md']                 = '',
  ['mdx']                = '',
  ['markdown']           = '',
  ['rmd']                = '',
  ['json']               = '',
  ['js']                 = '',
  ['mjs']                = '',
  ['jsx']                = '',
  ['rb']                 = '',
  ['php']                = '',
  ['py']                 = '',
  ['pyc']                = '',
  ['pyo']                = '',
  ['pyd']                = '',
  ['coffee']             = '',
  ['mustache']           = '',
  ['hbs']                = '',
  ['conf']               = '',
  ['ini']                = '',
  ['yml']                = '',
  ['yaml']               = '',
  ['toml']               = '',
  ['bat']                = '',
  ['jpg']                = '',
  ['jpeg']               = '',
  ['bmp']                = '',
  ['png']                = '',
  ['gif']                = '',
  ['ico']                = '',
  ['twig']               = '',
  ['cpp']                = '',
  ['c++']                = '',
  ['cxx']                = '',
  ['cc']                 = '',
  ['cp']                 = '',
  ['c']                  = '',
  ['cs']                 = '',
  ['h']                  = '',
  ['hh']                 = '',
  ['hpp']                = '',
  ['hxx']                = '',
  ['hs']                 = '',
  ['lhs']                = '',
  ['lua']                = '',
  ['java']               = '',
  ['sh']                 = '',
  ['fish']               = '',
  ['bash']               = '',
  ['zsh']                = '',
  ['ksh']                = '',
  ['csh']                = '',
  ['awk']                = '',
  ['ps1']                = '',
  ['ml']                 = 'λ',
  ['mli']                = 'λ',
  ['diff']               = '',
  ['db']                 = '',
  ['sql']                = '',
  ['dump']               = '',
  ['clj']                = '',
  ['cljc']               = '',
  ['cljs']               = '',
  ['edn']                = '',
  ['scala']              = '',
  ['go']                 = '',
  ['dart']               = '',
  ['xul']                = '',
  ['sln']                = '',
  ['suo']                = '',
  ['pl']                 = '',
  ['pm']                 = '',
  ['t']                  = '',
  ['rss']                = '',
  ['f#']                 = '',
  ['fsscript']           = '',
  ['fsx']                = '',
  ['fs']                 = '',
  ['fsi']                = '',
  ['rs']                 = '',
  ['rlib']               = '',
  ['d']                  = '',
  ['erl']                = '',
  ['hrl']                = '',
  ['ex']                 = '',
  ['exs']                = '',
  ['eex']                = '',
  ['leex']               = '',
  ['vim']                = '',
  ['ai']                 = '',
  ['psd']                = '',
  ['psb']                = '',
  ['ts']                 = '',
  ['tsx']                = '',
  ['jl']                 = '',
  ['pp']                 = '',
  ['vue']                = '﵂',
  ['elm']                = '',
  ['swift']              = '',
  ['xcplayground']       = '',
  -- more extensions
  ['pdf']                = '',
  ['txt']                = '',
}


M.filetype_icons = setmetatable(filetype_icons,{
    __index = function(filetype_icons, key)
      -- get extension
      local ext = key:match("^.+%.(.+)$")
      if ext then
        return filetype_icons[ext]
      end
      return default_icon
    end
  })

M.fileformat_icons = {
  ['dos']  = '',
  ['mac']  = '',
  ['unix'] = os_icon,
}

return M

