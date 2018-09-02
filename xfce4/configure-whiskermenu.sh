#!/bin/bash
# - 02/09/2018 - SW -
# Change some of the whiskermenu settings. 

#for i in *; do [ -f "$i" ] && echo "$i"; done

echo "Run script outside xfce session (eg. tty or another DE), or changes will not take effect and will be overwritten on logout."

# The number may vary, loop over all config files found.
for FILE in ~/.config/xfce4/panel/whiskermenu-*.rc ; do
    # Check it's a regular file:
    if [ -f "$FILE" ]; then
        echo "Processing whiskermenu config file:"
        echo -e "\t'$FILE'"

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
    fi
done

echo "Done."

