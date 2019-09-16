#!/bin/sh

if [[ $1 == "play" ]]; then
    mv $HOME/Documents/output.mkv $HOME/Documents/output_bkp.mkv
    echo "" > $HOME/.dwm/recording
    refbar
    ffmpeg -video_size 1366x768 -thread_queue_size 512 -framerate 25 -f x11grab -i :0 -f pulse -thread_queue_size 512 -itsoffset 0.320 -ac 2 -i default ~/Documents/output.mkv
fi

if [[ $1 == "stop" ]]; then
    killall ffmpeg
    rm $HOME/.dwm/recording
    refbar
fi
