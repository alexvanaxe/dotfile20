#!/bin/sh


players=($(playerctl -a metadata 2> /dev/null | awk '{print $1}' | uniq))

players_len=${#players[@]}

if [ $players_len -gt 1 ]; then
    chosen_p=$(printf "%s\n ${players[@]}" | dmenu "$@" -i -p "Select the player:")

    if [ ! -z $chosen_p ]; then
        chosen=$(printf "pause ⏸\\nplay ▶\\nforward ▶▶\\nback ◀◀" | dmenu "$@" -i -p "$(playerctl -p $chosen_p metadata artist) - $(playerctl -p $chosen_p metadata title)")

        case "$chosen" in
            "pause ⏸") playerctl -p $chosen_p pause;;
            "play ▶") playerctl -p $chosen_p play;;
            "forward ▶▶") playerctl -p $chosen_p next;;
            "back ◀◀") playerctl -p $chosen_p previous;;
        esac
    fi


else
    chosen=$(printf "pause ⏸\\nplay ▶\\nforward ▶▶\\nback ◀◀" | dmenu "$@" -i -p "$(playerctl metadata artist) - $(playerctl metadata title)")

    case "$chosen" in
        "pause ⏸") playerctl pause;;
        "play ▶") playerctl play;;
        "forward ▶▶") playerctl next;;
        "back ◀◀") playerctl previous;;
    esac
fi

