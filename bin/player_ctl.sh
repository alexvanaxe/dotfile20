#!/bin/bash

TMP_LOCATION=$HOME/.config/tmp
LAST_LOCATION_PLAYED="${TMP_LOCATION}/last_location_played"
PLAY_BKP=$HOME/.config/tmp/play_bkp
INDICATOR_CAST_FILE=$HOME/.config/indicators/casting.ind

get_titles(){
    for player in $(playerctl -l | awk '!seen[$1] {print $1} {++seen[$1]}'); do
        teste="$(playerctl -p "$player" metadata title 2> /dev/null | awk -v player=$player '{print player,$0}' OFS=" - ")"
        if [ ! -z $teste ]; then
            printf "%s\n" "$teste"
        fi
    done

    #if [[ -f "${INDICATOR_CAST_FILE}" ]]; then
        #printf "%s\n" "casting-$(cast.sh -i)"
    #fi

    if [[ -f "${INDICATOR_CAST_FILE}" ]]; then
        printf "%s\n" "chromecast"
    fi
}

IFS=$'\n'

go_to_position() {
    time=$1
   
    goto=$(echo "${time}" | bc)
    playerctl position "${goto}"

    if [ "$chosen_p" = "chromecast" ]; then
        if [[ -f "${INDICATOR_CAST_FILE}" ]]; then
            if [ "${goto}" = "0" ]; then
                cast.sh -rg "33"
            else
                cast.sh -g "${goto}"
            fi
        fi
    fi
}

save() {
    player=$1
    yt_link=$(playerctl -p "${player}" metadata xesam:url)
    position=$(playerctl -p ${player} position)

    video_rash=$(playerctl -p ${player} metadata xesam:url | grep -o "v.*" | awk 'BEGIN { FS = "=" }{print $2}')
    
    if [ ! -z ${video_rash} ]; then
        echo "https://youtu.be/${video_rash}?t=${position}" > ${LAST_LOCATION_PLAYED}
    else
        yt_link=$(playerctl -p "${player}" metadata xesam:url)
        echo "${yt_link}" > ${LAST_LOCATION_PLAYED} 
    fi

    if [ "$chosen_p" = "chromecast" ]; then
        if [[ -f "${INDICATOR_CAST_FILE}" ]]; then
            cast.sh -t
        fi
    fi

    notify-send -u normal  "Saved" "Location saved"
}

invert(){
    player=$1
    asaudio=$2

    yt_link=$(playerctl -p "${player}" metadata xesam:url)
    position=$(playerctl -p ${player} position)
    
    video_rash=$(playerctl -p ${player} metadata xesam:url | grep -Eo '[a-zA-Z0-9_-]{11}')
    
    if [ ! -z "${video_rash}" ]; then
        if [ "${asaudio}" = "1" ]; then
            playerctl -p $player stop;
            play_radio.sh -sp "https://youtu.be/${video_rash}?t=${position}"&
        else
            playerctl -p $player stop;
            play_radio.sh -p "https://youtu.be/${video_rash}?t=${position}"&
        fi
    else
        yt_link=$(playerctl -p "${player}" metadata xesam:url)

        if [ "${asaudio}" = "1" ]; then
            playerctl -p $player stop;
            play_radio.sh -sp "${yt_link}"&
        else
            playerctl -p $player stop;
            play_radio.sh -p "${yt_link}"&
        fi
    fi
}

cast(){
    player="$1"
    local media_url="$(playerctl -p "${player}" metadata xesam:url)"
    local position=$(playerctl -p ${player} position)
    cast.sh "${media_url}"
    status=""

    while [ -z "$status" ]; do
        local yt_info=$(cast.sh -i)
        local status=$(awk '{printf $4}' FS="|" <<< "${yt_info}")
    done
    cast.sh -g "${position}"
    playerctl -p $player stop;
}

uncast(){
    local yt_info=$(cast.sh -i)
    local video_id=$(awk '{printf $3}' FS="|" <<< "${yt_info}")
    local video_rash=$(awk '{printf $1}' FS="|" <<< "${yt_info}")

    if [ "${video_id}" = "x-youtube/video" ]; then
        local video_position=$(awk '{printf $2}' FS="|" <<< "${yt_info}")
        
        play_radio.sh -p "https://youtu.be/${video_rash}?t=${video_position}"&
        cast.sh -S
    else
        play_radio.sh -p "${video_rash}"&
        cast.sh -S
    fi
}

stop_play(){
    playerctl -p $chosen_p stop

    # How can only be one casting file, for now will be this way
    if [ "$chosen_p" = "chromecast" ]; then
        if [[ -f "${INDICATOR_CAST_FILE}" ]]; then
            cast.sh -S
        fi
    fi
}

play_pause(){
    playerctl -p $chosen_p play-pause

    if [ "$chosen_p" = "chromecast" ]; then
        if [[ -f "${INDICATOR_CAST_FILE}" ]]; then
            cast.sh -p
        fi
    fi
}

forward(){
    playerctl -p $chosen_p next

    if [ "$chosen_p" = "chromecast" ]; then
        if [[ -f "${INDICATOR_CAST_FILE}" ]]; then
            cast.sh -n
        fi
    fi
}

adjust_volume(){
  player=$1

  volume=$(printf "0\n0.5\n1" | dmenu -i -p "Volume (0.0 - 1.0)" -y 16 -bw 2 -z 350)

  if [ -z $player ]; then
      playerctl volume $volume 
  else
      playerctl -p $player volume $volume 
  fi
}

chosen_p=$(get_titles | dmenu -i -n -l 20 -p "Select the player:" -y 16 -z 950 -bw 2)
chosen_p=$(echo $chosen_p | awk '{print $1}') 

get_prompt() {
    local chosen_p="$1"

    local prompt=""
    if [ "chromecast" = "${chosen_p}" ]; then
        #local yt_info=$(cast.sh -i)
        #local status=$(awk '{printf $4}' FS="|" <<< "${yt_info}")
        #local playtime=$(awk '{printf $2}' FS="|" <<< "${yt_info}")
        
        #playtime=$(echo "$playtime/60" | bc)
        #prompt="${playtime}Min - ${status}"


        printf "Chrome: Playing something... I think.. =/ %s" "${prompt}"
    else
        local position="$(echo "$(playerctl -p ${chosen_p} position) / 60" | bc)"
        if [ ! -z "${position}" ]; then
            prompt="${position} Min"
        fi
        local artist="$(playerctl -p $chosen_p metadata artist)"
        
        if [ ! -z "${artist}" ]; then
            prompt="${prompt} - ${artist}"
        fi
        local title=$(playerctl -p $chosen_p metadata title)
        if [ ! -z "${title}" ]; then
            prompt="${prompt} - ${title:0:30}"
        fi

        printf "%s" "${prompt}"
    fi

   #${position}$(playerctl -p $chosen_p metadata artist) - ${title:0:30} 
}


if [ ! -z $chosen_p ]; then
    #position=$(echo "$(playerctl -p ${chosen_p} position) / 60" | bc)
    prompt=$(get_prompt "${chosen_p}")
    if [ "$chosen_p" = "chromecast" ]; then
        chosen=$(printf "play ▶⏸\nforward ▶▶\\nclear \\nstop \\nuncastﲈ" | dmenu -i -p "${prompt}" -y 16 -z 950 -bw 2)
    else
        chosen=$(printf "play ▶⏸\\nforward ▶▶\\nback ◀◀\\nstop \\nvolume \\ncast " | dmenu -i -p "${prompt}" -y 16 -z 950 -bw 2)
    fi

    case "$chosen" in
        "play ▶⏸") play_pause;;
        "forward ▶▶") forward;;
        "back ◀◀") playerctl -p $chosen_p previous;;
        "stop ") stop_play;;
        "volume ") adjust_volume $chosen_p;;
        "save") save $chosen_p;;
        "asvideo") invert "$chosen_p" "0";;
        "asaudio") invert "$chosen_p" "1";;
        "cast ") cast "$chosen_p";;
        "clear ") cast.sh -c;;
        "uncastﲈ") uncast;;
        *) go_to_position ${chosen};;
    esac
fi
