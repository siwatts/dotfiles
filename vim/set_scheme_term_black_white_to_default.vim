set hidden
bufdo %s/\<\(cterm.g\)=0\>/\1=16/ge
bufdo %s/\<\(cterm.g\)=[Bb]lack\>/\1=16/ge
bufdo %s/\<\(cterm.g\)=7\>/\1=250/ge
bufdo %s/\<\(cterm.g\)=[Ss]ilver\>/\1=250/ge
bufdo %s/\<\(cterm.g\)=8\>/\1=244/ge
bufdo %s/\<\(cterm.g\)=[Gg]rey\>/\1=244/ge
bufdo %s/\<\(cterm.g\)=15\>/\1=231/ge
bufdo %s/\<\(cterm.g\)=[Ww]hite\>/\1=231/ge
wqa
