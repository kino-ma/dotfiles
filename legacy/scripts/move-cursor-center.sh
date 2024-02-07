#!/usr/bin/env bash

# First, get active window ID.
# Second, move mouse to the center of the active window.
#   --window %1: Specify a window to move relative to. %1 means one pushed onto the WINDOW STACK most recently, i.e., the active window
#   --polar: Use polar coordinates. The origin defaults to the center of the current screen.
xdotool getactivewindow -- mousemove --window %1 --polar 0 0
