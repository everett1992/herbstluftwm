#!/bin/bash
# bar.sh

###                                               ###
## Adds a workspace bar and clock to every monitor ##
## Make sure to run after xrandr_set_monitor.sh    ##
###                                               ###

font="iceberg"
dark_bg="#121212"
light_bg="#2c2c2c"
light_light="#5f5f5f"
green="#56e202"

dir=~/.config/herbstluftwm/

function hc() {
    herbstclient "$@"
}

killall stalonetray i3status dzen2

for i in `hc list_monitors| egrep '^[0-9]' -o`
do
  geometry=( $(hc monitor_rect $i ) )
  x=${geometry[0]}
  y=${geometry[1]}
  let "width= ${geometry[2]} - 130"
  height=${geometry[3]}
  hc pad $i 16
  sh $dir/ws_bar $i | dzen2 -bg $light_bg  -ta l -w $width -h 16 -x $x -y $y &
  let "x= $x + $width"
  i3status -c $dir/i3status.conf | dzen2 -bg $light_bg  -ta r -h 16 -x $x -y $y -fn $font &
  if [ "$i" -eq "0" ] ; then
    let "x=$x - 20"
    sleep .1
    stalonetray -i 16 -bg $light_bg --geometry 1x1+$x+$y --grow-gravity E &
  fi
done
