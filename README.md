# digital-frame

This project is a gift idea for my parents that have a lot of digital photos and complained about issues with their current store bought digital photo frame.

Because i am a fan of RaspberryPi, i decided to go the DIY route and create a better digital photo frame, suited to their needs.

Using the `feh` app i am amble to have it autostart at boot and go randomly through all the pictures in a folder and sub folders.

## Installation

Execute the command below in a terminal to install the slideshow

```bash
wget -O - https://raw.githubusercontent.com/oforfamar/digital-frame/refs/heads/main/install.sh | bash
```

## Brightness crons

The scripts have been downloaded and made executables. You can make use of them using a cron:

```bash
crontab -e

0 7 * * * /home/$CURRENT_USER/Documents/slideshow/brightness_day.sh
0 22 * * * /home/$CURRENT_USER/Documents/slideshow/brightness_night.sh
```