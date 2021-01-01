" ====================
" Config:
" ====================
" -- Is the terminal background dark? --
let use_dark_theme=1

" -- Set a custom colourscheme here: --
"let terminal_theme='jellybeans'
"let gui_theme='jellybeans'

" ====================
" Settings:
" ====================
set nobackup                " Stop vim leaving backup ~ files everywhere.
set number                  " Enable linenumbers.
set numberwidth=3           " Enable linenumbers.
" Enable linenumbers when printing, and equal margins on all sides (default 10,5,5,5).
set printoptions=number:y,left:5pc,right:5pc,top:5pc,bottom:5pc
set hlsearch                " Enable search highlighting.
set ruler                   " Show some line/column information at bottom right.
set showcmd                 " Show current partially input command at bottom of screen.
set showmatch               " Briefly jump to matching bracket.
set ignorecase              " Make searches not case sensitive when searching with / or ?.
set smartcase               " Except if they include one or more uppercase.
set wildmenu                " Show possible completions on tab.
set wildmode=longest:full   " Complete longest portion of compl. common to all, full compl. displ. in wildmenu
set incsearch               " Show search matches as you type them

" Force utf8 encoding:
"set encoding=utf8
"set fileencoding=utf8

" Slow connections:
"set lazyredraw
"set nottyfast

" Splits
set splitright
set splitbelow
" Don't equalise vertical and horizontal splits, instead
" split/unsplit current window. Behaves more like tmux.
set equalalways!

" Tab settings.
set tabstop=4
set shiftwidth=4
set expandtab
"set smarttab

" Indent settings. Detect filetype, or use auto & smart indent together.
set autoindent
filetype plugin indent on
"set smartindent
""set cindent

" Search for tags file in current directory, and recursively one level up until root
set tags=./tags;
" (To recursively generate ctags [C/C++] from current location ie. root of project: `$ ctags -R .`)

" Text width, auto word wrap. 0 off.
set tw=0
" Default textwidth for markdown and text files.
"au BufRead,BufNewFile *.txt,*.md setlocal textwidth=80

" ====================
" Colours:
" ====================
" Override colourscheme diff highlighting.
function! SetCustomDiff()
    if !has("gui_running") && ( $TERM == 'linux' || $TERM == 'cygwin' || &t_Co < 256 )
        " Restore default diff.
        "hi DiffAdd      ctermfg=NONE    ctermbg=1   cterm=NONE  term=bold
        "hi DiffDelete   ctermfg=4       ctermbg=6   cterm=bold  term=bold
        "hi DiffChange   ctermfg=NONE    ctermbg=5   cterm=NONE  term=bold
        "hi DiffText     ctermfg=NONE    ctermbg=1   cterm=bold  term=reverse
        " ????
        hi DiffAdd      ctermfg=NONE    ctermbg=4   cterm=NONE  term=bold
        hi DiffDelete   ctermfg=4       ctermbg=6   cterm=bold  term=bold
        hi DiffChange   ctermfg=NONE    ctermbg=5   cterm=NONE  term=bold
        hi DiffText     ctermfg=NONE    ctermbg=1   cterm=bold  term=reverse
    else
        " 256 or full gui colours: Set colourful diff colours from theme Jellybeans.
        hi DiffAdd      guifg=#D2EBBE   guibg=#437019   ctermfg=193     ctermbg=22  gui=NONE    cterm=NONE
        hi DiffDelete   guifg=#40000A   guibg=#700009   ctermfg=232      ctermbg=52  gui=NONE    cterm=NONE
        hi DiffChange   guifg=#FFFFFF   guibg=#2B5B77   ctermfg=231     ctermbg=24  gui=NONE    cterm=NONE
        hi DiffText     guifg=#8fbfdc   guibg=#000000   ctermfg=81      ctermbg=232  gui=reverse cterm=reverse
    endif
endfunction

" Apply default theme with fixes.
function! ApplyEnhancedDefaultTheme(use_dark_theme)
    " Apply default theme and tweak.
    color default
    if a:use_dark_theme
        set background=dark

        " Dark specific customisations
        hi Search ctermfg=0 ctermbg=2 cterm=NONE
        hi IncSearch ctermfg=0 ctermbg=5 cterm=NONE
        hi PMenu ctermfg=7 ctermbg=0
        hi PMenuSel ctermfg=0 ctermbg=7
    else
        set background=light
    endif
endfunction

" Apply custom diff whenever a colorscheme is applied.
autocmd ColorScheme * call SetCustomDiff()

" Set the terminal colourscheme.
syntax on
if !has("gui_running")
    if ( $TERM == 'linux' || $TERM == 'cygwin' )
        " Fall back to supported dark theme if in tty or cygwin.
        call ApplyEnhancedDefaultTheme(1)
    elseif exists("terminal_theme")
        " Set user specified theme.
        if exists("use_dark_theme") && use_dark_theme
            set background=dark
        else
            set background=light
        endif
        execute 'colorscheme ' . terminal_theme
    else
        " Set default.
        if exists("use_dark_theme")
            call ApplyEnhancedDefaultTheme(use_dark_theme)
        else
            call ApplyEnhancedDefaultTheme(1)
        endif
    endif
endif

" ====================
" Gvim:
" ====================
if has("gui_running")
    " Enable mouse.
    set mouse=a
    " Or disable mouse, to behave like terminal vim.
    "set mouse=c

    " Disable all cursor blinking:
    set guicursor+=a:blinkon0

    " Set the gui colourscheme
    if exists("gui_theme")
        if exists("use_dark_theme") && use_dark_theme
            set background=dark
        else
            set background=light
        endif
        execute 'colorscheme ' . gui_theme
    elseif exists("use_dark_theme") && use_dark_theme
        colorscheme darkblue
    else
        colorscheme default
        set background=light
    endif

    " Set gui font.
    if has("win32")
        " Set font for MS Windows
        set guifont=Consolas:h11
        "set guifont=Courier:h12
        "set guifont=Courier10\ BT:h11
        "set guifont=Terminus:h12
        "set guifont=Hack:h10
    elseif has("unix")
        " Or for Linux / Cygwin
        set guifont=Monospace\ 10
        "set guifont=DejaVu\ Sans\ Mono\ 10
        "set guifont=Liberation\ Mono\ 10
        "set guifont=Terminus\ 12
        "set guifont=Hack\ 10
    endif

    " Window size
    set lines=45 columns=130
endif

" ====================
" Mappings:
" ====================
" Behaviour of y to match D, C, S etc.
" Ie. Y yanks to end of line instead of yanking the entire line like yy.
nnoremap Y y$

" Press ENTER with a visual selection to copy it to clipboard.
vmap <CR> "+y

" Ctrl+ENTER to paste from system clipboard.
nmap <C-Enter> "+p
imap <C-Enter> <C-R>+

nmap n nzz
nmap N Nzz

" From: https://github.com/vim/vim/blob/master/runtime/defaults.vim
" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
" Revert with: ":delcommand DiffOrig".
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r ++edit # | 0d_ | diffthis
          \ | wincmd p | diffthis
endif

