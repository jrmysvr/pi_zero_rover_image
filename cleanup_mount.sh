#!/usr/bin/env bash

set -e

function show_usage_and_exit {
    echo ""
    echo "Usage: $0 < loop device > < mount directory > "
    echo ""
    exit 1
}

if [ "$#" -eq 0 ]; then
    show_usage_and_exit
fi

if [ -z "$1" ]; then
    show_usage_and_exit
fi

if [ -z "$2" ]; then
    show_usage_and_exit
fi

LOOP="$1"
DIR="$2"

echo "Unmounting $DIR"
sudo umount -l "$DIR/boot"
sudo umount -l "$DIR"

echo "Unmounting $LOOP"
# Cleanup
sudo losetup --detach "$LOOP"

echo "All Done"
