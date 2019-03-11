#!/usr/bin/env bash

pb() {
    if [ -z "$@" ]; then
        echo "usage: pb bashfile"
    fi
    for FILE in "$@"; do
        curl "https://raw.githubusercontent.com/paperbenni/bash/master/$1" >temp.sh
        source temp.sh
        rm temp.sh
    done
}

pb unpack/unpack.sh

cd "$HOME"
mkdir mud
cd mud
if ! fzf --version || ! ./fzf --version; then
    wget https://github.com/junegunn/fzf-bin/releases/download/0.17.5/fzf-0.17.5-linux_amd64.tgz
    unpack *.tgz
    rm *.tgz
    chmod +x fzf
fi

rm tt++
wget http://tintin.surge.sh/tt++
chmod +x tt++

curl https://www.mudconnect.com/cgi-bin/search.cgi?mode=tmc_biglist | grep -Eo "(http|telnet)://[a-zA-Z0-9./?=_-]*" | sort | uniq >temp.txt

while read p; do
    NAME=${p#telnet://}
    echo "$NAME" >>mudlist.txt
done <temp.txt

rm temp.txt
