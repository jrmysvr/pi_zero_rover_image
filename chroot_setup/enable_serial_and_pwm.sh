
# Enable serial getty
grep 'dtoverlay=dwc2' /boot/config.txt >/dev/null || echo 'dtoverlay=dwc2' >> /boot/config.txt
grep 'modules-load=dwc2,g_serial' /boot/config.txt >/dev/null || sed 's/.*/& modules-load=dwc2,g_serial/' /boot/config.txt >> /boot/config.txt

ln -sf /usr/lib/systemd/system/getty@ttyGS0.service /etc/systemd/system/multi-user.target.wants/getty@ttyGS0.service

# Enable pwm
grep 'dtoverlay=pwm-2chan,pin=12,func=4,pin2=13,func2=4' /boot/config.txt >/dev/null || echo 'dtoverlay=pwm-2chan,pin=12,func=4,pin2=13,func2=4' >> /boot/config.txt
