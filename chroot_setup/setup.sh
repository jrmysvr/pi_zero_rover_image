#!/bin/bash

echo "Updating keys"
bash update_keys.sh

echo "Installing Dependencies"
bash install_dependencies.sh

echo "Adding user"
bash add_user.sh

echo "Setting up the network connection"
bash network.sh

echo "Setting up rover control"
bash enable_serial_and_pwm.sh

cd "/home/pi"
sudo chown -R pi:pi pi/
