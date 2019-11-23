#!/usr/bin/env bash

cd
curl https://raw.githubusercontent.com/paperbenni/mud-launcher/master/launch.sh >mudlauncher
sudo mv mudlauncher /bin/
sudo chmod +x /bin/mudlauncher

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

mkdir ~/mud
