#!/bin/sh
# base16-shell (https://github.com/chriskempson/base16-shell)
# Base16 Shell template by Chris Kempson (http://chriskempson.com)

# Dracula Theme (http://github.com/dracula)
# Swap red for orange taken from dracula.vim
# Swap bright black for comment colour (https://github.com/dracula/dracula-theme)
color_foreground="F8/F8/F2"
color_background="28/2A/36"
color00="00/00/00"
color08="62/72/A4"
color01="FF/B8/6C"
color09="FF/B8/6C"
color02="50/FA/7B"
color10="5A/F7/8E"
color03="F1/FA/8C"
color11="F4/F9/9D"
color04="BD/93/F9"
color12="CA/A9/FA"
color05="FF/79/C6"
color13="FF/92/D0"
color06="8B/E9/FD"
color14="9A/ED/FE"
color07="BF/BF/BF"
color15="E6/E6/E6"

# Restore colors 16-21 to pre-base16 values.
color16="00/00/00"
color17="00/00/5f"
color18="00/00/87"
color19="00/00/af"
color20="00/00/d7"
color21="00/00/ff"

#color00="28/29/36" # Base 00 - Black
#color01="ea/51/b2" # Base 08 - Red
#color02="eb/ff/87" # Base 0B - Green
#color03="00/f7/69" # Base 0A - Yellow
#color04="62/d6/e8" # Base 0D - Blue
#color05="b4/5b/cf" # Base 0E - Magenta
#color06="a1/ef/e4" # Base 0C - Cyan
#color07="e9/e9/f4" # Base 05 - White
#color08="62/64/83" # Base 03 - Bright Black
#color09=$color01 # Base 08 - Bright Red
#color10=$color02 # Base 0B - Bright Green
#color11=$color03 # Base 0A - Bright Yellow
#color12=$color04 # Base 0D - Bright Blue
#color13=$color05 # Base 0E - Bright Magenta
#color14=$color06 # Base 0C - Bright Cyan
#color15="f7/f7/fb" # Base 07 - Bright White
#color16="b4/5b/cf" # Base 09
#color17="00/f7/69" # Base 0F
#color18="3a/3c/4e" # Base 01
#color19="4d/4f/68" # Base 02
#color20="62/d6/e8" # Base 04
#color21="f1/f2/f8" # Base 06
#color_foreground="e9/e9/f4" # Base 05
#color_background="28/29/36" # Base 00

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

# 16 color space
put_template 0  $color00
put_template 1  $color01
put_template 2  $color02
put_template 3  $color03
put_template 4  $color04
put_template 5  $color05
put_template 6  $color06
put_template 7  $color07
put_template 8  $color08
put_template 9  $color09
put_template 10 $color10
put_template 11 $color11
put_template 12 $color12
put_template 13 $color13
put_template 14 $color14
put_template 15 $color15

# 256 color space
put_template 16 $color16
put_template 17 $color17
put_template 18 $color18
put_template 19 $color19
put_template 20 $color20
put_template 21 $color21

# foreground / background / cursor color
if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg e9e9f4 # foreground
  put_template_custom Ph 282936 # background
  put_template_custom Pi e9e9f4 # bold color
  put_template_custom Pj 4d4f68 # selection color
  put_template_custom Pk e9e9f4 # selected text color
  put_template_custom Pl e9e9f4 # cursor
  put_template_custom Pm 282936 # cursor text
else
  put_template_var 10 $color_foreground
  if [ "$BASE16_SHELL_SET_BACKGROUND" != false ]; then
    put_template_var 11 $color_background
    if [ "${TERM%%-*}" = "rxvt" ]; then
      put_template_var 708 $color_background # internal border (rxvt)
    fi
  fi
  #put_template_custom 12 ";7" # cursor (reverse video)
  #put_template_custom 12 ";#ff66ff" # cursor (reverse video)
fi

# clean up
unset -f put_template
unset -f put_template_var
unset -f put_template_custom
unset color00
unset color01
unset color02
unset color03
unset color04
unset color05
unset color06
unset color07
unset color08
unset color09
unset color10
unset color11
unset color12
unset color13
unset color14
unset color15
unset color16
unset color17
unset color18
unset color19
unset color20
unset color21
unset color_foreground
unset color_background
