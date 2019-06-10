#!/usr/bin/env bash

pid=$(pidof gnome-pomodoro)
if [ -z "$pid" ]
then
	gnome-pomodoro &
fi

source $HOME/.pyenv/versions/i3stufs/bin/activate
chosen=$(printf "⏸\\n▶\\n🕑\\n⏹\\n▶▶\\n↻" | dmenu $* -i -p "$($HOME/.config/i3/scripts/pomodoro-client.py status) ")


case "$chosen" in
	"⏸") python $HOME/.config/i3/scripts/pomodoro-client.py pause;;
	"🕑") python $HOME/.config/i3/scripts/pomodoro-client.py start;;
	"▶") python $HOME/.config/i3/scripts/pomodoro-client.py resume;;
	"⏹") python $HOME/.config/i3/scripts/pomodoro-client.py stop;;
	"▶▶") python $HOME/.config/i3/scripts/pomodoro-client.py skip;;
	"↻") python $HOME/.config/i3/scripts/pomodoro-client.py reset;;
esac
