" Vim color file
" Maintainer: Simon Watts <siwatts15@outlook.com>
" Last Change: 2021 Mar 09

" default-enhanced -- Default syntax highlighting but using more of your term colours

hi clear
if exists("syntax_on")
	syntax reset
endif
let s:is_dark=(&background == 'dark')

let colors_name = "default-enhanced"

if s:is_dark
    " Dark specific customisations
    hi Search ctermfg=0 ctermbg=2 cterm=NONE
    hi IncSearch ctermfg=0 ctermbg=5 cterm=NONE
    hi PMenu ctermfg=7 ctermbg=8
    hi PMenuSel ctermfg=0 ctermbg=7
    if !has('gui_running') && &t_Co < 256
        hi PreProc ctermfg=red
        hi SpecialKey ctermfg=blue
        hi Special ctermfg=red
    else
        hi Todo ctermfg=231 ctermbg=20
        hi Error ctermfg=231 ctermbg=1
        hi ErrorMsg ctermfg=231 ctermbg=1
        hi Visual ctermfg=NONE ctermbg=52
        "hi PreProc ctermfg=81
        "hi SpecialKey ctermfg=81
        hi PreProc ctermfg=111
        hi SpecialKey ctermfg=111
        hi Special ctermfg=215
        " hi String ctermfg=217 " darkblue256.vim
    endif
    " TODO: Test on tty
    hi LineNr ctermfg=yellow
    "hi PreProc ctermfg=blue
    "hi SpecialKey ctermfg=blue
    hi Type ctermfg=green
    "hi Special ctermfg=red
    " GUI stuff
    hi Normal guifg=#f0f0f0 guibg=#212121
    " Diff syntax
    hi! link diffAdded Type
    "hi! link diffLine Identifier " or Comment
    "hi! link diffFile Statement
    hi! link diffFile Identifier
else
    " Light specific customisations
    hi Error term=standout ctermfg=0 ctermbg=1
    hi ErrorMsg term=standout ctermfg=0 ctermbg=1
    hi Visual ctermfg=NONE ctermbg=222
    hi LineNr ctermfg=3
    hi Search ctermfg=0 ctermbg=2 cterm=NONE
    hi IncSearch ctermfg=0 ctermbg=5 cterm=NONE
    hi PMenu ctermfg=0 ctermbg=14
    hi PMenuSel ctermfg=0 ctermbg=7
    " Replace yellow with terminal equivalent:
    hi Statement ctermfg=3
    " GUI stuff
    hi Normal guifg=#151515 guibg=#ffffff
endif

