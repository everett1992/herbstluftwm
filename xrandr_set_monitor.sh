#!/bin/bash
N=0
for screen in `xrandr -q | egrep '[0-9]+x[0-9]+\+[0-9]+\+[0-9]+' -o`
do
  screens[$N]=$screen
  let "N= $N + 1"
done 

M=0
for i in `herbstclient list_monitors| egrep '^[0-9]' -o`
do
  hbscreens[$M]=$i
  let "M= $M + 1"
done

Y=0
while true
do
  if [ -n "${screens[$Y]}" ] && [ -n "${hbscreens[$Y]}" ] ; then
    echo herbstclient move_monitor ${hbscreens[$Y]} ${screens[$Y]}
    herbstclient move_monitor ${hbscreens[$Y]} ${screens[$Y]}
  elif [ -n "${screens[$Y]}" ] ; then
    echo herbstclient add_monitor ${screens[$Y]}
    herbstclient add_monitor ${screens[$Y]}
  elif [ -n "${hbscreens[$Y]}" ] ; then
    echo herbstclient remove_monitor ${hbscreens[$Y]}
    herbstclient remove_monitor ${hbscreens[$Y]}
  else
    exit
  fi

  let "Y= $Y + 1"
done
