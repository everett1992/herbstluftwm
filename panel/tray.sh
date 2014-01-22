#!/bin/bash

source ~/.colors

mon_num=${1:-0}
width=${2:-0}
height=${3:-0}
x=${4:-0}
y=${5:-0}

let x_offset=$x+$width-16
stalonetray -bg $COLOR0 --geometry 1x1+$x_offset+$y --grow-gravity NE \
  --icon-size 16 --icon-gravity W --kludges force_icons_size
