#!/bin/sh

PID=$(pgrep -a polybar | grep "default" | awk '{print $1}')

if [ ! -z $PID ]; then
    killall polybar
    bspc config top_padding 0
else
    polybar default &
    sleep 1
    bspc config top_padding 16
fi
