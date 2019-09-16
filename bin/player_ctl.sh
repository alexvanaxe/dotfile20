#!/bin/sh

chosen=$(printf "pause ⏸\\nplay ▶\\nforward ▶▶\\nback ◀◀" | dmenu "$@" -i -p "$(playerctl metadata artist) - $(playerctl metadata title)")

case "$chosen" in
	"pause ⏸") playerctl pause;;
	"play ▶") playerctl play;;
	"forward ▶▶") playerctl next;;
	"back ◀◀") playerctl previous;;
esac
