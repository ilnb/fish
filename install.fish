#!/usr/bin/env fish

curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher
sleep 2
fisher install IlanCosman/tide@v6
cp fish_variables{.bak,}
