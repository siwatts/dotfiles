#!/bin/sh
# base16-shell (https://github.com/chriskempson/base16-shell)
# Extract just the cursor/bg/fg stuff to change on the fly.

# Allow calling with parameters from shell.
if [ -z "$1" ]
    then
        color_cursor="FF66FF"
    else
        color_cursor="$1"
fi

color_background="28/2A/36"
color_foreground="F8/F8/F2"

if [ -n "$TMUX" ]; then
  # Tell tmux to pass the escape sequences through
  # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
  put_template() { printf '\033Ptmux;\033\033]4;%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_var() { printf '\033Ptmux;\033\033]%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_custom() { printf '\033Ptmux;\033\033]%s%s\033\033\\\033\\' $@; }
elif [ "${TERM%%[-.]*}" = "screen" ]; then
  # GNU screen (screen, screen-256color, screen-256color-bce)
  put_template() { printf '\033P\033]4;%d;rgb:%s\007\033\\' $@; }
  put_template_var() { printf '\033P\033]%d;rgb:%s\007\033\\' $@; }
  put_template_custom() { printf '\033P\033]%s%s\007\033\\' $@; }
elif [ "${TERM%%-*}" = "linux" ]; then
  put_template() { [ $1 -lt 16 ] && printf "\e]P%x%s" $1 $(echo $2 | sed 's/\///g'); }
  put_template_var() { true; }
  put_template_custom() { true; }
else
  put_template() { printf '\033]4;%d;rgb:%s\033\\' $@; }
  put_template_var() { printf '\033]%d;rgb:%s\033\\' $@; }
  put_template_custom() { printf '\033]%s%s\033\\' $@; }
fi

# foreground / background / cursor color
if [ -n "$ITERM_SESSION_ID" ]; then
#  # iTerm2 proprietary escape codes
#  put_template_custom Pg e9e9f4 # foreground
#  put_template_custom Ph 282936 # background
#  put_template_custom Pi e9e9f4 # bold color
#  put_template_custom Pj 4d4f68 # selection color
#  put_template_custom Pk e9e9f4 # selected text color
  put_template_custom Pl e9e9f4 # cursor
  put_template_custom Pm 282936 # cursor text
else
#  put_template_var 10 $color_foreground
#  if [ "$BASE16_SHELL_SET_BACKGROUND" != false ]; then
#    put_template_var 11 $color_background
#    if [ "${TERM%%-*}" = "rxvt" ]; then
#      put_template_var 708 $color_background # internal border (rxvt)
#    fi
#  fi
  #put_template_custom 12 ";7" # cursor (reverse video)
  put_template_custom 12 ";#$color_cursor" # cursor (reverse video)
fi

# clean up
unset -f put_template
unset -f put_template_var
unset -f put_template_custom
unset color_foreground
unset color_background
unset color_cursor
