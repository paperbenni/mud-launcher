#!/usr/bin/env bash
fzf() {
    ~/mud/fzf "@"
}

cd "$HOME/mud"

MUDLINK=$(cat mudlist.txt | fzf)
echo "#session $MUDLINK 23" >temp.tin
./tt++ temp.tin
rm temp.tin
