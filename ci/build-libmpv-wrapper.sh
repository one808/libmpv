#!/bin/bash -e
# build-libmpv-wrapper.sh
# 包装脚本：将 ci 脚本复制到 mpv 源码目录并执行构建

MPV_SOURCE="${MPV_SOURCE:-/tmp/mpv-source}"

if [ ! -d "$MPV_SOURCE" ]; then
    echo "Error: MPV_SOURCE directory not found: $MPV_SOURCE" >&2
    exit 1
fi

echo "=== Copying CI scripts to mpv source ==="
cp -v ci/build-libmpv-mingw32.sh "$MPV_SOURCE/ci/"
cp -v ci/build-common.sh "$MPV_SOURCE/ci/"
cp -v ci/charconv_compat.cpp "$MPV_SOURCE/ci/"

echo "=== Building in $MPV_SOURCE ==="
cd "$MPV_SOURCE"
chmod +x ci/build-libmpv-mingw32.sh
./ci/build-libmpv-mingw32.sh

echo "=== Copying artifacts back ==="
cp -rv artifact/* "$OLDPWD/artifact/" 2>/dev/null || true
