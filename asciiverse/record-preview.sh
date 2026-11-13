#!/bin/sh
# Record the 100x30 catalog preview, asciiverse/four-in-a-row.cast, with
# hub's castrec.py: the computer playing itself (--demo) on the Classic
# board, 45 s, through a whole game, its winning line and into the next.
set -e
cd "$(dirname "$0")/.."
here=$(pwd)
castrec=$(cd ../../hub/tools && pwd)/castrec.py
cargo build --release
tmp=$(mktemp -d)
cp target/release/four-in-a-row "$tmp/"
(cd "$tmp" && PATH="$tmp:$PATH" HOME="$tmp" XDG_DATA_HOME="$tmp/data" \
  python3 "$castrec" "$here/asciiverse/four-in-a-row.cast" . "w45;kq;w0.5;kq;w0.5" \
  -- four-in-a-row --demo --level "${2:-normal}" --mute --seed "${1:-1}")
rm -rf "$tmp"
