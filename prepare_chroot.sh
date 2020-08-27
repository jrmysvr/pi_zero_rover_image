#!/usr/bin/env bash

set -e

function show_usage_and_exit {
    echo ""
    echo "Usage: $0 < mount directory >"
    echo ""
    exit 1
}

if [ "$#" -eq 0 ]; then
    show_usage_and_exit
fi

if [ -z "$1" ]; then
    echo "Missing Argument 1"
    show_usage_and_exit
fi

DIR="$1"

if [ ! -d "$DIR" ]; then
    echo "$DIR doesn't exist"
    exit 1
fi

echo "Mounting directories in $DIR"
sudo mount -t proc none "$DIR/proc"
sudo mount -t sysfs none "$DIR/sys"
sudo mount -o bind /dev "$DIR/dev"

echo "Adding setup files"
sudo mv "$DIR/etc/resolv.conf" "$DIR/etc/resolv.conf.bak"
sudo cp "/etc/resolv.conf" "$DIR/etc/resolv.conf"

sudo cp "/usr/bin/qemu-arm-static" "$DIR/usr/bin"

sudo mkdir -p "$DIR/home/pi"

sudo cp -r "chroot_setup/" "$DIR/home/pi"
sudo cp -r "rover_control/" "$DIR/home/pi"

echo "All Done"
echo "Ready for chroot:"
echo "> sudo chroot $DIR /usr/bin/bash"

