# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific aliases and functions

# Editor:
export VISUAL="vim"
export EDITOR="$VISUAL"

# Simple git status.
git_prompt () {
    # Parse branch name, if any.
    BRANCH="$(git branch 2>/dev/null | grep '^*' | colrm 1 2)"
    if [ -n "$BRANCH" ]; then
        # We're in a git repository.
        # Get the status:
        if [ -n "$(git status --porcelain)" ]; then
            # Working tree dirty
            echo -e " (\001\033[0;31m\002$BRANCH\001\033[00m\002)" # Red
            #echo -e " (\001\033[0;35m\002$BRANCH\001\033[00m\002)" # Magenta
            #echo -e " ($BRANCH)*" # No colour
        else
            # Working tree clean
            echo -e " (\001\033[0;32m\002$BRANCH\001\033[00m\002)" # Green
            #echo -e " (\001\033[0;33m\002$BRANCH\001\033[00m\002)" # Yellow
            #echo -e " ($BRANCH)" # No colour
        fi
    fi
}

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
    xterm-color|*-256color) color_prompt=yes;;
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

if [ "$color_prompt" = yes ]; then
    ## Xubuntu style
    #export PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(git_prompt)\$ '

    ## Win-bash style
    export PS1='\[\033[0;32m\]\u@\h \[\033[0;34m\]\w\[\033[00m\]$(git_prompt)\n\$ '

    ## Fedora style
    #export PS1='[\[\033[0;32m\]\u@\h \[\033[0;34m\]\W\[\033[00m\]$(git_prompt)]\$ '

    ## Xubuntu original
    #PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    ## Xubuntu style
    #export PS1='\u@\h:\w\$ '

    ## Win-bash style
    #export PS1='\u@\h \w\n\$ '

    ## Fedora style
    #export PS1='[\u@\h \W]\$ '

    ## Xubuntu original
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
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

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
