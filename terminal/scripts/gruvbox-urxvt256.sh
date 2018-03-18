#!/bin/sh
# base16-shell (https://github.com/chriskempson/base16-shell)
# Set additional colours from gruvbox-urxvt256.xresources

# -----------------------------------------------------------------------------
# File: gruvbox-urxvt256.xresources
# Description: Retro groove colorscheme generalized
# Author: morhetz <morhetz@gmail.com>
# Source: https://github.com/morhetz/gruvbox-generalized
# Last Modified: 13 Dec 2013
# -----------------------------------------------------------------------------

color24="07/66/78"
color66="42/7b/58"
color88="9d/00/06"
color96="8f/3f/71"
color100="79/74/0e"
color108="8e/c0/7c"
color109="83/a5/98"
color130="af/3a/03"
color136="b5/76/14"
color142="b8/bb/26"
color167="fb/49/34"
color175="d3/86/9b"
color208="fe/80/19"
color214="fa/bd/2f"
color223="eb/db/b2"
color228="f2/e5/bc"
color229="fb/f1/c7"
color230="f9/f5/d7"
color234="1d/20/21"
color235="28/28/28"
color236="32/30/2f"
color237="3c/38/36"
color239="50/49/45"
color241="66/5c/54"
color243="7c/6f/64"
color244="92/83/74"
color245="92/83/74"
color246="a8/99/84"
color248="bd/ae/93"
color250="d5/c4/a1"

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

put_template 24 $color24
put_template 66 $color66
put_template 88 $color88
put_template 96 $color96
put_template 100 $color100
put_template 108 $color108
put_template 109 $color109
put_template 130 $color130
put_template 136 $color136
put_template 142 $color142
put_template 167 $color167
put_template 175 $color175
put_template 208 $color208
put_template 214 $color214
put_template 223 $color223
put_template 228 $color228
put_template 229 $color229
put_template 230 $color230
put_template 234 $color234
put_template 235 $color235
put_template 236 $color236
put_template 237 $color237
put_template 239 $color239
put_template 241 $color241
put_template 243 $color243
put_template 244 $color244
put_template 245 $color245
put_template 246 $color246
put_template 248 $color248
put_template 250 $color250

# clean up
unset -f put_template
unset -f put_template_var
unset -f put_template_custom
unset color24
unset color66
unset color88
unset color96
unset color100
unset color108
unset color109
unset color130
unset color136
unset color142
unset color167
unset color175
unset color208
unset color214
unset color223
unset color228
unset color229
unset color230
unset color234
unset color235
unset color236
unset color237
unset color239
unset color241
unset color243
unset color244
unset color245
unset color246
unset color248
unset color250
