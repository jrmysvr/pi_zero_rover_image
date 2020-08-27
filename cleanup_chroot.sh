#!/usr/bin/env bash

set -e

function show_usage_and_exit {
    echo ""
    echo "Usage: $0 < mount directory > "
    echo ""
    exit 1
}

if [ "$#" -eq 0 ]; then
    show_usage_and_exit
fi

if [ -z "$1" ]; then
    show_usage_and_exit
fi

DIR="$1"

echo "Reverting/Removing setup files"
sudo rm "$DIR/etc/resolv.conf"
sudo mv "$DIR/etc/resolv.conf.bak" "$DIR/etc/resolv.conf"
sudo rm "$DIR/usr/bin/qemu-arm-static"

echo "Unmounting $DIR"
sudo umount -l "$DIR/dev"
sudo umount "$DIR/proc"
sudo umount "$DIR/sys"

echo "All Done"
