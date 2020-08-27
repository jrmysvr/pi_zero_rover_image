#!/usr/bin/env bash

set -e

ARCH="/home/jeremy/images/ArchLinuxARM-rpi-latest.tar.gz"

function show_usage_and_exit {
    echo ""
    echo "Usage: $0 < img filename > < mount directory >"
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

if [ -z "$2" ]; then
    echo "Missing Argument 2"
    show_usage_and_exit
fi

IMG="$1"
DIR="$2"

# Check that image doesn't already exist
if [ -f "$IMG" ]; then
    echo "$IMG already exists"
fi

if [ ! -d "$DIR" ]; then
    echo "$DIR doesn't exist"
    echo "Creating new directory $DIR"
    sudo mkdir -p "$DIR"
fi

echo "Creating new image: $IMG"
# Allocate Memory for image
fallocate -l 4G "$IMG"

LOOP=$(sudo losetup --find --show "$IMG")
P1="$LOOP"p1
P2="$LOOP"p2

echo "Creating LOOP device: $LOOP"

echo "Creating Partitions and Filesytems"
sudo parted --script "$LOOP" mklabel msdos
sudo parted --script "$LOOP" mkpart primary fat32 0% 250M
sudo parted --script "$LOOP" mkpart primary ext4 250M 100%

sudo mkfs.vfat -F32 "$P1"
sudo mkfs.ext4 -F "$P2"

echo "Mounting the LOOP device"
sudo mount "$P2" "$DIR"

if [ ! -d "$DIR/boot" ]; then
    echo "Creating new boot directory: $DIR/boot"
    sudo mkdir "$DIR/boot"
fi

sudo mount "$P1" "$DIR/boot"

echo "Extracting OS image to $DIR"
sudo tar -xpf "$ARCH" -C "$DIR"

echo "All Done"

