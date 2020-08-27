#!/bin/bash

rm -R /etc/pacman.d/gnupg/
gpg --refresh-keys
pacman-key --init
pacman-key --populate
pacman-key --refresh-keys
