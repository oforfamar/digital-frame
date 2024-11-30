#!/bin/bash

sleep 10
export DISPLAY=:0

# Get the current user
CURRENT_USER=$(whoami)
feh -r /home/$CURRENT_USER/Pictures -D20 -F -z -Z --hide-pointer
