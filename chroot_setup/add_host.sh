
source rover_config

echo "$HOSTNAME" > /etc/hostname
sudo hostnamectl set-hostname "$HOSTNAME"


