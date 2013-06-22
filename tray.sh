#!/bin/bash

source ~/.colors
killall trayer
COLOR0=`echo $COLOR0 | sed 's/#/0x/'`
trayer --edge top --align right --widthtype request --heighttype pixel \
       --height 16 --expand true --tint $COLOR0 --transparent true \
       --alpha 0
