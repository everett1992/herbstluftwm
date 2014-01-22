#!/bin/bash

source ~/.colors

dzen_fn="-*-terminus-medium-*-*-*-14-*-*-*-*-*-*-*"
dzen_fg="$COLOR11"
dzen_bg="$COLOR0"

[[ $0 == /* ]] && script="$0" || script="${PWD}/${0#./}"
panelfolder=${script%/*}
trap 'herbstclient emit_hook quit_panel' TERM
herbstclient emit_hook quit_panel

killall stalonetray
read -a mon <<< "$(hc list_monitors | head -n1 | sed 's/\([0-9]\)\+: \([0-9]\+\)x\([0-9]\+\)+\([0-9]\+\)+\([0-9]\+\).*/\1 \2 \3 \4 \5/')"
#                                            ^            ^           ^           ^           ^ 
#                                            0: mon_num   1: width    2: height   3: x_offset 4: y_offset

herbstclient pad ${mon[0]} 16

# Start conky first so it is in the back most panel
conky -c "$panelfolder/conkyrc" | dzen2 -fn "$dzen_fn" -x "${mon[3]}" -y "${mon[4]}" -w "${mon[1]}" -h 16 -fg "$dzen_fg" -bg "$dzen_bg" -e 'button3=' &
pids+=($!)

$panelfolder/tray.sh ${mon[@]} &
pids+=($!)

$panelfolder/tags.sh ${mon[@]} &
pids+=($!)
echo ${pids[@]}

herbstclient --wait '^(quit_panel|reload).*'
kill -TERM "${pids[@]}" >/dev/null 2>&1
exit 0
