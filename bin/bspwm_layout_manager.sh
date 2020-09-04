#! /bin/dash

LAYOUT=$1

if [ -z ${LAYOUT} ]
then
    LAYOUT=$(printf "tiled\nmonocle\neven\ntall\nwide\npseudo\nrpseudo\nremove" | dmenu -p "What layout you want?")
fi

LAYOUTS_DIR=$HOME/.config/tmp/layouts

set_tiled() {
    bsp-layout remove
    bspc desktop --layout tiled
    desktop=$(bspc query --desktops -d)
    echo "🧱" > ${LAYOUTS_DIR}/${desktop}
}

set_monocle() {
    bsp-layout remove
    bspc desktop --layout tiled
    bspc desktop --layout monocle
    desktop=$(bspc query --desktops -d)
    echo "◼" > ${LAYOUTS_DIR}/${desktop}
}

set_even() {
    bsp-layout remove
    bspc desktop --layout tiled
    bsp-layout set even
    desktop=$(bspc query --desktops -d)
    echo "ℹ" > ${LAYOUTS_DIR}/${desktop}
}

set_tall() {
    bsp-layout remove
    bspc desktop --layout tiled
    bsp-layout set tall
    desktop=$(bspc query --desktops -d)
    echo "↕" > ${LAYOUTS_DIR}/${desktop}
}

set_wide() {
    bsp-layout remove
    bspc desktop --layout tiled
    bsp-layout set wide
    desktop=$(bspc query --desktops -d)
    echo "↔" > ${LAYOUTS_DIR}/${desktop}
}

set_pseudo() {
    bspc rule -a \* state=pseudo_tiled rectangle=1850x1040+0+0
}

remove_pseudo() {
    bspc rule -a \* state=tiled rectangle=1850x1040+0+0
    bspc rule -a Gimp state=floating follow=on
    bspc rule -a Surf state=tiled
    bspc rule -a ffplay state=floating
    bspc rule -a Gpick state=floating
    bspc rule -a qutebrowser desktop=^2
    bspc rule -a mpv state=pseudo_tiled rectangle=1850x1040+0+0
}

remove_layout() {
    bsp-layout remove
    bspc desktop --layout tiled

    desktop=$(bspc query --desktops -d)
    rm ${LAYOUTS_DIR}/${desktop}
}


get_icon() {
    desktop=$(bspc query --desktops -d)
    icon_path=${LAYOUTS_DIR}/${desktop}

    icon=$(cat ${icon_path} 2> /dev/null)

    if [ -z "$icon" ]
    then
        icon="💠"
    fi

    echo $icon
}

clear_icons() {
    rm ${LAYOUTS_DIR}/*
}

case "$LAYOUT" in
    "tiled") set_tiled;;
    "monocle") set_monocle;;
    "even") set_even;;
    "tall") set_tall;;
    "wide") set_wide;;
    "pseudo") set_pseudo;;
    "rpseudo") remove_pseudo;;
    "remove") remove_layout;;
    "icon") get_icon;;
    "clear") clear_icons;;
esac
