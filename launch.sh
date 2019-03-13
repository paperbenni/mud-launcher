#!/usr/bin/env bash
fzf() {
    ~/mud/fzf "$@"
}

cd "$HOME/mud"

MUDLINK=$(cat mudlist.txt | fzf)
mkdir tin
cd tin

if ! [ -e "$MUDLINK.tin" ]; then
    echo "#session ${MUDLINK%.*} $MUDLINK 23" >"$MUDLINK".tin
    echo "creating tintin profile"
    dialog --title "setup" \
        --backtitle "You are joining this MUD for the first time on this machine." \
        --yesno "Do you want to edit the startup commands? (like login commands)" 7 60
    EXIT="$?"
    clear
    if [ "$EXIT" = "0" ]; then
        nvim "$MUDLINK.tin" || vi "$MUDLINK.tin"
    fi
fi

../tt++ "$MUDLINK.tin"
