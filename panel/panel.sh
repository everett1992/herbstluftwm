#!/bin/bash

source ~/.colors

[[ $0 == /* ]] && script="$0" || script="${PWD}/${0#./}"
export panelfolder=${script%/*}
trap 'herbstclient emit_hook quit_panel' TERM
herbstclient emit_hook quit_panel

#killall stalonetray

read -a mon <<< "$(hc list_monitors | head -n1 | sed 's/\([0-9]\)\+: \([0-9]\+\)x\([0-9]\+\)+\([0-9]\+\)+\([0-9]\+\).*/\1 \2 \3 \4 \5/')"
#                                            ^            ^           ^           ^           ^ 
#                                            0: mon_num   1: width    2: height   3: x_offset 4: y_offset

herbstclient pad ${mon[0]} 16

# Start conky first so it is in the background
$panelfolder/info.sh ${mon[@]} &
pids+=($!)

sleep 0.1 # Delay the start of tray and tags


$panelfolder/tray.sh ${mon[@]} &
pids+=($!)

$panelfolder/tags.sh ${mon[@]} &
pids+=($!)

echo ${pids[@]}

herbstclient --wait '^(quit_panel|reload).*'
kill -TERM "${pids[@]}" >/dev/null 2>&1
exit 0
