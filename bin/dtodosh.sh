#!/bin/sh

chosen=$(todo.sh -p | head -n -2 | dmenu "$@" -l 10 -i -p "add: ")

number=$(echo "$chosen" | awk '{print $1}')

re='^[0-9]+$'

if [[ $number =~ $re ]] ; then
    chosen_sel=$(echo -e ""| dmenu "$@" -p "Leave blank to done or A-Z to pri: ($chosen)")
    if [[ -z "$chosen_sel" ]] ; then
        $(todo.sh do $number > /dev/null 2>&1)
        notify-send -u normal "Task done" "$chosen"
    else
        $(todo.sh pri $number $chosen_sel > /dev/null 2>&1)
        notify-send -u normal "Task priorized" "$chosen"
    fi
else
    if [[ ! -z "$chosen" ]]; then
        $(todo.sh add $chosen > /dev/null 2>&1)
        notify-send -u normal "Task added" "$chosen"
    fi
fi
