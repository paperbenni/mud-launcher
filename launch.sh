#!/usr/bin/env bash

if ! [ -e ~/mud ]; then
    curl https://raw.githubusercontent.com/paperbenni/mud-launcher/master/install.sh | bash
fi

fzf() {
    ~/mud/fzf "$@"
}

cd "$HOME/mud"

MUDLINK=$(cat mudlist.txt | shuf | fzf)
if [ -z "$MUDLINK" ]; then
    echo "no game selected"
    exit
fi
mkdir tin
cd tin

TINFILE="${MUDLINK%%:*}.tin"
if ! [ -e "$TINFILE" ]; then
    echo "creating tintin profile"
    echo "#session ${TINFILE%.*} ${MUDLINK%%:*} ${MUDLINK##*:}" >"$TINFILE"
    echo "#log append $TINFILE.mud" >> "$TINFILE"
    dialog --title "setup" \
        --backtitle "You are joining this MUD for the first time on this machine." \
        --yesno "Do you want to edit the startup commands? (like login commands)" 7 60
    EXIT="$?"
    clear
    if [ "$EXIT" = "0" ]; then
        nvim "$TINFILE" || vi "$TINFILE"
    fi
fi

../tt++ "$TINFILE"
