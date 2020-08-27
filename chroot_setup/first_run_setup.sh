#!/bin/bash

source rover_config

echo "Adding hostname"
bash add_host.sh

echo "Setting up rover control"
bash "$ROVER_DIR/setup.sh"
