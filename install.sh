#!/usr/bin/env bash

cd /bin
sudo curl https://raw.githubusercontent.com/paperbenni/mud-launcher/master/launch.sh >mud
sudo chmod +x mud
cd

if ! command -v dialog &>/dev/null; then
    pb install/install.sh
    sudo pinstall dialog grep
fi

cd "$HOME"
rm -rf mud
if ! command -v fzf; then
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
fi

if ! command -v tt++; then
    cd /bin
    sudo wget tintin.surge.sh/tt++
    sudo chmod +x tt++
fi

cd
mkdir mud
cd mud

echo "looking for games..."
curl -s https://www.mudconnect.com/cgi-bin/search.cgi?mode=tmc_biglist >download.txt
grep -oP 'telnet.?://\S+' download.txt >temp.txt

while read p; do
    NOPREFIX=${p#telnet://}
    NAME=${NOPREFIX%\'}
    if echo "$NAME" | grep -E '^[0-9.:]+$' >/dev/null; then
        echo "skipping ip adress"
        continue
    else
        echo "adding game $NAME"
    fi
    echo "$NAME" >>mudlist.txt
done <temp.txt

rm temp.txt
curl -s https://raw.githubusercontent.com/paperbenni/mud-launcher/master/muds.txt >>mudlist.txt
