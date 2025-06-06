# .bashrc
# Originally taken from Xubuntu default user .bashrc
# Modified by SW : https://github.com/siwatts/dotfiles

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
            echo -e " (\001\033[31m\002$BRANCH\001\033[00m\002)" # Red
            #echo -e " (\001\033[01;35m\002$BRANCH\001\033[00m\002)" # Magenta
            #echo -e " ($BRANCH)*" # No colour
        else
            # Working tree clean
            echo -e " (\001\033[32m\002$BRANCH\001\033[00m\002)" # Green
            #echo -e " (\001\033[01;33m\002$BRANCH\001\033[00m\002)" # Yellow
            #echo -e " ($BRANCH)" # No colour
        fi
    fi
}
# TODO: Can adapt a more comprehensive example of this from
# https://github.com/denysdovhan/spaceship-prompt/blob/master/sections/git_status.zsh

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

    ## # https://www.xfree86.org/current/ctlseqs.html
    ## # Get colour by hashing hostname
    ## HOST="${HOSTNAME%%.*}"
    ## SUM="$(echo $HOST | md5sum -)"
    ## COLOUR="${SUM:0:6}"
    ## export PS1='\033[1;38;2;'"$((16#${COLOUR:0:2}));$((16#${COLOUR:2:2}));$((16#${COLOUR:4:2}))m"'\u@\h \[\033[01;34m\]\w\033[m\n\$ '

    # Choose prompt based on whether this is local or remote session
    if [ -n "${SSH_CONNECTION}" ]; then
        # Connected to remote via ssh, cyan
        export PS1='\[\033[36m\]\u@\h\[\033[00m\]:\[\033[36m\]\w\[\033[00m\]$(git_prompt) [\D{%H:%M}]\n\$ '
        # Can share the above across multiple hosts using
        # if [ "$HOSTNAME" = fullhostname ]; then
    elif [[ "${DISPLAY%%:0*}" != "" ]]; then
        # Connected to remote but not via ssh, yellow
        export PS1='\[\033[33m\]\u@\h(?)\[\033[00m\]:\[\033[33m\]\w\[\033[00m\]$(git_prompt) [\D{%H:%M}]\n\$ '
    else
        # Local machine, green
        export PS1='\[\033[32m\]\u@\h\[\033[00m\]:\[\033[32m\]\w\[\033[00m\]$(git_prompt) [\D{%H:%M}]\n\$ '

        # # Truecolor PS1 using 0-255 RGB values
        # # Below example is orange + purple which looks good for WSL Ubuntu
        # #
        # # https://superuser.com/questions/1220633/true-colors-in-bash-prompt
        # # --
        # # set your RGB colors
        # cname='253;151;31'
        # cdir='174;129;255'
        # # Orange3, 172, d78700, 215;135;0
        # # Molokai orange, #FD971F, 253;151;31
        # # Molokai purple, #AE81FF, 174;129;255

        # # leave this block alone
        # code_color_name="\x1b[1;38;2;${cname}m"
        # code_color_dir="\x1b[1;38;2;${cdir}m"
        # code_color_reset='\x1b[0m'

        # # leave this block alone
        # c_name=$(printf "${code_color_name}")
        # c_dir=$(printf "${code_color_dir}")
        # c_rst=$(printf "${code_color_reset}")

        # # your PS1 prompt. configure as desired
        # export PS1='\[${c_name}\]\u@\h\[${c_rst}\] \[${c_dir}\]\w\[${c_rst}\] (\D{%d/%m/%y %H:%M})$(git_prompt)\n\$ '
        # # --
    fi

    # Alternative styles:

    ## Xubuntu style, green & blue
    #export PS1='\[\033[0;32m\]\u@\h\[\033[00m\]:\[\033[0;34m\]\w\[\033[00m\]$(git_prompt)\$ '

    ## Win-bash style, green & blue
    #export PS1='\[\033[01;32m\]\u@\h \[\033[01;34m\]\w\[\033[00m\]$(git_prompt)\n\$ '

    ## Actual win-bash, green & yellow
    #export PS1='\n\[\033[0;32m\]\u@\h \[\033[0;33m\]\w\[\033[00m\]$(git_prompt)\n\$ '

    ## Fedora style, green & blue
    #export PS1='[\[\033[0;32m\]\u@\h \[\033[0;34m\]\W\[\033[00m\]$(git_prompt)]\$ '

    ## Xubuntu original, green & blue
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

    ## Tumbleweed style
    #export PS1='\u@\h:\w> '
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

# Neovim must come before other aliases, to be recursive (for view etc.)
# Uncomment if using nvim.appimage in ~/bin or similar
#alias nvim="nvim.appimage"
#if [ "$HOSTNAME" = host.with.nvim ]; then
#    alias vim="nvim"
#    alias vimdiff="nvim -d"
#fi

# Generic handy aliases
alias dotfiles='cd ~/repos/dotfiles'
alias i3c="$EDITOR ~/.config/i3/config"
alias mpvdvd="mpv dvd://"
alias vlcdvd="vlc dvd://"
alias todo="$EDITOR ~/Documents/TODO.org"
alias ta='tmux a || tmux'
# Retain classic view func.
# Retain classic behaviour:
alias view='vim -R'
# Enhanced version for large files:
#     -n = no swap file (vim can crash / be sigkilled safely)
#     -M = no modifiable
#     -R = Readonly buffer (cannot save)
alias view-safe='vim -nMR'
# Like `tail -f` but better
alias less-follow='less -RX +F'
diffdir()
{
    diff -r "$@" | vim -nMR -c 'set syntax=diff' -
}
dirdiff()
{
    diff -r "$@" | vim -nMR -c 'set syntax=diff' -
}

# More aliases
#alias config-redshift="vim ~/.config/redshift.conf; killall redshift; sleep 6; redshift-gtk &"

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

count1min()
{
    echo '60 second timer...'
    echo -ne '[                                                            ]\r'
    echo -ne '['

    for i in {1..60}; do
        sleep 1s
        echo -n '='
    done
    echo
}

alias gitlog='git log --all --graph --pretty --decorate'
#alias gitstatus='git status -uno'

# System upgrade aliases
alias reboot-message-wait='echo "Initiating REBOOT, 1 minute from $(date). Save and close all work." && count1min || sleep 1m'
if command -v rpm-ostree &> /dev/null
then
    # Silverblue
    alias upgrade='flatpak upgrade -y ; echo "Working..."; sudo rpm-ostree upgrade'
    alias offline-upgrade-download='flatpak upgrade -y ; echo "Working..."; sudo rpm-ostree upgrade --download-only'
    alias offline-upgrade-apply='sudo rpm-ostree upgrade ; sudo shutdown -r 1'
elif command -v dnf &> /dev/null
then
    # Fedora or similar
    alias upgrade='flatpak upgrade -y ; echo "Working..."; sudo dnf upgrade -y'
    alias offline-upgrade-download='flatpak upgrade -y ; echo "Working..."; sudo dnf offline-upgrade download -y'
    alias offline-upgrade-apply='reboot-message-wait && sudo dnf5 offline reboot -y'
    alias offline-upgrade-cancel='sudo dnf offline-upgrade clean'
elif command -v apt &> /dev/null
then
    # Ubuntu or similar
    alias upgrade='echo "Working..."; sudo apt update && sudo apt upgrade -y'
    alias offline-upgrade-download='echo "Offline upgrade not known for apt"'
    alias offline-upgrade-apply='echo "Offline upgrade not known for apt"'
fi
# Common
alias upgrade-reboot='upgrade ; sudo shutdown -r 1'
alias upgrade-shutdown='upgrade ; sudo shutdown 1'
alias offline-upgrade-download-and-apply='offline-upgrade-download && offline-upgrade-apply'

# Generic Helpful Aliases
alias findhere='find . -type f -name '

# SSH aliases
# - For Host 'name' as defined in '~/.ssh/config'
# - '-Y' for X11 forwarding
# - '-t' to allocate pseudo-tty (allowing following command to run)
# - 'tmux a || tmux', attach to running tmux session, else create one
# alias sshname="ssh -Y name -t 'tmux a || tmux'"

# FreeRDP
#alias rdp-pcname='echo "Alt+Ctrl+Enter to toggle fullscreen"; sleep 2s; xfreerdp /kbd:0x00000809 /u:username /v:pcname /w:1920 /h:1080 /f'
#alias rdp-pcname-sound='echo "Alt+Ctrl+Enter to toggle fullscreen"; sleep 2s; xfreerdp /kbd:0x00000809 /u:username /v:pcname /w:1920 /h:1080 /f /audio:quality:high /mic:quality:high'

export DOTNET_CLI_TELEMETRY_OPTOUT=1

# Cygwin attach to running X11 server
#export DISPLAY=:0

# Remove miniconda "(base) " from the beginning of the bash prompt
# We only want to see other more interesting envs
PS1=$(echo "$PS1" | sed 's/(base) //')
# OR can get rid of this PS1 modification entirely: conda config --set changeps1 False

#neofetch
#neofetch --block_width 4
#neofetch --block_width 6 --block_height 2

# Bash History
# Both these default to 1000
HISTSIZE=1000
HISTFILESIZE=2000
# Append to, don't overwrite ~/.bash_history
shopt -s histappend
# Or overwrite it: shopt -u histappend
# Check it: shopt histappend
