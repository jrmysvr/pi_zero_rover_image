pacman -S --noconfirm wpa_supplicant wpa_actiond ifplugd crda dialog
ln -sf /usr/lib/systemd/system/netctl-auto@.service /etc/systemd/system/multi-user.target.wants/netctl-auto@wlan0.service
ln -sf /usr/lib/systemd/system/netctl-ifplugd@.service /etc/systemd/system/multi-user.target.wants/netctl-ifplugd@eth0.service

sudo cp wlan0-mmmWifi /etc/netctl/

pacman -S --noconfirm avahi nss-mdns
sed -i '/^hosts: /s/files dns/files mdns dns/' /etc/nsswitch.conf
ln -sf /usr/lib/systemd/system/avahi-daemon.service /etc/systemd/system/multi-user.target.wants/avahi-daemon.service
