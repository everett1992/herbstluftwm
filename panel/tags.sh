#!/bin/bash

source ~/.colors

dzen_fn="-*-terminus-medium-*-*-*-14-*-*-*-*-*-*-*"
dzen_fg="$COLOR11"
dzen_bg="$COLOR0"
normal_fg="$COLOR11"
normal_bg=""

this_fg="#000000"
this_bg="$COLOR2"

other_bg="$COLOR3"

urgent_fg=
urgent_bg="#df8787"
used_fg="#ffffff"
used_bg=

mon=$1
x=$4
y=$5

echo $mon

herbstclient --idle 2>/dev/null | {
    tags=( $(herbstclient tag_status 0) )
    while true; do
        for tag in "${tags[@]}" ; do
            case ${tag:0:1} in
                # This monitor
                '#') cstart="^fg($this_fg)^bg($this_bg)" ;;

                # Other monitor
                '-') cstart="^fg($this_fg)^bg($other_bg)" ;;

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
          -w 302 -fg "$dzen_fg" -bg "$dzen_bg" -e 'button3=' \
          -x "$x" -y "$y"
