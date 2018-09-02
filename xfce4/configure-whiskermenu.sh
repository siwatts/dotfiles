#!/bin/bash
# - 02/09/2018 - SW -
# Change some of the whiskermenu settings. 

FILE="~/.config/xfce4/panel/whiskermenu-17.rc"

if [ ! -f "$FILE" ]; then
    echo "Looking for whiskermenu config file at:"
    echo "\t'~/.config/xfce4/panel/whiskermenu-17.rc'"
    echo "File not found."
    exit 1
fi

echo "Run script outside xfce session (eg. tty or another DE), or changes"
echo "will not take effect and will be overwritten on logout."

sed -i 's/^button-title=.*$/button-title=Whisker Menu/' $FILE
sed -i 's/^show-button-title=.*$/show-button-title=true/' $FILE
sed -i 's/^item-icon-size=.*$/item-icon-size=2/' $FILE
sed -i 's/^hover-switch-category=.*$/hover-switch-category=true/' $FILE
sed -i 's/^category-icon-size=.*$/category-icon-size=2/' $FILE
sed -i 's/^menu-width=.*$/menu-width=550/' $FILE
#sed -i 's/^menu-height=.*$/menu-height=900/' $FILE
sed -i 's/^menu-height=.*$/menu-height=700/' $FILE
sed -i 's/^menu-opacity=.*$/menu-opacity=100/' $FILE
#sed -i 's/^position-search-alternate=.*$/position-search-alternate=true/' $FILE
#sed -i 's/^position-commands-alternate=.*$/position-commands-alternate=true/' $FILE

