## Setup process

> bash prepare_image.sh rover_pi.img /mnt/rover_pi

> bash prepare_chroot.sh /mnt/rover_pi

## In Chroot

_chroot into image_

> sudo chroot /mnt/rover_pi /usr/bin/bash

> cd /home/pi/chroot_setup

> sudo bash setup.sh

## Cleaup process

> bash cleanup_chroot.sh /mnt/rover_pi

_(assuming that `/dev/loop20` was created during setup)_

> bash cleanup_mount.sh /dev/loop20 /mnt/rover_pi


## Perform the flash to SD

> sudo dd if=rover_pi.img of=/dev/mmcblk0 bs=2M status=progress

## First run

> cd /home/pi/chroot_setup

(edit `rover_config` with desired hostname)

`rover_config`
```
...

HOSTNAME="green_rover"

...

```

> sudo bash first_run_setup.sh

---

Notes:
 - The custom image should be at least 4G for the lite version of raspberry
> fallocate -l 4G "custom-pi.img"

Password:

`raspberry`

> echo -e "raspberry\nraspberry" | passwd "pi"


Setup keys for using pacman
```
    rm -R /etc/pacman.d/gnupg/
    gpg --refresh-keys
    pacman-key --init
    pacman-key --populate
    pacman-key --refresh-keys
```

Resources:
https://disconnected.systems/blog/raspberry-pi-archlinuxarm-setup

Troubleshooting:

- Problem with keyring in archlinux
    - https://bbs.archlinux.org/viewtopic.php?id=193382


