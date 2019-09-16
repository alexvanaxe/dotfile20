#!/bin/sh

chosen=$(printf "Turnoff monitor\\nSleep\\nRestart\\nPoweroff\\nHibernate" | dmenu "$@" -i -p "Power:")

poweroff() { \
	confirm="$(printf "No\\nYes" | dmenu -i -p "$1" -nb darkred -sb red -sf white -nf gray )"
	if [ "Yes" == "$confirm" ]
	then
		systemctl poweroff
	fi
}

chibernate() { \
	confirm="$(printf "No\\nYes" | dmenu -i -p "$1" -nb darkred -sb red -sf white -nf gray )"
	if [ "Yes" == "$confirm" ]
	then
		$HOME/.config/i3/scripts/lock.sh
		systemctl hibernate
	fi
}

monitor() { \
	sleep 1 && xset dpms force off
}

csuspend() { \
	$HOME/.config/i3/scripts/lock.sh
	systemctl suspend -i
}

crestart() { \
	confirm="$(printf "No\\nYes" | dmenu -i -p "$1" -nb darkred -sb red -sf white -nf gray )"
	if [ "Yes" == "$confirm" ]
	then
		systemctl reboot
	fi
}

case "$chosen" in
	"Turnoff monitor") monitor ;;
	"Sleep") csuspend ;;
	"Restart") crestart ;;
	"Poweroff") poweroff ;;
	"Hibernate") chibernate ;;
esac
