#! /bin/bash

# Exit on error inside any functions or subshells.
#set -o errtrace
# Do not allow use of undefined vars. Use ${VAR:-} to use an undefined VAR
set -o nounset
# Catch the error in case mysqldump fails (but gzip succeeds) in `mysqldump |gzip`
#set -o pipefail

CHOSEN=$(printf "Day Original\\nNight Original\\nWasteland\\nElegant\\nElegant2\\nElegantAmz\\nStock\\nRock\\nWar\\nMinimalist\\nNature\\nAmazon\\nFantasy\\nModern\\nComputer\\nFuturistic\\nWestern\\n80s\\nNeon\\nCyberpunk\\nPixel\\nOld Terminal\\nHacking\\nIntel\\nJet\\nProgramming\\nRetro\\nSoft\\nBook\\nCursive\\nCartoon\\nCute\\nClear\\nSpace\\nNoir\\nRussian\\nGothic\\nSteamPunk\nNM-Comix zone\nNM-80s ScyFi\nNM-Japan\nNM-Watedland\nTerminator\nNM-Space\nNM-Celtic\nNM-Soft\\nNM-Softer" | dmenu -i    -l 20 -p "Change the font: ")

SPACE_SIZE=30

if [ -z "${CHOSEN}" ]; then
    exit
fi

NOT_MONO=$(echo $CHOSEN | cut -d '-' -f 1)
    

# Source the theme
. ${HOME}/.config/bspwm/themes/bsp.cfg

font() {
    font_name=$1
    style=$2

    size1=$3
    size2=$4
    size3=$5
    space=$6
    eww=""

    SIZE=$(printf "" | dmenu -i -p "Choose the size (bar(${size1}) dmenu(${size2}) conky(${size3}) vspace(${space}))")

    if [ ! -z "${SIZE}" ]; then
        size1="$(echo ${SIZE} | cut -d ' ' -f 1)"
        size2="$(echo ${SIZE} | cut -d ' ' -f 2)"
        size3="$(echo ${SIZE} | cut -d ' ' -f 3)"
        space="$(echo ${SIZE} | cut -d ' ' -f 4)"
        eww="$(echo ${SIZE} | cut -d ' ' -f 5)"
    fi

    #Change the polybar
    if [ "${NOT_MONO}" != "NM" ]; then 
        height="$((size1 + ${SPACE_SIZE}))"
        sed -i "s/font-1.*/font-1 = ${font_name}:style=${style}:pixelsize=${size1};${space}/" ${HOME}/.config/polybar/config
        sed -i "s/height.*/height = ${height}/" ${HOME}/.config/polybar/config


        sed -Ei "s/(font-0.*=)[[:digit:]]{1,2}/\1${size1}/"  ${HOME}/.config/polybar/config
        sed -Ei "s/(font-2.*=)[[:digit:]]{1,2}/\1${size1}/"  ${HOME}/.config/polybar/config
        sed -Ei "s/(font-3.*=)[[:digit:]]{1,2}/\1${size1}/"  ${HOME}/.config/polybar/config
        sed -Ei "s/(font-4.*=)[[:digit:]]{1,2}/\1${height}/"  ${HOME}/.config/polybar/config
        #sed -i "s/font-1.*/font-1 = ${font_name}:style=${style}:pixelsize=${size1}/" ${HOME}/.config/polybar/config_simple
    fi

    sed -i "s/^\$general-font: .*;/\$general-font: \"${font_name}\";/" ${HOME}/.config/eww/eww.scss
    if [ ! -z "${eww}" ]; then
        sed -i "s/^\$general-font-size: .*;/\$general-font-size: ${eww};/" ${HOME}/.config/eww/eww.scss
    fi

    #Change the dmenu font
    sed -i "s/DMENU_FN.*/DMENU_FN=\"${font_name}:style=${style}:size=${size2}\"/" ${HOME}/.config/bspwm/themes/bsp.cfg

    #Change the dunst font
    sed -i "s/font =.*/font = ${font_name},${style} ${size1}/" ${HOME}/.config/dunst/dunstrc

    #Change the twmn font
    height="$((size1 + ${SPACE_SIZE}))"
    sed -i "s/font=.*/font=${font_name}/" ${HOME}/.config/twmn/twmn.conf
    sed -i "s/font_size=.*/font_size=$((size1 + 10))/" ${HOME}/.config/twmn/twmn.conf
    sed -i "s/height=.*/height=$((size1 + height))/" ${HOME}/.config/twmn/twmn.conf

    # Update the qutebrowser font size
    sed -i "s/c.fonts.default_size=.*/c.fonts.default_size=\"$((size1 + 5))px\"/" ${HOME}/.config/qutebrowser/config.py
    #Change the tint font
    if [ "${NOT_MONO}" != "NM" ]; then
    for file in ${HOME}/.config/tint2/*
    do
        sed -i "s/font = Pomodoro.*/zont = Pomodoro 10/" $file
        sed -i "s/font =.*/font = ${font_name} ${style} ${size1}/" $file
        sed -i "s/zont = Pomodoro.*/font = Pomodoro 10/" $file
    done
    fi

    #Change the lock screen font
    sed -i "s/FONT=.*/FONT=\"${font_name}\":pixelsize=$(($size3+7))/" ${HOME}/bin/imports/lock.sh

    #Change the conk font
    for file in ${HOME}/.config/conky/*.conf; do
        if [ "${NOT_MONO}" != "NM" ]; then
            sed -i "s/font=.*/font='${font_name}:${style}:size=${size3}',/" ${file}
        fi
        sed -i "s/TITLEFONT/${font_name}/g" ${file}
    done

    sed -i "s/font_size =.*/font_size = $((size1 - 1)),/" ${HOME}/.config/wezterm/extra.lua

    update=$(printf "Yes\nNo" | dmenu -i    -p "Update terminal font? (ESC go to default)")

    if [ "${update}" = "Yes" ]; then
        sed -i "s/family:.*/family: ${font_name}/" ${HOME}/.config/alacritty/alacritty.yml
        sed -i "s/custom_term_font =.*/custom_term_font = '${font_name}',/" ${HOME}/.config/wezterm/extra.lua
        sed -i "s/#size:.*/size: ${size3}/" ${HOME}/.config/alacritty/alacritty.yml
    fi
    if [ -z "${update}" ]; then
        cp ${HOME}/.config/alacritty/alacritty.${theme_name} ${HOME}/.config/alacritty/alacritty.yml 
    fi

    sed -i "s/font-default:.*/font-default: \"${font_name} ${style} ${size1}\";/" ${HOME}/.config/rofi/bspwm.rasi

    killall -qw dunst
    killall -qw twmnd
    if [ "${theme_name}" = "night" ]; then
        twmnd&
    else
        dunst&
    fi
    toggle_bars.sh --restart

    notify-send -u normal "${CHOSEN}" "Enjoy the ${font_name}"
}

case $CHOSEN in
    "Day Original") font "Erica Type" Bold 13 12 12 0;;
    "Night Original") font "Iceland" Regular 13 13 14 0;;
    "Old Terminal") font "VT323" Regular 12 12 19 1;;
    "Minimalist") font "Nouveau IBM Stretch" Bold 12 12 15 2;;
    "Clear") font "TeX Gyre Cursor" Bold 11 11 13 1;;
    "Nature") font "CQ Mono" Bold 10 10 12 1;;
    "Modern")  font "Audimat Mono" Regular 10 10 12 1;;
    "Russian") font "IosevkaTerm Nerd Font Mono" "Bold" 10 10 13 1;;
    "Futuristic") font "Larabiefont Compressed" Bold 10 10 13 2;;
    "Elegant") font "Unica One" Regular 10 10 13 1;;
    "Elegant2") font "NovaMono" Normal 9 9 13 2;;
    "ElegantAmz") font "Amazon Ember" Medium 11 11 14 1;;
    "Amazon") font "Bookerly" Regular 11 11 14 2;;
    "Fantasy") font "CaskaydiaCove Nerd Font Mono" Normal 9 9 13 2;;
    "Neon") font "Segment14" Regular 9 9 10 1;;
    "Rock") font "Targa MS" Regular 11 11 12 2;;
    "Jet") font "JetBrains Mono" Regular 10 10 12 2;;
    "Hacking") font "Hack" Regular 10 10 12 2;;
    "War") font "American Stencil" Regular 9 9 12 1;;
    "Programming") font "Roboto Mono" Bold 8 8 12 1;;
    "Retro") font "hermit" Bold 8 8 12 1;;
    "Cursive") font "Z003" "Medium Italic" 13 12 15 2;;
    "Soft") font "mononoki" Regular 9 9 12 2;;
    "80s") font "Press Start 2P" Regular 7 6 9 2;;
    "Cyberpunk") font "Braciola MS" "Regular Rg" 9 9 12 1;;
    "Pixel") font "Repetition Scrolling" Regular 9 10 13 1;;
    "Intel") font "IntelOne Mono" Regular 11 11 13 1;;
    "Western") font "Graduate" Regular 9 9 11 1;;
    "Book") font "Kingthings Trypewriter 2" Regular 9 9 11 1;;
    "Stock") font "Share Tech Mono" Bold 11 11 13 1;;
    "Wasteland") font "Beccaria" Bold 11 11 13 1;;
    "Cartoon") font "Pointfree" Bold 8 8 10 1;;
    "Cute") font "Overpass Mono" Bold 9 9 12 0;;
    "Space") font "Unispace" Bold 8 8 10 2;;
    "Noir") font "Syne Mono" Regular 10 10 11 1;;
    "Computer") font "Terminus" Bold 10 10 13 2;;
    "Gothic") font "NanumGothicCoding" Bold 10 10 12 1;;
    "SteamPunk") font "Roboto Condensed" Semibold 10 10 11;;
    "Terminator") font "Digital\-7 Mono" Bold 9 9 12 0;;
    "NM-Comix zone") font "Bangers" Bold 11 11 12 0;;
    "NM-80s ScyFi") font "Audiowide" Bold 9 9 12 0;;
    "NM-Japan") font "Shojumaru" Bold 9 9 11 0;;
    "NM-Watedland") font "Special Elite" Bold 11 11 12 0;;
    "NM-Celtic") font "A.D. MONO" Bold 12 12 12 0;;
    "NM-Space") font "Orbitron" Bold 9 9 10 0;;
    "NM-Soft") font "Texturina" Bold 10 10 10 0;;
    "NM-Softer") font "Lerton" Regular 10 10 13 2;;
    "teste") font "Amazon Ember" Medium 10 10 13 1;;
    *) font "${CHOSEN}" Bold 9 10 11 0;;
esac
