#!/bin/bash
# bar.sh

###                                               ###
## Adds a workspace bar and clock to every monitor ##
## Make sure to run after xrandr_set_monitor.sh    ##
###                                               ###

font="iceland-11"
light_bg="$COLOR0"
green="$COLOR2"

dir=~/.config/herbstluftwm/

function hc() {
    herbstclient "$@"
}

killall stalonetray dzen2

for i in `hc list_monitors| egrep '^[0-9]' -o`
do
  geometry=( $(hc monitor_rect $i ) )
  x=${geometry[0]}
  y=${geometry[1]}
  let "width= ${geometry[2]} - 810"
  height=${geometry[3]}
  hc pad $i 16
  sh $dir/ws_bar $i | dzen2 -bg $light_bg  -ta l -w $width -h 16 -x $x -y $y -fn $font &
  let "x= $x + $width"
  conky -c $dir/conkyrc | dzen2 -bg $light_bg -w 810 -ta l -h 16 -x $x -y $y -fn $font &
  if [ "$i" -eq "0" ] ; then
    let "x=$x - 20"
    sleep .1
    stalonetray -i 16 -bg $light_bg --geometry 1x1+$x+$y --max-geometry 10x1 --grow-gravity NE --dockapp-mode simple --window-type dock &
  fi
done
