#!/usr/bin/env bash

# Set desired brightness value
# 38 is the maximum value for my display
DAY_BRIGHTNESS=38

# If you have multiple displays, specify which one:
# e.g., ddcutil --display 1 setvcp 10 ${DAY_BRIGHTNESS}
# If you have only one display, you can omit the --display argument.

ddcutil setvcp 10 ${DAY_BRIGHTNESS}
