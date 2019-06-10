#!/usr/bin/env bash

pid=$(pidof spotify)
if [ -z "$pid" ]
then
	spotify &
fi


source $HOME/.pyenv/versions/i3stufs/bin/activate
chosen=$(printf "pause ⏸\\nplay ▶\\nforward ▶▶\\nback ◀◀" | dmenu $* -i -p "$(spotifycli --playbackstatus) $(spotifycli --statusshort)")

case "$chosen" in
	"pause ⏸") spotifycli --pause;;
	"play ▶") spotifycli --play;;
	"forward ▶▶") spotifycli --next;;
	"back ◀◀") spotifycli --prev;;
esac
