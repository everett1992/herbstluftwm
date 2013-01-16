#!/bin/bash

tag="${1:-sidebar}"
main_mon="${2:-0}"
monitor=sidebar

hc() {
  herbstclient "$@";
}


show() {
  mrect=( $(hc monitor_rect -p ${cur_mon} ) )
  #  mrect
  #      0: x padding
  #      1: y padding
  #      2: width
  #      3: heigth
  termwidth=$((${mrect[2]}*3/10))
  termheight=${mrect[3]}

  # rect
  #   0: width
  #   1: height
  #   2: x padding
  #   3: y padding

  side_rect=(
      $termwidth
      $termheight
      $((${mrect[2]}-$termwidth))
      ${mrect[1]}
  )
  main_rect=(
      $((${mrect[2]}-$termwidth))
      ${mrect[3]}
      ${mrect[0]}
      ${mrect[1]}
  )
  hc add "$tag"



  echo $(printf "%dx%d%+d%+d" "${side_rect[@]}")
  if hc add_monitor $(printf "%dx%d%+d%+d" "${side_rect[@]}") \
                      "$tag" $monitor 2> /dev/null ; then
    local geom=$(printf "%dx%d%+d%+d" "${main_rect[@]}")
    hc move_monitor "$main_mon" $geom
  fi
  local geom=$(printf "%dx%d%+d%+d" "${side_rect[@]}")
  hc move_monitor "$monitor" $geom

}

hide() {
  mrect=( $(hc monitor_rect -p ${cur_mon} ) )
  srect=( $(hc monitor_rect -p ${monitor} ) )
  termwidth=${srect[2]}
  termheight=${srect[3]}
  main_rect=(
      $((${mrect[2]}+$termwidth))
      ${mrect[3]}
      ${mrect[0]}
      ${mrect[1]}
  )
  local geom=$(printf "%dx%d%+d%+d" "${main_rect[@]}")
  hc move_monitor "$main_mon" $geom
  hc remove_monitor "$monitor"
}
hide
