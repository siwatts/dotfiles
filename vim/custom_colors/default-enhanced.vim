" Vim color file
" Maintainer: Simon Watts <siwatts15@outlook.com>
" Last Change: 2021 Oct 04

" default-enhanced -- Default syntax highlighting but using more of your term colours

hi clear
if exists("syntax_on")
	syntax reset
endif
let s:is_dark=(&background == 'dark')

let colors_name = "default-enhanced"

if s:is_dark
    " Dark specific customisations
    hi Search ctermfg=0 ctermbg=2 cterm=NONE guibg=Orange
    hi PMenu ctermfg=7 ctermbg=8
    hi PMenuSel ctermfg=0 ctermbg=7
    " Clear GUI bolds
    hi Statement gui=NONE
    hi Type gui=NONE
    " GUI / truecolor stuff
    hi PMenu guifg=#f0f0f0 guibg=#404080
    hi PmenuSel guifg=#f0f0f0 guibg=#2050d0
    hi IncSearch ctermfg=0 ctermbg=2 cterm=NONE guifg=#000000 guibg=#60ff60 gui=NONE
    "hi Todo guibg=Orange
    " Visual from darkblue256.vim
    hi Visual ctermfg=231 ctermbg=105 guifg=#ffffff guibg=#8080ff
    if !has('gui_running') && &t_Co < 256
        hi PreProc ctermfg=red
        hi SpecialKey ctermfg=blue
        hi Special ctermfg=red
        hi MatchParen ctermfg=white ctermbg=4
    else
        hi Todo ctermfg=231 ctermbg=20
        hi Error ctermfg=231 ctermbg=1
        hi ErrorMsg ctermfg=231 ctermbg=1
        " Red BG
        hi Visual ctermfg=NONE ctermbg=52
        "hi PreProc ctermfg=81
        "hi SpecialKey ctermfg=81
        "hi PreProc ctermfg=111
        " If blue terminal colour is safe, we can use this instead of 111
        " above
        hi PreProc ctermfg=12
        hi SpecialKey ctermfg=111
        "hi Special ctermfg=215
        " Orange, darkblue256
        hi Special ctermfg=214
        " Light Red, darkblue256
        "hi Special ctermfg=217
        " hi String ctermfg=217 " darkblue256.vim
        hi MatchParen ctermfg=231 ctermbg=60
        " Dracula magenta
        "hi Constant ctermfg=212
    endif
    " TODO: Test on tty
    hi LineNr ctermfg=yellow
    "hi PreProc ctermfg=blue
    "hi SpecialKey ctermfg=blue
    hi Type ctermfg=green
    "hi Special ctermfg=red
    " GUI stuff
    "hi Normal guifg=#f0f0f0 guibg=#303030
    "hi Normal guifg=#f0f0f0 guibg=#262626
    hi Normal guifg=#f0f0f0 guibg=#262630
    " Diff syntax
    hi! link diffAdded Type
    "hi! link diffLine Identifier " or Comment
    "hi! link diffFile Statement
    hi! link diffFile Identifier
else
    " Light specific customisations
    hi NonText guifg=#afafd7
    hi Error term=standout ctermfg=231 ctermbg=1
    hi ErrorMsg term=standout ctermfg=231 ctermbg=1
    " Yellow
    "hi Visual ctermfg=NONE ctermbg=222
    " Lucius blue
    hi Visual ctermfg=NONE ctermbg=153
    "153,183
    hi MatchParen ctermfg=16 ctermbg=183
    "hi LineNr ctermfg=244 ctermbg=254
    "hi LineNr ctermfg=3 " Turns out these look bad in a lot of terminal
    "themes? (Tommorow etc.)

    " Term white
    "hi Search ctermfg=0 ctermbg=2 cterm=NONE
    "hi IncSearch ctermfg=0 ctermbg=5 cterm=NONE
    "hi TODO ctermfg=0 ctermbg=3 cterm=NONE
    "hi PMenu ctermfg=0 ctermbg=14
    "hi PMenuSel ctermfg=0 ctermbg=7
    " 256 white
    hi Search ctermfg=231 ctermbg=2 cterm=NONE
    hi IncSearch ctermfg=231 ctermbg=5 cterm=NONE
    hi TODO ctermfg=231 ctermbg=3 cterm=NONE
    hi PMenu ctermfg=231 ctermbg=14
    hi PMenuSel ctermfg=231 ctermbg=7
    hi SpecialKey ctermfg=6

    " Override term green because usually bad
    "hi Type ctermfg=28
    "hi Type ctermfg=22

    " Replace yellow with terminal equivalent:
    "hi Statement ctermfg=3 " Turns out these look bad in a lot of terminal
    "themes? (Tommorow etc.)
    "Alternative:
    "hi Comment ctermfg=1
    "hi Constant ctermfg=2
    "hi Type ctermfg=3
    "hi Statement ctermfg=4
    "AlternativeAlternative:
    "hi Comment ctermfg=6
    "hi Constant ctermfg=1
    "hi String ctermfg=2
    "hi Type ctermfg=130
    "hi Statement ctermfg=4
    " GUI stuff
    hi Normal guifg=#000000 guibg=#ffffff
endif

