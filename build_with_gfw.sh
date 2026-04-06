#!/bin/bash
set -e

DLC_DATA="/home/felix/software/git-felix/domain-list-community/data"
OUTPUT_DIR="/home/felix/software/git-felix/domain-list-custom/publish"
FLCLASH_DIR="$HOME/.local/share/com.follow.clash"

echo "📥 生成 GFWList 域名列表..."
cd /home/felix/software/git-felix/gfwlist2dnsmasq
sh gfwlist2dnsmasq.sh -l -o /tmp/gfw-domain.txt

echo "📝 转换为 domain-list-community 格式..."
grep -v '^$' /tmp/gfw-domain.txt | grep -v '^#' > /tmp/gfw-clean.txt
cp /tmp/gfw-clean.txt "$DLC_DATA/gfw"

echo "🔨 构建 geosite.dat..."
cd /home/felix/software/git-felix/domain-list-custom
go run ./ --datapath="$DLC_DATA" --outputpath="$OUTPUT_DIR"

echo "📦 安装到 FlClash..."
rm -f "$FLCLASH_DIR/GeoSite.dat" "$FLCLASH_DIR/geosite.dat"
cp "$OUTPUT_DIR/geosite.dat" "$FLCLASH_DIR/GEOSITE.dat"

echo "✅ 完成！请重启 FlClash"
