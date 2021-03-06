" Vim color file - blackboard
" Generated by http://bytefluent.com/vivify 2017-02-03
set background=dark
if version > 580
	hi clear
	if exists("syntax_on")
		syntax reset
	endif
endif

set t_Co=256
let g:colors_name = "blackboard"

"hi IncSearch -- no settings --
"hi WildMenu -- no settings --
"hi SignColumn -- no settings --
"hi SpecialComment -- no settings --
"hi Title -- no settings --
"hi TabLineSel -- no settings --
"hi StatusLineNC -- no settings --
"hi CTagsMember -- no settings --
"hi NonText -- no settings --
"hi CTagsGlobalConstant -- no settings --
"hi DiffText -- no settings --
"hi ErrorMsg -- no settings --
"hi Ignore -- no settings --
"hi Debug -- no settings --
"hi SpecialChar -- no settings --
"hi Todo -- no settings --
"hi Special -- no settings --
"hi StatusLine -- no settings --
hi Normal guifg=#ffffff guibg=#0B1022 guisp=#0B1022 gui=NONE ctermfg=15 ctermbg=235 cterm=NONE
"hi CTagsImport -- no settings --
"hi CTagsGlobalVariable -- no settings --
"hi Delimiter -- no settings --
"hi Statement -- no settings --
"hi SpellRare -- no settings --
"hi EnumerationValue -- no settings --
"hi Float -- no settings --
"hi Boolean -- no settings --
"hi Union -- no settings --
"hi TabLineFill -- no settings --
"hi Question -- no settings --
"hi WarningMsg -- no settings --
"hi VisualNOS -- no settings --
"hi DiffDelete -- no settings --
"hi ModeMsg -- no settings --
"hi CursorColumn -- no settings --
"hi FoldColumn -- no settings --
"hi EnumerationName -- no settings --
"hi Visual -- no settings --
"hi MoreMsg -- no settings --
"hi SpellCap -- no settings --
"hi VertSplit -- no settings --
"hi DiffChange -- no settings --
"hi SpellLocal -- no settings --
"hi Error -- no settings --
"hi SpecialKey -- no settings --
"hi DefinedName -- no settings --
"hi Tag -- no settings --
"hi MatchParen -- no settings --
"hi LocalVariable -- no settings --
"hi SpellBad -- no settings --
"hi CTagsClass -- no settings --
"hi Directory -- no settings --
"hi Underlined -- no settings --
"hi DiffAdd -- no settings --
"hi TabLine -- no settings --
"hi clear -- no settings --
"hi rubystringdelimiter -- no settings --
hi Typedef guifg=#84A7C1 guibg=NONE guisp=NONE gui=NONE ctermfg=110 ctermbg=NONE cterm=NONE
hi Folded guifg=#ffffff guibg=NONE guisp=NONE gui=NONE ctermfg=15 ctermbg=NONE cterm=NONE
hi PreCondit guifg=#bebebe guibg=NONE guisp=NONE gui=NONE ctermfg=7 ctermbg=NONE cterm=NONE
hi Include guifg=#bebebe guibg=NONE guisp=NONE gui=NONE ctermfg=7 ctermbg=NONE cterm=NONE
hi PMenuSbar guifg=NONE guibg=#323232 guisp=#323232 gui=NONE ctermfg=NONE ctermbg=236 cterm=NONE
hi Identifier guifg=#00D42D guibg=NONE guisp=NONE gui=NONE ctermfg=40 ctermbg=NONE cterm=NONE
hi Conditional guifg=#84A7C1 guibg=NONE guisp=NONE gui=NONE ctermfg=110 ctermbg=NONE cterm=NONE
hi StorageClass guifg=#84A7C1 guibg=NONE guisp=NONE gui=NONE ctermfg=110 ctermbg=NONE cterm=NONE
hi LineNr guifg=#888888 guibg=#323232 guisp=#323232 gui=NONE ctermfg=102 ctermbg=236 cterm=NONE
hi Label guifg=#84A7C1 guibg=NONE guisp=NONE gui=NONE ctermfg=110 ctermbg=NONE cterm=NONE
hi PMenuSel guifg=#88dd88 guibg=#949698 guisp=#949698 gui=NONE ctermfg=114 ctermbg=246 cterm=NONE
hi Search guifg=NONE guibg=#1C3B79 guisp=#1C3B79 gui=NONE ctermfg=NONE ctermbg=6 cterm=NONE
hi Comment guifg=#AEAEAE guibg=NONE guisp=NONE gui=NONE ctermfg=145 ctermbg=NONE cterm=NONE
hi Character guifg=#CAFE1E guibg=NONE guisp=NONE gui=NONE ctermfg=190 ctermbg=NONE cterm=NONE
hi Number guifg=#CAFE1E guibg=NONE guisp=NONE gui=NONE ctermfg=190 ctermbg=NONE cterm=NONE
hi Operator guifg=#84A7C1 guibg=NONE guisp=NONE gui=NONE ctermfg=110 ctermbg=NONE cterm=NONE
hi CursorLine guifg=NONE guibg=#191E2F guisp=#191E2F gui=NONE ctermfg=NONE ctermbg=236 cterm=NONE
hi Define guifg=#bebebe guibg=NONE guisp=NONE gui=NONE ctermfg=7 ctermbg=NONE cterm=NONE
hi Function guifg=#FF5600 guibg=NONE guisp=NONE gui=NONE ctermfg=202 ctermbg=NONE cterm=NONE
hi PreProc guifg=#bebebe guibg=NONE guisp=NONE gui=NONE ctermfg=7 ctermbg=NONE cterm=NONE
hi Exception guifg=#84A7C1 guibg=NONE guisp=NONE gui=NONE ctermfg=110 ctermbg=NONE cterm=NONE
hi Keyword guifg=#FFDE00 guibg=NONE guisp=NONE gui=NONE ctermfg=220 ctermbg=NONE cterm=NONE
hi Type guifg=#84A7C1 guibg=NONE guisp=NONE gui=NONE ctermfg=110 ctermbg=NONE cterm=NONE
hi Cursor guifg=#000000 guibg=#ffff00 guisp=#ffff00 gui=NONE ctermfg=NONE ctermbg=11 cterm=NONE
hi PMenu guifg=#dddddd guibg=#545658 guisp=#545658 gui=NONE ctermfg=253 ctermbg=240 cterm=NONE
hi Constant guifg=#CAFE1E guibg=NONE guisp=NONE gui=NONE ctermfg=190 ctermbg=NONE cterm=NONE
hi String guifg=#00D42D guibg=NONE guisp=NONE gui=NONE ctermfg=40 ctermbg=NONE cterm=NONE
hi PMenuThumb guifg=NONE guibg=#888888 guisp=#888888 gui=NONE ctermfg=NONE ctermbg=102 cterm=NONE
hi Repeat guifg=#84A7C1 guibg=NONE guisp=NONE gui=NONE ctermfg=110 ctermbg=NONE cterm=NONE
hi Structure guifg=#84A7C1 guibg=NONE guisp=NONE gui=NONE ctermfg=110 ctermbg=NONE cterm=NONE
hi Macro guifg=#bebebe guibg=NONE guisp=NONE gui=NONE ctermfg=7 ctermbg=NONE cterm=NONE
hi cursorim guifg=NONE guibg=#ffff00 guisp=#ffff00 gui=NONE ctermfg=NONE ctermbg=11 cterm=NONE
hi mbenormal guifg=#cfbfad guibg=#2e2e3f guisp=#2e2e3f gui=NONE ctermfg=187 ctermbg=237 cterm=NONE
hi perlspecialstring guifg=#c080d0 guibg=#404040 guisp=#404040 gui=NONE ctermfg=176 ctermbg=238 cterm=NONE
hi doxygenspecial guifg=#fdd090 guibg=NONE guisp=NONE gui=NONE ctermfg=222 ctermbg=NONE cterm=NONE
hi mbechanged guifg=#eeeeee guibg=#2e2e3f guisp=#2e2e3f gui=NONE ctermfg=255 ctermbg=237 cterm=NONE
hi mbevisiblechanged guifg=#eeeeee guibg=#4e4e8f guisp=#4e4e8f gui=NONE ctermfg=255 ctermbg=60 cterm=NONE
hi doxygenparam guifg=#fdd090 guibg=NONE guisp=NONE gui=NONE ctermfg=222 ctermbg=NONE cterm=NONE
hi doxygensmallspecial guifg=#fdd090 guibg=NONE guisp=NONE gui=NONE ctermfg=222 ctermbg=NONE cterm=NONE
hi doxygenprev guifg=#fdd090 guibg=NONE guisp=NONE gui=NONE ctermfg=222 ctermbg=NONE cterm=NONE
hi perlspecialmatch guifg=#c080d0 guibg=#404040 guisp=#404040 gui=NONE ctermfg=176 ctermbg=238 cterm=NONE
hi cformat guifg=#c080d0 guibg=#404040 guisp=#404040 gui=NONE ctermfg=176 ctermbg=238 cterm=NONE
hi lcursor guifg=#ffffff guibg=#000000 guisp=#000000 gui=NONE ctermfg=15 ctermbg=NONE cterm=NONE
hi doxygenspecialmultilinedesc guifg=#ad600b guibg=NONE guisp=NONE gui=NONE ctermfg=130 ctermbg=NONE cterm=NONE
hi taglisttagname guifg=#808bed guibg=NONE guisp=NONE gui=NONE ctermfg=105 ctermbg=NONE cterm=NONE
hi doxygenbrief guifg=#fdab60 guibg=NONE guisp=NONE gui=NONE ctermfg=215 ctermbg=NONE cterm=NONE
hi mbevisiblenormal guifg=#cfcfcd guibg=#4e4e8f guisp=#4e4e8f gui=NONE ctermfg=252 ctermbg=60 cterm=NONE
hi user2 guifg=#87cefa guibg=#021a39 guisp=#021a39 gui=bold ctermfg=117 ctermbg=17 cterm=bold
hi user1 guifg=#00ff8b guibg=#3e3e5e guisp=#3e3e5e gui=NONE ctermfg=48 ctermbg=60 cterm=NONE
hi doxygenspecialonelinedesc guifg=#ad600b guibg=NONE guisp=NONE gui=NONE ctermfg=130 ctermbg=NONE cterm=NONE
hi doxygencomment guifg=#ad7b20 guibg=NONE guisp=NONE gui=NONE ctermfg=130 ctermbg=NONE cterm=NONE
hi cspecialcharacter guifg=#c080d0 guibg=#404040 guisp=#404040 gui=NONE ctermfg=176 ctermbg=238 cterm=NONE
hi stringdelimiter guifg=#556633 guibg=NONE guisp=NONE gui=NONE ctermfg=101 ctermbg=NONE cterm=NONE
hi rubyregexp guifg=#dd0093 guibg=NONE guisp=NONE gui=NONE ctermfg=162 ctermbg=NONE cterm=NONE
hi string guifg=#99ad6a guibg=NONE guisp=NONE gui=NONE ctermfg=107 ctermbg=NONE cterm=NONE
hi constant guifg=#CAFE1E guibg=NONE guisp=NONE gui=NONE ctermfg=190 ctermbg=NONE cterm=NONE
hi normal guifg=#ffffff guibg=#0B1022 guisp=#0B1022 gui=NONE ctermfg=15 ctermbg=235 cterm=NONE
hi rubyinstancevariable guifg=#c6b6fe guibg=NONE guisp=NONE gui=NONE ctermfg=147 ctermbg=NONE cterm=NONE
hi rubyclass guifg=#447799 guibg=NONE guisp=NONE gui=NONE ctermfg=67 ctermbg=NONE cterm=NONE
hi identifier guifg=#c6b6ee guibg=NONE guisp=NONE gui=NONE ctermfg=183 ctermbg=NONE cterm=NONE
hi comment guifg=#888888 guibg=NONE guisp=NONE gui=italic ctermfg=102 ctermbg=NONE cterm=NONE
hi rubyregexpdelimiter guifg=#540063 guibg=NONE guisp=NONE gui=NONE ctermfg=53 ctermbg=NONE cterm=NONE
hi rubyregexpspecial guifg=#a40073 guibg=NONE guisp=NONE gui=NONE ctermfg=126 ctermbg=NONE cterm=NONE
hi rubypredefinedidentifier guifg=#de5577 guibg=NONE guisp=NONE gui=NONE ctermfg=168 ctermbg=NONE cterm=NONE
hi function guifg=#fad07a guibg=NONE guisp=NONE gui=NONE ctermfg=222 ctermbg=NONE cterm=NONE
hi directory guifg=#dad085 guibg=NONE guisp=NONE gui=NONE ctermfg=186 ctermbg=NONE cterm=NONE
hi rubysymbol guifg=#7697d6 guibg=NONE guisp=NONE gui=NONE ctermfg=110 ctermbg=NONE cterm=NONE
hi rubycontrol guifg=#7597c6 guibg=NONE guisp=NONE gui=NONE ctermfg=110 ctermbg=NONE cterm=NONE
hi rubyidentifier guifg=#c6b6fe guibg=NONE guisp=NONE gui=NONE ctermfg=147 ctermbg=NONE cterm=NONE
hi vimerror guifg=#ffa500 guibg=NONE guisp=NONE gui=bold ctermfg=214 ctermbg=NONE cterm=bold
hi cdefine guifg=#0000ff guibg=NONE guisp=NONE gui=NONE ctermfg=21 ctermbg=NONE cterm=NONE
hi cinclude guifg=#ffffff guibg=NONE guisp=NONE gui=NONE ctermfg=15 ctermbg=NONE cterm=NONE
hi menu guifg=#fff8dc guibg=#233b5a guisp=#233b5a gui=NONE ctermfg=230 ctermbg=17 cterm=NONE
hi scrollbar guifg=NONE guibg=#233b5a guisp=#233b5a gui=NONE ctermfg=NONE ctermbg=17 cterm=NONE
hi cursor guifg=NONE guibg=#ffffff guisp=#ffffff gui=NONE ctermfg=NONE ctermbg=15 cterm=NONE
hi keyword guifg=#FFDE00 guibg=NONE guisp=NONE gui=NONE ctermfg=220 ctermbg=NONE cterm=NONE
hi type guifg=#84A7C1 guibg=NONE guisp=NONE gui=NONE ctermfg=110 ctermbg=NONE cterm=NONE
