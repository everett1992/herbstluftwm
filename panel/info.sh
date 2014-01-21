#!/bin/bash

dzen_fn="-*-terminus-medium-*-*-*-14-*-*-*-*-*-*-*"
dzen_fg="$COLOR11"
dzen_bg="$COLOR0"

conky -c "$panelfolder/conkyrc" | dzen2 -fn "$dzen_fn" -h 16 -fg "$dzen_fg" -bg "$dzen_bg" -e 'button3='
