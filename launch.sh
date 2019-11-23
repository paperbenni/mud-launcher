#!/usr/bin/env bash
echo "mud launcher started"

cd ~/

if ! [ -e mud ]; then
    curl https://raw.githubusercontent.com/paperbenni/mud-launcher/master/install.sh | bash
fi

cd mud

# scrape list of muds
if ! [ -e mudlist.txt ]; then
    grep -o 'telnet://.*:[0-9]*'"'" <mud.html | grep -o '//.*' | \
    grep -o '[^'"'"'/]*' | grep -Ev '^[0-9:]*$' >mudlist.txt

    curl -s "https://raw.githubusercontent.com/paperbenni/mud-launcher/master/muds.txt" >>mudlist.txt
fi

#select the game with format gameurl:port
MUDLINK=$(shuf <mudlist.txt | fzf)

if [ -z "$MUDLINK" ]; then
    echo "no game selected"
    exit
fi

mkdir tin
cd tin

TINNAME="${MUDLINK%%:*}"
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
        nvim "$TINNAME.tin" || vi "$TINNAME.tin"
    fi
fi

tt++ "$TINNAME.tin"
