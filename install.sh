#!/usr/bin/env bash

source <(curl -s https://raw.githubusercontent.com/paperbenni/bash/master/import.sh)

pb unpack/unpack.sh

cd "$HOME"
rm -rf mud
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

curl https://www.mudconnect.com/cgi-bin/search.cgi?mode=tmc_biglist >download.txt
grep -oP 'telnet.?://\S+' download.txt >temp.txt

while read p; do
    NOPREFIX=${p#telnet://}
    NAME=${NOPREFIX%\'}
    if echo "$NAME" | grep -E '^[0-9.:]+$'; then
        echo "skipping"
        continue

    fi
    echo "$NAME" >>mudlist.txt
done <temp.txt

rm temp.txt
