# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific aliases and functions

# Editor:
export VISUAL="vim"
export EDITOR="$VISUAL"

## Use vi-like bash prompt.
#set -o vi
## But keep Ctrl+L for 'clear'.
#bind -m vi-insert "\C-l":clear-screen

# Simple git status.
git_prompt () {
    # Parse branch name, if any.
    BRANCH="$(git branch 2>/dev/null | grep '^*' | colrm 1 2)"
    if [ -n "$BRANCH" ]; then
        # We're in a git repository.
        # Get the status:
        if [ -n "$(git status --porcelain)" ]; then
            # Working tree dirty
            echo -e " (\001\033[01;31m\002$BRANCH\001\033[00m\002)" # Red
            #echo -e " (\001\033[01;35m\002$BRANCH\001\033[00m\002)" # Magenta
            #echo -e " ($BRANCH)*" # No colour
        else
            # Working tree clean
            echo -e " (\001\033[01;32m\002$BRANCH\001\033[00m\002)" # Green
            #echo -e " (\001\033[01;33m\002$BRANCH\001\033[00m\002)" # Yellow
            #echo -e " ($BRANCH)" # No colour
        fi
    fi
}

# If URxvt then call script to set custom colours.
case "$TERM" in
    rxvt*color)
        #BASE_LOCATION="/CHANGE_ME/dotfiles"

        ### Override theme.
        #THEME_LOCATION="$BASE_LOCATION/terminal/scripts/dracula-magenta.sh"
        #if [[ -x "$THEME_LOCATION" ]]
        #then
        #    eval "$THEME_LOCATION"
        #else
        #    echo "~/.bashrc : Theme not found: '$THEME_LOCATION'."
        #fi

        ### Override cursor/bg/fg.
        #CURSOR_LOCATION="$BASE_LOCATION/terminal/scripts/set_cursor.sh"
        #BG_LOCATION="$BASE_LOCATION/terminal/scripts/set_background.sh"
        #FG_LOCATION="$BASE_LOCATION/terminal/scripts/set_foreground.sh"
        ### Cursor:
        #if [[ -x "$CURSOR_LOCATION" ]]
        #then
        #    eval "$CURSOR_LOCATION"' "#ff66ff"'
        #else
        #    echo "~/.bashrc : Cursor script not found: '$CURSOR_LOCATION'."
        #fi
        ### Background:
        #if [[ -x "$BG_LOCATION" ]]
        #then
        #    eval "$BG_LOCATION 28/2A/36"
        #    #eval "$BG_LOCATION 41/44/58"
        #else
        #    echo "~/.bashrc : Cursor script not found: '$BG_LOCATION'."
        #fi
        ### Foreground:
        #if [[ -x "$FG_LOCATION" ]]
        #then
        #    eval "$FG_LOCATION ff/ff/00"
        #else
        #    echo "~/.bashrc : Cursor script not found: '$FG_LOCATION'."
        #fi

        ;;
esac

# 30m Black
# 31m Red
# 32m Green
# 33m Yellow
# 34m Blue
# 35m Magenta
# 36m Cyan
# 37m White

# From xubuntu default:

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color|cygwin) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

# PS1 prompt:
if [ "$color_prompt" = yes ]; then
    ## Xubuntu style
    #export PS1='\[\033[0;32m\]\u@\h\[\033[00m\]:\[\033[0;34m\]\w\[\033[00m\]$(git_prompt)\$ '

    ## Win-bash style
    export PS1='\[\033[01;32m\]\u@\h \[\033[01;34m\]\w\[\033[00m\]$(git_prompt)\n\$ '
    ## Actual win-bash
    #export PS1='\n\[\033[0;32m\]\u@\h \[\033[0;33m\]\w\[\033[00m\]$(git_prompt)\n\$ '

    ## Fedora style
    #export PS1='[\[\033[0;32m\]\u@\h \[\033[0;34m\]\W\[\033[00m\]$(git_prompt)]\$ '

    ## Xubuntu original
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    ## Xubuntu style
    #export PS1='\u@\h:\w\$ '

    ## Win-bash style
    export PS1='\u@\h \w\n\$ '

    ## Fedora style
    #export PS1='[\u@\h \W]\$ '

    ## Xubuntu original
    #PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# If in a tty, change the default colours:
if [ "$TERM" = "linux" ]; then
    ## Dracula
    ##echo -en "\e]P0282A36" #black
    #echo -en "\e]P0000000" #black
    #echo -en "\e]P86272A4" #darkgrey
    #echo -en "\e]P1FF5555" #darkred
    #echo -en "\e]P9FF6E67" #red
    #echo -en "\e]P250FA7B" #darkgreen
    #echo -en "\e]PA5AF78E" #green
    #echo -en "\e]P3F1FA8C" #brown
    #echo -en "\e]PBF4F99D" #yellow
    #echo -en "\e]P4BD93F9" #darkblue
    #echo -en "\e]PCCAA9FA" #blue
    #echo -en "\e]P5FF79C6" #darkmagenta
    #echo -en "\e]PDFF92D0" #magenta
    #echo -en "\e]P68BE9FD" #darkcyan
    #echo -en "\e]PE9AEDFE" #cyan
    #echo -en "\e]P7F8F8F2" #lightgrey
    #echo -en "\e]PFFFFFFF" #white
    #clear #for background artifacting
    ## Jellybeans
    ##echo -en "\e]P0151515" #black
    #echo -en "\e]P0000000" #black
    #echo -en "\e]P8888888" #darkgrey
    #echo -en "\e]P1cf6a4c" #darkred
    #echo -en "\e]P9cf6a4c" #red
    #echo -en "\e]P2799d6a" #darkgreen
    #echo -en "\e]PA99ad6a" #green
    #echo -en "\e]P3ffb964" #brown
    #echo -en "\e]PBfad07a" #yellow
    #echo -en "\e]P48197bf" #darkblue
    #echo -en "\e]PC8197bf" #blue
    #echo -en "\e]P5c6b6ee" #darkmagenta
    #echo -en "\e]PDc6b6ee" #magenta
    #echo -en "\e]P68fbfdc" #darkcyan
    #echo -en "\e]PE8fbfdc" #cyan
    #echo -en "\e]P7e8e8d3" #lightgrey
    #echo -en "\e]PFffffff" #white
    #clear #for background artifacting
    # Tango
    echo -en "\e]P0000000" #black
    echo -en "\e]P8555753" #darkgrey
    echo -en "\e]P1cc0000" #darkred
    echo -en "\e]P9ef2929" #red
    echo -en "\e]P24e9a06" #darkgreen
    echo -en "\e]PA8ae234" #green
    echo -en "\e]P3c4a000" #brown
    echo -en "\e]PBfce94f" #yellow
    echo -en "\e]P43465a4" #darkblue
    echo -en "\e]PC739fcf" #blue
    echo -en "\e]P575507b" #darkmagenta
    echo -en "\e]PDad7fa8" #magenta
    echo -en "\e]P606989a" #darkcyan
    echo -en "\e]PE34e2e2" #cyan
    echo -en "\e]P7d3d7cf" #lightgrey
    echo -en "\e]PFeeeeec" #white
    clear #for background artifacting
fi
## Alternatively, use whatever is in ~/.Xresources
#if [ "$TERM" = "linux" ]; then
#    _SEDCMD='s/.*\*color\([0-9]\{1,\}\).*#\([0-9a-fA-F]\{6\}\).*/\1 \2/p'
#    for i in $(sed -n "$_SEDCMD" $HOME/.Xresources | awk '$1 < 16 {printf "\\e]P%X%s", $1, $2}'); do
#        echo -en "$i"
#    done
#    clear
#fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

#alias dotfiles='cd ~/Documents/repos/dotfiles'
alias i3c="$EDITOR ~/.config/i3/config"
alias mpvdvd="mpv dvd://"
alias vlcdvd="vlc dvd://"
alias todo="$EDITOR ~/Documents/TODO.txt"

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
cdl()
{
    cd "$@" && ls -CF;
}
cdll()
{
    cd "$@" && ls -al;
}

export DOTNET_CLI_TELEMETRY_OPTOUT=1

# Hide stdout & stderr for some common programs when invoking through terminal.
alias thunar='thunar &> /dev/null'
alias nautilus='nautilus &> /dev/null'
alias gvim='gvim &> /dev/null'
alias code='code &> /dev/null'
alias codeblocks='codeblocks &> /dev/null'
alias geany='geany &> /dev/null'

# Cygwin attach to running X11 server
#export DISPLAY=:0

