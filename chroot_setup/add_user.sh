
sed -i "s/alarm/pi/g" /etc/passwd /etc/group /etc/shadow

if [ -d "/home/alarm" ]; then
    mv /home/alarm /home/pi
fi

echo "Enabling sudo for 'pi'"
bash enable_sudo.sh
