#!/bin/bash
set -e

DLC_DATA="/home/felix/software/git-felix/domain-list-community/data"
OUTPUT_DIR="/home/felix/software/git-felix/domain-list-custom/publish"
FLCLASH_DIR="$HOME/.local/share/com.follow.clash"

echo "🔨 构建 geosite.dat..."
cd /home/felix/software/git-felix/domain-list-custom
go run ./ --datapath="$DLC_DATA" --outputpath="$OUTPUT_DIR"

echo "📦 安装到 FlClash..."
# 删除旧文件，使用 GEOSITE.dat（大写）
rm -f "$FLCLASH_DIR/GeoSite.dat" "$FLCLASH_DIR/geosite.dat"
cp "$OUTPUT_DIR/geosite.dat" "$FLCLASH_DIR/GEOSITE.dat"

echo "✅ 完成！请重启 FlClash"
