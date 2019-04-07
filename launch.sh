#!/usr/bin/env bash
echo "mud launcher started"

cd ~/

if ! [ -e mud ]; then
    curl https://raw.githubusercontent.com/paperbenni/mud-launcher/master/install.sh | bash
fi

cd mud

#select the game with format gameurl:port
MUDLINK=$(shuf <mudlist.txt | fzf)
if [ -z "$MUDLINK" ]; then
    echo "no game selected"
    exit
fi

mkdir tin
cd tin

TINNAME="${MUDLINK%%:*}.tin"
if ! [ -e "$TINNAME.tin" ]; then
    echo "creating tintin profile"
    echo "#session ${TINNAME%%.*} ${MUDLINK%%:*} ${MUDLINK##*:}" >"$TINNAME.tin"
    echo "#log append $TINNAME.mud" >>"$TINNAME.tin"
    dialog --title "setup" \
        --backtitle "You are joining this MUD for the first time on this machine." \
        --yesno "Do you want to edit the startup commands? (like login commands)" 7 60
    EXIT="$?"
    clear
    if [ "$EXIT" = "0" ]; then
        nvim "$TINFILE" || vi "$TINFILE"
    fi
fi

tt++ "$TINFILE"
