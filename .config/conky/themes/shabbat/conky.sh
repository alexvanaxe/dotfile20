#!/bin/sh

pid=$(pidof conky)
if [ -z "$pid" ]
then
        conky -d --config ~/.config/conky/fortune.conf
        conky -d --config ~/.config/conky/cpu.conf
        conky -d --config ~/.config/conky/clock.conf
    else
        killall conky

fi
