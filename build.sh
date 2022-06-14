#!/bin/sh

set -ex

VERSION='22.05'

apk add --update --no-cache bash git gcc build-base musl-dev rustup && rm -rf /var/cache/apk/*
rustup update

git clone --recurse-submodules --shallow-submodules -j8 --depth=1 -b $VERSION https://github.com/helix-editor/helix

cd helix

cargo install --path helix-term --root . --target x86_64-unknown-linux-musl
hx --grammar fetch
hx --grammar build

cp ./bin/hx ../
cp -r ./runtime ../
echo $VERSION > ../version
