" Vim color file
" Maintainer: Simon Watts <siwatts15@outlook.com>
" Last Change: 2020 Apr 16

" default-enhanced -- Default palette but using more of your term colours
" Currently dark only

set bg=dark
hi clear
if exists("syntax_on")
	syntax reset
endif

let colors_name = "default-enhanced"

" Dark specific customisations
hi Search ctermfg=0 ctermbg=2 cterm=NONE
hi IncSearch ctermfg=0 ctermbg=5 cterm=NONE
hi PMenu ctermfg=7 ctermbg=8
hi PMenuSel ctermfg=0 ctermbg=7
hi Todo ctermfg=231 ctermbg=20
hi Error ctermfg=16 ctermbg=1
hi Visual ctermfg=NONE ctermbg=52
" Replace red/green/blue with their terminal equivalents:
if !has("gui_running") && ( $TERM == 'linux' || $TERM == 'cygwin' )
    " Seems like tty needs to set brights using bold attribute.
    hi LineNr ctermfg=3 cterm=bold
    hi PreProc ctermfg=4 cterm=bold
    hi Type ctermfg=2 cterm=bold
    hi Special ctermfg=1 cterm=bold
else
    hi LineNr ctermfg=11 cterm=NONE
    hi PreProc ctermfg=12 cterm=NONE
    hi Type ctermfg=10 cterm=NONE
    hi Special ctermfg=9 cterm=NONE
endif

"" Light specific customisations
"hi Error term=standout ctermfg=0 ctermbg=1
"hi ErrorMsg term=standout ctermfg=0 ctermbg=1
"hi Visual ctermfg=NONE ctermbg=222
"hi LineNr ctermfg=8
"hi Search ctermfg=0 ctermbg=2 cterm=NONE
"hi IncSearch ctermfg=0 ctermbg=5 cterm=NONE
"hi PMenu ctermfg=0 ctermbg=14
"hi PMenuSel ctermfg=0 ctermbg=7
"" Replace yellow with terminal equivalent:
"hi Statement ctermfg=3
