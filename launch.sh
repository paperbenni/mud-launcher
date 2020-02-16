#!/bin/bash

cd

if ! ping -c 1 google.com &>/dev/null; then
    echo "an internet connection is required"
    exit
fi

if ! [ -e .cache/muds/muds.txt ]; then
    echo "getting list of muds"
    mkdir -p .cache/muds
    cd .cache/muds
    curl -s http://www.mudconnect.com/cgi-bin/search.cgi?mode=tmc_biglist |
        grep -o '=telnet://.*:[0-9]*'"'" |
        sed 's~.*://\(.*:[0-9]*\).*~\1~g' >muds.txt
    curl -s https://raw.githubusercontent.com/paperbenni/mud-launcher/master/muds.txt >>muds.txt
    cd
fi

if ! command -v tt++ &>/dev/null; then
    echo "tintin not found"
    if command -v pacman; then
        sudo pacman -S --noconfirm tintin
    elif command -v apt; then
        sudo apt install -y tintin++
    fi
fi

if ! command -v fzf &>/dev/null; then
    echo "tintin not found"
    if command -v pacman; then
        sudo pacman -S --noconfirm fzf
    elif command -v apt; then
        sudo apt install -y fzf
    fi
fi

MUD=$(cat .cache/muds/muds.txt | fzf)

MUDNAME=$(grep -o '^[^:]*' <<<$MUD)
MUDPORT=$(grep -o '[^:]*$' <<<$MUD)

echo "name $MUDNAME port $MUDPORT"
echo "#session $MUDNAME $MUDNAME $MUDPORT" >/tmp/mud.tin
tt++ /tmp/mud.tin
