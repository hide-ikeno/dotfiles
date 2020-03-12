--[[ Porting Iceberg color scheme for vim by cocopon
     (https://github.com/cocopon/iceberg.vim) ]]

local vim = vim or {}

-- Initialization
if not vim.fn.has("gui_running") and vim.o.t_Co < 256 then
  return
end

vim.o.background = "dark"
vim.api.nvim_command("highlight clear")

if vim.fn.exists("syntax_on") then
  vim.api.nvim_command("syntax reset")
end

-- vim.g.colors_name = "iceberg"

-- Colors for terminal
if vim.fn.has("nvim") then
  vim.g.terminal_color_0  = "#1e2132"
  vim.g.terminal_color_1  = "#e27878"
  vim.g.terminal_color_2  = "#b4be82"
  vim.g.terminal_color_3  = "#e2a478"
  vim.g.terminal_color_4  = "#84a0c6"
  vim.g.terminal_color_5  = "#a093c7"
  vim.g.terminal_color_6  = "#89b8c2"
  vim.g.terminal_color_7  = "#c6c8d1"
  vim.g.terminal_color_8  = "#6b7089"
  vim.g.terminal_color_9  = "#e98989"
  vim.g.terminal_color_10 = "#c0ca8e"
  vim.g.terminal_color_11 = "#e9b189"
  vim.g.terminal_color_12 = "#91acd1"
  vim.g.terminal_color_13 = "#ada0d3"
  vim.g.terminal_color_14 = "#95c4ce"
  vim.g.terminal_color_15 = "#d2d4de"
else
  vim.g.terminal_ansi_colors = {
    "#1e2132", "#e27878", "#b4be82", "#e2a478", "#84a0c6", "#a093c7", "#89b8c2", "#c6c8d1",
    "#6b7089", "#e98989", "#c0ca8e", "#e9b189", "#91acd1", "#ada0d3", "#95c4ce", "#d2d4de"
    }
end

-- highlight groups
vim.api.nvim_command("highlight! ColorColumn               cterm=NONE ctermbg=235 guibg=#1e2132")
vim.api.nvim_command("highlight! CursorColumn              cterm=NONE ctermbg=235 guibg=#1e2132")
vim.api.nvim_command("highlight! CursorLine                cterm=NONE ctermbg=235 guibg=#1e2132")
vim.api.nvim_command("highlight! Comment                   ctermfg=242 guifg=#6b7089")
vim.api.nvim_command("highlight! Constant                  ctermfg=140 guifg=#a093c7")
vim.api.nvim_command("highlight! Cursor                    ctermbg=252 ctermfg=234 guibg=#c6c8d1 guifg=#161821")
vim.api.nvim_command("highlight! CursorLineNr              ctermbg=237 ctermfg=253 guibg=#2a3158 guifg=#cdd1e6")
vim.api.nvim_command("highlight! Delimiter                 ctermfg=252 guifg=#c6c8d1")
vim.api.nvim_command("highlight! DiffAdd                   ctermbg=29 ctermfg=158 guibg=#45493e guifg=#c0c5b9")
vim.api.nvim_command("highlight! DiffChange                ctermbg=23 ctermfg=159 guibg=#384851 guifg=#b3c3cc")
vim.api.nvim_command("highlight! DiffDelete                ctermbg=95 ctermfg=224 guibg=#53343b guifg=#ceb0b6")
vim.api.nvim_command("highlight! DiffText                  cterm=NONE ctermbg=30 ctermfg=195 gui=NONE guibg=#5b7881 guifg=#c6c8d1")
vim.api.nvim_command("highlight! Directory                 ctermfg=109 guifg=#89b8c2")
vim.api.nvim_command("highlight! Error                     ctermbg=234 ctermfg=203 guibg=#161821 guifg=#e27878")
vim.api.nvim_command("highlight! ErrorMsg                  ctermbg=234 ctermfg=203 guibg=#161821 guifg=#e27878")
vim.api.nvim_command("highlight! WarningMsg                ctermbg=234 ctermfg=203 guibg=#161821 guifg=#e27878")
vim.api.nvim_command("highlight! EndOfBuffer               ctermbg=234 ctermfg=236 guibg=#161821 guifg=#242940")
vim.api.nvim_command("highlight! NonText                   ctermbg=234 ctermfg=236 guibg=#161821 guifg=#242940")
vim.api.nvim_command("highlight! SpecialKey                ctermbg=234 ctermfg=236 guibg=#161821 guifg=#242940")
vim.api.nvim_command("highlight! Folded                    ctermbg=235 ctermfg=245 guibg=#1e2132 guifg=#686f9a")
vim.api.nvim_command("highlight! FoldColumn                ctermbg=235 ctermfg=239 guibg=#1e2132 guifg=#444b71")
vim.api.nvim_command("highlight! Function                  ctermfg=110 guifg=#84a0c6")
vim.api.nvim_command("highlight! Identifier                cterm=NONE ctermfg=109 guifg=#89b8c2")
vim.api.nvim_command("highlight! Include                   ctermfg=110 guifg=#84a0c6")
vim.api.nvim_command("highlight! LineNr                    ctermbg=235 ctermfg=239 guibg=#1e2132 guifg=#444b71")
vim.api.nvim_command("highlight! MatchParen                ctermbg=237 ctermfg=255 guibg=#3e445e guifg=#ffffff")
vim.api.nvim_command("highlight! MoreMsg                   ctermfg=150 guifg=#b4be82")
vim.api.nvim_command("highlight! Normal                    ctermbg=234 ctermfg=252 guibg=#161821 guifg=#c6c8d1")
vim.api.nvim_command("highlight! Operator                  ctermfg=110 guifg=#84a0c6")
vim.api.nvim_command("highlight! Pmenu                     ctermbg=236 ctermfg=251 guibg=#3d425b guifg=#c6c8d1")
vim.api.nvim_command("highlight! PmenuSbar                 ctermbg=236 guibg=#3d425b")
vim.api.nvim_command("highlight! PmenuSel                  ctermbg=240 ctermfg=255 guibg=#5b6389 guifg=#eff0f4")
vim.api.nvim_command("highlight! PmenuThumb                ctermbg=251 guibg=#c6c8d1")
vim.api.nvim_command("highlight! PreProc                   ctermfg=150 guifg=#b4be82")
vim.api.nvim_command("highlight! Question                  ctermfg=150 guifg=#b4be82")
vim.api.nvim_command("highlight! QuickFixLine              ctermbg=236 ctermfg=252 guibg=#272c42 guifg=#c6c8d1")
vim.api.nvim_command("highlight! Search                    ctermbg=216 ctermfg=234 guibg=#e4aa80 guifg=#392313")
vim.api.nvim_command("highlight! SignColumn                ctermbg=235 ctermfg=239 guibg=#1e2132 guifg=#444b71")
vim.api.nvim_command("highlight! Special                   ctermfg=150 guifg=#b4be82")
vim.api.nvim_command("highlight! SpellBad                  ctermbg=95 ctermfg=252 gui=undercurl guisp=#e27878")
vim.api.nvim_command("highlight! SpellCap                  ctermbg=24 ctermfg=252 gui=undercurl guisp=#84a0c6")
vim.api.nvim_command("highlight! SpellLocal                ctermbg=23 ctermfg=252 gui=undercurl guisp=#89b8c2")
vim.api.nvim_command("highlight! SpellRare                 ctermbg=97 ctermfg=252 gui=undercurl guisp=#a093c7")
vim.api.nvim_command("highlight! Statement                 ctermfg=110 gui=NONE guifg=#84a0c6")
vim.api.nvim_command("highlight! StatusLine                cterm=reverse ctermbg=234 ctermfg=245 gui=reverse guibg=#17171b guifg=#818596 term=reverse")
vim.api.nvim_command("highlight! StatusLineTerm            cterm=reverse ctermbg=234 ctermfg=245 gui=reverse guibg=#17171b guifg=#818596 term=reverse")
vim.api.nvim_command("highlight! StatusLineNC              cterm=reverse ctermbg=238 ctermfg=233 gui=reverse guibg=#3e445e guifg=#0f1117")
vim.api.nvim_command("highlight! StatusLineTermNC          cterm=reverse ctermbg=238 ctermfg=233 gui=reverse guibg=#3e445e guifg=#0f1117")
vim.api.nvim_command("highlight! StorageClass              ctermfg=110 guifg=#84a0c6")
vim.api.nvim_command("highlight! String                    ctermfg=109 guifg=#89b8c2")
vim.api.nvim_command("highlight! Structure                 ctermfg=110 guifg=#84a0c6")
vim.api.nvim_command("highlight! TabLine                   cterm=NONE ctermbg=233 ctermfg=238 gui=NONE guibg=#0f1117 guifg=#3e445e")
vim.api.nvim_command("highlight! TabLineFill               cterm=reverse ctermbg=238 ctermfg=233 gui=reverse guibg=#3e445e guifg=#0f1117")
vim.api.nvim_command("highlight! TabLineSel                cterm=NONE ctermbg=234 ctermfg=252 gui=NONE guibg=#161821 guifg=#9a9ca5")
vim.api.nvim_command("highlight! TermCursorNC              ctermbg=242 ctermfg=234 guibg=#6b7089 guifg=#161821")
vim.api.nvim_command("highlight! Title                     ctermfg=216 gui=NONE guifg=#e2a478")
vim.api.nvim_command("highlight! Todo                      ctermbg=234 ctermfg=150 guibg=#45493e guifg=#b4be82")
vim.api.nvim_command("highlight! Type                      ctermfg=110 gui=NONE guifg=#84a0c6")
vim.api.nvim_command("highlight! Underlined                cterm=underline ctermfg=110 gui=underline guifg=#84a0c6 term=underline")
vim.api.nvim_command("highlight! VertSplit                 cterm=NONE ctermbg=233 ctermfg=233 gui=NONE guibg=#0f1117 guifg=#0f1117")
vim.api.nvim_command("highlight! Visual                    ctermbg=236 guibg=#272c42")
vim.api.nvim_command("highlight! WildMenu                  ctermbg=255 ctermfg=234 guibg=#d4d5db guifg=#17171b")
vim.api.nvim_command("highlight! diffAdded                 ctermfg=150 guifg=#b4be82")
vim.api.nvim_command("highlight! diffRemoved               ctermfg=203 guifg=#e27878")
vim.api.nvim_command("highlight! ALEErrorSign              ctermbg=235 ctermfg=203 guibg=#1e2132 guifg=#e27878")
vim.api.nvim_command("highlight! ALEWarningSign            ctermbg=235 ctermfg=216 guibg=#1e2132 guifg=#e2a478")
vim.api.nvim_command("highlight! ALEVirtualTextError       ctermfg=203 guifg=#e27878")
vim.api.nvim_command("highlight! ALEVirtualTextWarning     ctermfg=216 guifg=#e2a478")
vim.api.nvim_command("highlight! CtrlPMode1                ctermbg=236 ctermfg=242 guibg=#2e313f guifg=#6b7089")
vim.api.nvim_command("highlight! EasyMotionShade           ctermfg=239 guifg=#3d425b")
vim.api.nvim_command("highlight! EasyMotionTarget          ctermfg=150 guifg=#b4be82")
vim.api.nvim_command("highlight! EasyMotionTarget2First    ctermfg=216 guifg=#e2a478")
vim.api.nvim_command("highlight! EasyMotionTarget2Second   ctermfg=216 guifg=#e2a478")
vim.api.nvim_command("highlight! GitGutterAdd              ctermbg=235 ctermfg=150 guibg=#1e2132 guifg=#b4be82")
vim.api.nvim_command("highlight! GitGutterChange           ctermbg=235 ctermfg=109 guibg=#1e2132 guifg=#89b8c2")
vim.api.nvim_command("highlight! GitGutterChangeDelete     ctermbg=235 ctermfg=109 guibg=#1e2132 guifg=#89b8c2")
vim.api.nvim_command("highlight! GitGutterDelete           ctermbg=235 ctermfg=203 guibg=#1e2132 guifg=#e27878")
vim.api.nvim_command("highlight! gitmessengerEndOfBuffer   ctermbg=235 ctermfg=239 guibg=#1e2132 guifg=#444b71")
vim.api.nvim_command("highlight! gitmessengerPopupNormal   ctermbg=235 ctermfg=252 guibg=#1e2132 guifg=#c6c8d1")
vim.api.nvim_command("highlight! Sneak                     ctermbg=140 ctermfg=234 guibg=#a093c7 guifg=#161821")
vim.api.nvim_command("highlight! SneakScope                ctermbg=236 ctermfg=242 guibg=#272c42 guifg=#6b7089")
vim.api.nvim_command("highlight! SyntasticErrorSign        ctermbg=235 ctermfg=203 guibg=#1e2132 guifg=#e27878")
vim.api.nvim_command("highlight! SyntasticStyleErrorSign   ctermbg=235 ctermfg=203 guibg=#1e2132 guifg=#e27878")
vim.api.nvim_command("highlight! SyntasticStyleWarningSign ctermbg=235 ctermfg=216 guibg=#1e2132 guifg=#e2a478")
vim.api.nvim_command("highlight! SyntasticWarningSign      ctermbg=235 ctermfg=216 guibg=#1e2132 guifg=#e2a478")
vim.api.nvim_command("highlight! ZenSpace                  ctermbg=203 guibg=#e27878")
vim.api.nvim_command("highlight! icebergALAccentRed        ctermfg=203 guifg=#e27878")

vim.api.nvim_command("highlight! link TermCursor                   Cursor")
vim.api.nvim_command("highlight! link cssBraces                    Delimiter")
vim.api.nvim_command("highlight! link cssClassName                 Special")
vim.api.nvim_command("highlight! link cssClassNameDot              Normal")
vim.api.nvim_command("highlight! link cssPseudoClassId             Special")
vim.api.nvim_command("highlight! link cssTagName                   Statement")
vim.api.nvim_command("highlight! link helpHyperTextJump            Constant")
vim.api.nvim_command("highlight! link htmlArg                      Constant")
vim.api.nvim_command("highlight! link htmlEndTag                   Statement")
vim.api.nvim_command("highlight! link htmlTag                      Statement")
vim.api.nvim_command("highlight! link jsonQuote                    Normal")
vim.api.nvim_command("highlight! link phpVarSelector               Identifier")
vim.api.nvim_command("highlight! link pythonFunction               Title")
vim.api.nvim_command("highlight! link rubyDefine                   Statement")
vim.api.nvim_command("highlight! link rubyFunction                 Title")
vim.api.nvim_command("highlight! link rubyInterpolationDelimiter   String")
vim.api.nvim_command("highlight! link rubySharpBang                Comment")
vim.api.nvim_command("highlight! link rubyStringDelimiter          String")
vim.api.nvim_command("highlight! link sassClass                    Special")
vim.api.nvim_command("highlight! link shFunction                   Normal")
vim.api.nvim_command("highlight! link vimContinue                  Comment")
vim.api.nvim_command("highlight! link vimFuncSID                   vimFunction")
vim.api.nvim_command("highlight! link vimFuncVar                   Normal")
vim.api.nvim_command("highlight! link vimFunction                  Title")
vim.api.nvim_command("highlight! link vimGroup                     Statement")
vim.api.nvim_command("highlight! link vimHiGroup                   Statement")
vim.api.nvim_command("highlight! link vimHiTerm                    Identifier")
vim.api.nvim_command("highlight! link vimMapModKey                 Special")
vim.api.nvim_command("highlight! link vimOption                    Identifier")
vim.api.nvim_command("highlight! link vimVar                       Normal")
vim.api.nvim_command("highlight! link xmlAttrib                    Constant")
vim.api.nvim_command("highlight! link xmlAttribPunct               Statement")
vim.api.nvim_command("highlight! link xmlEndTag                    Statement")
vim.api.nvim_command("highlight! link xmlNamespace                 Statement")
vim.api.nvim_command("highlight! link xmlTag                       Statement")
vim.api.nvim_command("highlight! link xmlTagName                   Statement")
vim.api.nvim_command("highlight! link yamlKeyValueDelimiter        Delimiter")
vim.api.nvim_command("highlight! link CtrlPPrtCursor               Cursor")
vim.api.nvim_command("highlight! link CtrlPMatch                   Title")
vim.api.nvim_command("highlight! link CtrlPMode2                   StatusLine")
vim.api.nvim_command("highlight! link deniteMatched                Normal")
vim.api.nvim_command("highlight! link deniteMatchedChar            Title")
vim.api.nvim_command("highlight! link elixirBlockDefinition        Statement")
vim.api.nvim_command("highlight! link elixirDefine                 Statement")
vim.api.nvim_command("highlight! link elixirDocSigilDelimiter      String")
vim.api.nvim_command("highlight! link elixirDocTest                String")
vim.api.nvim_command("highlight! link elixirExUnitMacro            Statement")
vim.api.nvim_command("highlight! link elixirExceptionDefine        Statement")
vim.api.nvim_command("highlight! link elixirFunctionDeclaration    Title")
vim.api.nvim_command("highlight! link elixirKeyword                Statement")
vim.api.nvim_command("highlight! link elixirModuleDeclaration      Normal")
vim.api.nvim_command("highlight! link elixirModuleDefine           Statement")
vim.api.nvim_command("highlight! link elixirPrivateDefine          Statement")
vim.api.nvim_command("highlight! link elixirStringDelimiter        String")
vim.api.nvim_command("highlight! link jsFlowMaybe                  Normal")
vim.api.nvim_command("highlight! link jsFlowObject                 Normal")
vim.api.nvim_command("highlight! link jsFlowType                   PreProc")
vim.api.nvim_command("highlight! link graphqlName                  Normal")
vim.api.nvim_command("highlight! link graphqlOperator              Normal")
vim.api.nvim_command("highlight! link gitmessengerHash             Comment")
vim.api.nvim_command("highlight! link gitmessengerHeader           Statement")
vim.api.nvim_command("highlight! link gitmessengerHistory          Constant")
vim.api.nvim_command("highlight! link jsArrowFunction              Operator")
vim.api.nvim_command("highlight! link jsClassDefinition            Normal")
vim.api.nvim_command("highlight! link jsClassFuncName              Title")
vim.api.nvim_command("highlight! link jsExport                     Statement")
vim.api.nvim_command("highlight! link jsFuncName                   Title")
vim.api.nvim_command("highlight! link jsFutureKeys                 Statement")
vim.api.nvim_command("highlight! link jsFuncCall                   Normal")
vim.api.nvim_command("highlight! link jsGlobalObjects              Statement")
vim.api.nvim_command("highlight! link jsModuleKeywords             Statement")
vim.api.nvim_command("highlight! link jsModuleOperators            Statement")
vim.api.nvim_command("highlight! link jsNull                       Constant")
vim.api.nvim_command("highlight! link jsObjectFuncName             Title")
vim.api.nvim_command("highlight! link jsObjectKey                  Identifier")
vim.api.nvim_command("highlight! link jsSuper                      Statement")
vim.api.nvim_command("highlight! link jsTemplateBraces             Special")
vim.api.nvim_command("highlight! link jsUndefined                  Constant")
vim.api.nvim_command("highlight! link markdownBold                 Special")
vim.api.nvim_command("highlight! link markdownCode                 String")
vim.api.nvim_command("highlight! link markdownCodeDelimiter        String")
vim.api.nvim_command("highlight! link markdownHeadingDelimiter     Comment")
vim.api.nvim_command("highlight! link markdownRule                 Comment")
vim.api.nvim_command("highlight! link ngxDirective                 Statement")
vim.api.nvim_command("highlight! link plug1                        Normal")
vim.api.nvim_command("highlight! link plug2                        Identifier")
vim.api.nvim_command("highlight! link plugDash                     Comment")
vim.api.nvim_command("highlight! link plugMessage                  Special")
vim.api.nvim_command("highlight! link SignifySignAdd               GitGutterAdd")
vim.api.nvim_command("highlight! link SignifySignChange            GitGutterChange")
vim.api.nvim_command("highlight! link SignifySignChangeDelete      GitGutterChangeDelete")
vim.api.nvim_command("highlight! link SignifySignDelete            GitGutterDelete")
vim.api.nvim_command("highlight! link SignifySignDeleteFirstLine   SignifySignDelete")
vim.api.nvim_command("highlight! link StartifyBracket              Comment")
vim.api.nvim_command("highlight! link StartifyFile                 Identifier")
vim.api.nvim_command("highlight! link StartifyFooter               Constant")
vim.api.nvim_command("highlight! link StartifyHeader               Constant")
vim.api.nvim_command("highlight! link StartifyNumber               Special")
vim.api.nvim_command("highlight! link StartifyPath                 Comment")
vim.api.nvim_command("highlight! link StartifySection              Statement")
vim.api.nvim_command("highlight! link StartifySlash                Comment")
vim.api.nvim_command("highlight! link StartifySpecial              Normal")
vim.api.nvim_command("highlight! link svssBraces                   Delimiter")
vim.api.nvim_command("highlight! link swiftIdentifier              Normal")
vim.api.nvim_command("highlight! link typescriptAjaxMethods        Normal")
vim.api.nvim_command("highlight! link typescriptBraces             Normal")
vim.api.nvim_command("highlight! link typescriptEndColons          Normal")
vim.api.nvim_command("highlight! link typescriptFuncKeyword        Statement")
vim.api.nvim_command("highlight! link typescriptGlobalObjects      Statement")
vim.api.nvim_command("highlight! link typescriptHtmlElemProperties Normal")
vim.api.nvim_command("highlight! link typescriptIdentifier         Statement")
vim.api.nvim_command("highlight! link typescriptMessage            Normal")
vim.api.nvim_command("highlight! link typescriptNull               Constant")
vim.api.nvim_command("highlight! link typescriptParens             Normal")

