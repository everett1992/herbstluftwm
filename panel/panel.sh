#!/bin/bash

source ~/.colors

[[ $0 == /* ]] && script="$0" || script="${PWD}/${0#./}"
export panelfolder=${script%/*}
trap 'herbstclient emit_hook quit_panel' TERM
herbstclient pad 0 16
herbstclient emit_hook quit_panel

# Start conky first so it is in the background
"$panelfolder/info.sh" &
pids+=($!)

sleep 0.1 # Delay the start of tray and tags

"$panelfolder/tray.sh" &
pids+=($!)

"$panelfolder/tags.sh" &
pids+=($!)


herbstclient --wait '^(quit_panel|reload).*'
kill -TERM "${pids[@]}" >/dev/null 2>&1
exit 0
