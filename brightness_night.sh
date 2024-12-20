#!/usr/bin/env bash

# Set desired brightness value
NIGHT_BRIGHTNESS=10

# Adjust if needed for multiple displays.
ddcutil setvcp 10 ${NIGHT_BRIGHTNESS}