#!/bin/bash

CURRENT_USER=$(whoami)

echo "Upgrading packages and installing feh"
sudo apt update && sudo apt upgrade -y && sudo apt install feh -y

echo "Creating the target directory and downloading the slideshow script"

# Create the target directory if it doesn't exist
mkdir -p /home/$CURRENT_USER/Documents/slideshow

# Download start.sh to the target directory
wget -O /home/$CURRENT_USER/Documents/slideshow/start.sh https://raw.githubusercontent.com/oforfamar/digital-frame/refs/heads/main/start.sh

# Make the downloaded script executable
chmod +x /home/$CURRENT_USER/Documents/slideshow/start.sh

echo "Creating the autostart .desktop file for the current user"

# Create the target directory if it doesn't exist
mkdir -p /home/$CURRENT_USER/.config/autostart

# Change to the target directory
cd /home/$CURRENT_USER/.config/autostart

# Create the .desktop file
touch slideshow.desktop

# Write the contents of the .desktop file
cat <<EOT >> slideshow.desktop
[Desktop Entry]
Type=Application
Name=Slideshow
Comment=Start picture slideshow on login
Exec=/home/$CURRENT_USER/Documents/slideshow/start.sh
NoDisplay=false
EOT

echo "Install finished. Please reboot to see the slideshow in action."
