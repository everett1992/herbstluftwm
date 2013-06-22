#!/bin/bash

source ~/.colors

dzen_fn="-*-terminus-medium-*-*-*-14-*-*-*-*-*-*-*"
dzen_fg="$COLOR11"
dzen_bg="$COLOR0"
normal_fg="$COLOR11"
normal_bg=""
viewed_fg="$COLOR11"
viewed_bg="$COLOR2"
urgent_fg=
urgent_bg="#df8787"
used_fg="#ffffff"
used_bg=

herbstclient --idle 2>/dev/null | {
    tags=( $(herbstclient tag_status) )
    while true; do
        for tag in "${tags[@]}" ; do
            case ${tag:0:1} in
                '#') cstart="^fg($viewed_fg)^bg($viewed_bg)" ;;
                '+') cstart="^fg($viewed_fg)^bg($viewed_bg)" ;;
                ':') cstart="^fg($used_fg)^bg($used_bg)"     ;;
                '!') cstart="^fg($urgent_fg)^bg($urgent_bg)" ;;
                *)   cstart=''                               ;;
            esac
            dzenstring="${cstart}^ca(1,herbstclient use ${tag:1}) ${tag:1} "
            dzenstring+="^ca()^fg()^bg()"
            echo -n "$dzenstring"
        done
        echo 
        read hook || exit
        case "$hook" in
            tag*) tags=( $(herbstclient tag_status) ) ;;
            quit_panel*) exit ;;
        esac
    done
} | dzen2 -h 16 -fn "$dzen_fn" -ta l -sa l \
          -w 162 -fg "$dzen_fg" -bg "$dzen_bg" -e 'button3='
