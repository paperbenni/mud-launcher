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
    dialog --title "Password" \
        --backtitle "Save your username and password" \
        --yesno "Do you want to remember your password?" 7 60
    EXIT="$?"
    clear
    if [ "$EXIT" = "0" ]; then
        echo "username"
        read MUDNAME
        echo "$MUDNAME" >>"$MUDLINK.tin"
        echo "password"
        read MUDPASS
        echo "$MUDPASS" | sed 's/#/\\#/g' >>"$MUDLINK.tin"
    fi
fi

../tt++ "$MUDLINK.tin"
