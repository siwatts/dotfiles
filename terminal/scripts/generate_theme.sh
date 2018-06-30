#!/bin/bash
# - SW - 18/03/2018 -
# Generate shell script from .Xresources theme.

if [ -z "$1" ]
    then
        echo 'Please supply an .Xresources file with colours to convert.'
        exit 1
fi

echo "#!/bin/sh
# base16-shell (https://github.com/chriskempson/base16-shell)
# Base16 Shell template by Chris Kempson (http://chriskempson.com)
# Shell script generated from file $1
"

echo -n 'color_foreground="'
sed -n -e 's/^\s*[^!]*foreground[^0-9]*:.*#\([a-zA-Z0-9][a-zA-Z0-9]\)\([a-zA-Z0-9][a-zA-Z0-9]\)\([a-zA-Z0-9][a-zA-Z0-9]\)/\1\/\2\/\3"/p' "$1"
echo -n 'color_background="'
sed -n -e 's/^\s*[^!]*background[^0-9]*:.*#\([a-zA-Z0-9][a-zA-Z0-9]\)\([a-zA-Z0-9][a-zA-Z0-9]\)\([a-zA-Z0-9][a-zA-Z0-9]\)/\1\/\2\/\3"/p' "$1"

echo -n 'color00="'
sed -n -e 's/^\s*[^!]*color0[^0-9]*:.*#\([a-zA-Z0-9][a-zA-Z0-9]\)\([a-zA-Z0-9][a-zA-Z0-9]\)\([a-zA-Z0-9][a-zA-Z0-9]\)/\1\/\2\/\3"/p' "$1"
echo -n 'color08="'
sed -n -e 's/^\s*[^!]*color8[^0-9]*:.*#\([a-zA-Z0-9][a-zA-Z0-9]\)\([a-zA-Z0-9][a-zA-Z0-9]\)\([a-zA-Z0-9][a-zA-Z0-9]\)/\1\/\2\/\3"/p' "$1"
echo -n 'color01="'
sed -n -e 's/^\s*[^!]*color1[^0-9]*:.*#\([a-zA-Z0-9][a-zA-Z0-9]\)\([a-zA-Z0-9][a-zA-Z0-9]\)\([a-zA-Z0-9][a-zA-Z0-9]\)/\1\/\2\/\3"/p' "$1"
echo -n 'color09="'
sed -n -e 's/^\s*[^!]*color9[^0-9]*:.*#\([a-zA-Z0-9][a-zA-Z0-9]\)\([a-zA-Z0-9][a-zA-Z0-9]\)\([a-zA-Z0-9][a-zA-Z0-9]\)/\1\/\2\/\3"/p' "$1"
echo -n 'color02="'
sed -n -e 's/^\s*[^!]*color2[^0-9]*:.*#\([a-zA-Z0-9][a-zA-Z0-9]\)\([a-zA-Z0-9][a-zA-Z0-9]\)\([a-zA-Z0-9][a-zA-Z0-9]\)/\1\/\2\/\3"/p' "$1"
echo -n 'color10="'
sed -n -e 's/^\s*[^!]*color10[^0-9]*:.*#\([a-zA-Z0-9][a-zA-Z0-9]\)\([a-zA-Z0-9][a-zA-Z0-9]\)\([a-zA-Z0-9][a-zA-Z0-9]\)/\1\/\2\/\3"/p' "$1"
echo -n 'color03="'
sed -n -e 's/^\s*[^!]*color3[^0-9]*:.*#\([a-zA-Z0-9][a-zA-Z0-9]\)\([a-zA-Z0-9][a-zA-Z0-9]\)\([a-zA-Z0-9][a-zA-Z0-9]\)/\1\/\2\/\3"/p' "$1"
echo -n 'color11="'
sed -n -e 's/^\s*[^!]*color11[^0-9]*:.*#\([a-zA-Z0-9][a-zA-Z0-9]\)\([a-zA-Z0-9][a-zA-Z0-9]\)\([a-zA-Z0-9][a-zA-Z0-9]\)/\1\/\2\/\3"/p' "$1"
echo -n 'color04="'
sed -n -e 's/^\s*[^!]*color4[^0-9]*:.*#\([a-zA-Z0-9][a-zA-Z0-9]\)\([a-zA-Z0-9][a-zA-Z0-9]\)\([a-zA-Z0-9][a-zA-Z0-9]\)/\1\/\2\/\3"/p' "$1"
echo -n 'color12="'
sed -n -e 's/^\s*[^!]*color12[^0-9]*:.*#\([a-zA-Z0-9][a-zA-Z0-9]\)\([a-zA-Z0-9][a-zA-Z0-9]\)\([a-zA-Z0-9][a-zA-Z0-9]\)/\1\/\2\/\3"/p' "$1"
echo -n 'color05="'
sed -n -e 's/^\s*[^!]*color5[^0-9]*:.*#\([a-zA-Z0-9][a-zA-Z0-9]\)\([a-zA-Z0-9][a-zA-Z0-9]\)\([a-zA-Z0-9][a-zA-Z0-9]\)/\1\/\2\/\3"/p' "$1"
echo -n 'color13="'
sed -n -e 's/^\s*[^!]*color13[^0-9]*:.*#\([a-zA-Z0-9][a-zA-Z0-9]\)\([a-zA-Z0-9][a-zA-Z0-9]\)\([a-zA-Z0-9][a-zA-Z0-9]\)/\1\/\2\/\3"/p' "$1"
echo -n 'color06="'
sed -n -e 's/^\s*[^!]*color6[^0-9]*:.*#\([a-zA-Z0-9][a-zA-Z0-9]\)\([a-zA-Z0-9][a-zA-Z0-9]\)\([a-zA-Z0-9][a-zA-Z0-9]\)/\1\/\2\/\3"/p' "$1"
echo -n 'color14="'
sed -n -e 's/^\s*[^!]*color14[^0-9]*:.*#\([a-zA-Z0-9][a-zA-Z0-9]\)\([a-zA-Z0-9][a-zA-Z0-9]\)\([a-zA-Z0-9][a-zA-Z0-9]\)/\1\/\2\/\3"/p' "$1"
echo -n 'color07="'
sed -n -e 's/^\s*[^!]*color7[^0-9]*:.*#\([a-zA-Z0-9][a-zA-Z0-9]\)\([a-zA-Z0-9][a-zA-Z0-9]\)\([a-zA-Z0-9][a-zA-Z0-9]\)/\1\/\2\/\3"/p' "$1"
echo -n 'color15="'
sed -n -e 's/^\s*[^!]*color15[^0-9]*:.*#\([a-zA-Z0-9][a-zA-Z0-9]\)\([a-zA-Z0-9][a-zA-Z0-9]\)\([a-zA-Z0-9][a-zA-Z0-9]\)/\1\/\2\/\3"/p' "$1"

echo ''

echo '# Restore colors 16-21 to pre-base16 values.
color16="00/00/00"
color17="00/00/5f"
color18="00/00/87"
color19="00/00/af"
color20="00/00/d7"
color21="00/00/ff"

if [ -n "$TMUX" ]; then
  # Tell tmux to pass the escape sequences through
  # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
  put_template() { printf '"'"'\033Ptmux;\033\033]4;%d;rgb:%s\033\033\\\033\\'"'"' $@; }
  put_template_var() { printf '"'"'\033Ptmux;\033\033]%d;rgb:%s\033\033\\\033\\'"'"' $@; }
  put_template_custom() { printf '"'"'\033Ptmux;\033\033]%s%s\033\033\\\033\\'"'"' $@; }
elif [ "${TERM%%[-.]*}" = "screen" ]; then
  # GNU screen (screen, screen-256color, screen-256color-bce)
  put_template() { printf '"'"'\033P\033]4;%d;rgb:%s\007\033\\'"'"' $@; }
  put_template_var() { printf '"'"'\033P\033]%d;rgb:%s\007\033\\'"'"' $@; }
  put_template_custom() { printf '"'"'\033P\033]%s%s\007\033\\'"'"' $@; }
elif [ "${TERM%%-*}" = "linux" ]; then
  put_template() { [ $1 -lt 16 ] && printf "\e]P%x%s" $1 $(echo $2 | sed '"'"'s/\///g'"'"'); }
  put_template_var() { true; }
  put_template_custom() { true; }
else
  put_template() { printf '"'"'\033]4;%d;rgb:%s\033\\'"'"' $@; }
  put_template_var() { printf '"'"'\033]%d;rgb:%s\033\\'"'"' $@; }
  put_template_custom() { printf '"'"'\033]%s%s\033\\'"'"' $@; }
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
'
