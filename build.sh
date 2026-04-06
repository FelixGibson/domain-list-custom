#!/bin/bash
cd /home/felix/software/git-felix/domain-list-custom
go run ./ --datapath=/home/felix/software/git-felix/domain-list-community/data --outputpath=./publish
cp ./publish/geosite.dat ~/.local/share/com.follow.clash/GEOSITE.dat
echo "✅ GEOSITE.dat updated!"
