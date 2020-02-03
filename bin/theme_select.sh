#!/bin/sh

chosen=$(printf "night\\nday\\nlight\\nwallpaper" | dmenu "$@" -i -p "Change the theme: ")

if [ $chosen == "wallpaper" ]; then
    chosen_font=$(printf "Original\\nSoft" | dmenu "$@" -i -p "Chose the font kind:")
fi

if [ -z "$chosen" ]; then
    exit
fi

# Try to copy the config where is the themename

if [ "wallpaper" != "$chosen" ]; then
    cp $HOME/.config/bspwm/themes/$chosen.cfg $HOME/.config/bspwm/themes/bsp.cfg
fi
source $HOME/.config/bspwm/themes/bsp.cfg


reset_configs(){
    cp $HOME/.config/bspwm/themes/$theme_name.cfg $HOME/.config/bspwm/themes/bsp.cfg
    cp $HOME/.config/dunst/dunstrc_default $HOME/.config/dunst/dunstrc
    cp $HOME/.config/polybar/themes/$theme_name $HOME/.config/polybar/config
    cp $HOME/.config/conky/themes/$theme_name/process.conf $HOME/.config/conky/process.conf
    cp $HOME/.config/conky/themes/$theme_name/cpu.conf $HOME/.config/conky/cpu.conf
    cp $HOME/.config/conky/themes/$theme_name/clock.conf $HOME/.config/conky/clock.conf
    cp $HOME/.config/conky/themes/$theme_name/fortune.conf $HOME/.config/conky/fortune.conf
}

refresh_theme() {
    source $HOME/.config/bspwm/themes/bsp.cfg
    killall picom; picom -b &
    killall dunst; dunst &
    bspc config window_gap 6
    # Start conky according theme
    killall conky

    killall polybar
    polybar default&
    sleep 1
    $HOME/.config/conky/conky.sh
    bspc config top_padding 16
}

prepare_wallpaper(){
    killall picom
    killall conky
    killall polybar
}

startup_theme(){
    echo "starting up"
    reset_configs
    if [ "light" == "$chosen" ]; then
        killall picom
        killall conky
        killall polybar
        xsetroot -solid blue
        bspc config top_padding 0
        bspc config window_gap 0  
    else
        # Set wallpaper according theme
        nitrogen --save --set-scaled --random $HOME/Documents/Pictures/Wallpapers/$theme_name

        refresh_theme
    fi
}

retrieve_color(){
    if [  "$1" == "i" ]; then
        echo "${colors_wallpaper[$((${#colors_wallpaper[@]} - $2))]}"
    else
        echo "${colors_wallpaper[$2]}"
    fi
}

update_files(){
    cur_wallpaper=$(cat $XDG_CONFIG_HOME/nitrogen/bg-saved.cfg | grep file | cut -d "=" -f 2)
    colors_wallpaper=($(convert $cur_wallpaper -format %c -depth 4  histogram:info:- | grep -o "#......" | cut -d "#" -f 2))

    if [ "$theme_name" == "day" ]; then
        if [ $chosen_font != "Original" ]; then
            sed -i "s/Special Elite/Hack/" $HOME/.config/polybar/config
            sed -i "s/Lekton/Hack/" $HOME/.config/bspwm/themes/bsp.cfg
            sed -i "s/Special Elite/Hack/" $HOME/.config/conky/process.conf
            sed -i "s/Special Elite/Hack/" $HOME/.config/conky/cpu.conf
        fi
                
        # Config polybar colors
        sed -i "s/^background = #.*/background = #C5$(retrieve_color i 3)/" $HOME/.config/polybar/config
        sed -i "s/^background-alt = #.*/background-alt = #$(retrieve_color i 240)/" $HOME/.config/polybar/config
        sed -i "s/^foreground = #.*/foreground = #$(retrieve_color n 2)/" $HOME/.config/polybar/config
        sed -i "s/^foreground-alt = #.*/foreground-alt = #$(retrieve_color n 20)/" $HOME/.config/polybar/config
        sed -i "s/^foreground-alt2 = #.*/foreground-alt2 = #$(retrieve_color n 70)/" $HOME/.config/polybar/config

        # Config dunst colors
        sed -i "s/#0B1B03/#$(retrieve_color i 3)/" $HOME/.config/dunst/dunstrc
        sed -i "s/#FFFFFF/#$(retrieve_color n 2)/" $HOME/.config/dunst/dunstrc
        sed -i "s/#03171B/#$(retrieve_color i 10)/" $HOME/.config/dunst/dunstrc

        sed -i "s/#27125B/#$(retrieve_color i 240)/" $HOME/.config/dunst/dunstrc
        sed -i "s/#FFFFFF/#$(retrieve_color n 2)/" $HOME/.config/dunst/dunstrc
        sed -i "s/#03171B/#$(retrieve_color i 70)/" $HOME/.config/dunst/dunstrc
        
        # Config bsp collors
        sed -i "s/#6F8E27/#$(retrieve_color n 2)/" $HOME/.config/bspwm/themes/bsp.cfg

        sed -i "s/#F0F2CD/#$(retrieve_color i 3)/" $HOME/.config/bspwm/themes/bsp.cfg
        sed -i "s/#49291D/#$(retrieve_color n 2)/" $HOME/.config/bspwm/themes/bsp.cfg
        sed -i "s/#8A792B/#$(retrieve_color i 240)/" $HOME/.config/bspwm/themes/bsp.cfg
        sed -i "s/#DFF1DA/#$(retrieve_color n 20)/" $HOME/.config/bspwm/themes/bsp.cfg
        # Configure conky! Here we go!
        sed -i "s/777777/$(retrieve_color i 25)/" $HOME/.config/conky/process.conf
        sed -i "s/CBD38F/$(retrieve_color n 20)/" $HOME/.config/conky/process.conf
        sed -i "s/FFFFFF/$(retrieve_color i 5)/" $HOME/.config/conky/process.conf

        sed -i "s/777777/$(retrieve_color i 25)/" $HOME/.config/conky/cpu.conf
        sed -i "s/CBD38F/$(retrieve_color n 20)/" $HOME/.config/conky/cpu.conf
        sed -i "s/FFFFFF/$(retrieve_color i 5)/" $HOME/.config/conky/cpu.conf

        sed -i "s/041866/$(retrieve_color i 1)/" $HOME/.config/conky/clock.conf
        sed -i "s/CBD38F/$(retrieve_color i 5)/" $HOME/.config/conky/clock.conf
        sed -i "s/2d2d2d/$(retrieve_color n 5)/" $HOME/.config/conky/cpu.conf
    fi

    if [ "$theme_name" == "night" ]; then
        if [ $chosen_font != "Original" ]; then
            sed -i "s/Iceland/Cantarell/" $HOME/.config/polybar/config
            sed -i "s/Iceland/Cantarell/" $HOME/.config/bspwm/themes/bsp.cfg
            sed -i "s/Iceland/Cantarell/" $HOME/.config/conky/process.conf
            sed -i "s/Iceland/Cantarell/" $HOME/.config/conky/cpu.conf
            sed -i "s/Orbitron/Cantarell/" $HOME/.config/conky/fortune.conf
            sed -i "s/Orbitron/Cantarell/" $HOME/.config/conky/clock.conf
        fi

        # Config polybar colors
        sed -i "s/^background = #.*/background = #87$(retrieve_color n 1)/" $HOME/.config/polybar/config
        sed -i "s/^background-alt = #.*/background-alt = #$(retrieve_color n 9)/" $HOME/.config/polybar/config
        sed -i "s/^foreground = #.*/foreground = #$(retrieve_color i 5)/" $HOME/.config/polybar/config
        sed -i "s/^foreground-alt = #.*/foreground-alt = #$(retrieve_color i 10)/" $HOME/.config/polybar/config
        sed -i "s/^foreground-alt2 = #.*/foreground-alt2 = #$(retrieve_color i 215)/" $HOME/.config/polybar/config

        # Config bsp collors
        sed -i "s/#372549/#$(retrieve_color i 5)/" $HOME/.config/bspwm/themes/bsp.cfg
        sed -i "s/#123456/#$(retrieve_color i 5)/" $HOME/.config/bspwm/themes/bsp.cfg

        sed -i "s/#05080F/#$(retrieve_color n 1)/" $HOME/.config/bspwm/themes/bsp.cfg
        sed -i "s/#EAF2EF/#$(retrieve_color i 5)/" $HOME/.config/bspwm/themes/bsp.cfg
        sed -i "s/#040C38/#$(retrieve_color n 9)/" $HOME/.config/bspwm/themes/bsp.cfg
        sed -i "s/#EAF2EF/#$(retrieve_color i 10)/" $HOME/.config/bspwm/themes/bsp.cfg

        # Config dunst colors
        sed -i "s/#0B1B03/#$(retrieve_color n 1)/" $HOME/.config/dunst/dunstrc
        sed -i "s/#FFFFFF/#$(retrieve_color i 5)/" $HOME/.config/dunst/dunstrc
        sed -i "s/#03171B/#$(retrieve_color n 20)/" $HOME/.config/dunst/dunstrc

        sed -i "s/#27125B/#$(retrieve_color n 9)/" $HOME/.config/dunst/dunstrc
        sed -i "s/#FFFFFF/#$(retrieve_color i 20)/" $HOME/.config/dunst/dunstrc
        sed -i "s/#03171B/#$(retrieve_color n 70)/" $HOME/.config/dunst/dunstrc

        # Configure conky! Here we go!
        sed -i "s/041866/$(retrieve_color n 15)/" $HOME/.config/conky/process.conf
        sed -i "s/CBD38F/$(retrieve_color i 45)/" $HOME/.config/conky/process.conf
        sed -i "s/FFFFFF/$(retrieve_color i 5)/" $HOME/.config/conky/process.conf

        sed -i "s/041866/$(retrieve_color n 15)/" $HOME/.config/conky/cpu.conf
        sed -i "s/CBD38F/$(retrieve_color i 45)/" $HOME/.config/conky/cpu.conf
        sed -i "s/FFFFFF/$(retrieve_color i 5)/" $HOME/.config/conky/cpu.conf

        sed -i "s/041866/$(retrieve_color n 1)/" $HOME/.config/conky/clock.conf
        sed -i "s/CBD38F/$(retrieve_color i 45)/" $HOME/.config/conky/clock.conf
        sed -i "s/2d2d2d/$(retrieve_color i 5)/" $HOME/.config/conky/cpu.conf

    fi

}

set_color_by_walpaper() {
    # Retrieve the background path
    echo "Changing color wallpaper"
    prepare_wallpaper
    echo "Reseting configs"
    reset_configs
    echo "Sleeping..."
    
    # This function is located on bspwm themes files
    echo "Updating files"
    update_files

    echo "Refreshing theme"
    refresh_theme
    echo "Ending"
}

case "$chosen" in
    "wallpaper") set_color_by_walpaper;;
    *) startup_theme;;
esac

set_vim(){
    if [ "day" == $1 ]; then
        sed -i 's/^colorscheme.*/colorscheme PaperColor/' $HOME/.config/nvim/personal/home.vim
        sed -i 's/set background.*/set background=light/' $HOME/.config/nvim/personal/home.vim
        sed -i 's/airline_theme.*/airline_theme="papercolor"/' $HOME/.config/nvim/personal/home.vim
    fi
    if [ "night" == $1 ]; then
        sed -i 's/^colorscheme.*/colorscheme one/' $HOME/.config/nvim/personal/home.vim
        sed -i 's/set background.*/set background=dark/' $HOME/.config/nvim/personal/home.vim
        sed -i 's/airline_theme.*/airline_theme="one"/' $HOME/.config/nvim/personal/home.vim
    fi
    if [ "light" == $1 ]; then
        sed -i 's/^colorscheme.*/colorscheme default/' $HOME/.config/nvim/personal/home.vim
        sed -i 's/set background.*/set background=dark/' $HOME/.config/nvim/personal/home.vim
        sed -i 's/airline_theme.*/airline_theme="base16_vim"/' $HOME/.config/nvim/personal/home.vim
    fi
}

# Set vim according theme
case "$chosen" in
    "night") set_vim $chosen;;
    "day") set_vim $chosen;;
    "light") set_vim $chosen;;
    *) echo "None";;
esac

# Colors
bspc config focused_border_color            "$focused_border_color"
bspc config active_border_color             "$active_border_color"
bspc config normal_border_color             "$normal_border_color"
bspc config urgent_border_color             "$urgent_border_color"
bspc config presel_feedback_color           "$presel_feedback_color"
bspc config focused_locked_border_color     "$focused_locked_border_color"
bspc config active_locked_border_color      "$active_locked_border_color"
bspc config normal_locked_border_color      "$normal_locked_border_color"
bspc config focused_sticky_border_color     "$focused_sticky_border_color"
bspc config active_sticky_border_color      "$active_sticky_border_color"
bspc config normal_sticky_border_color      "$normal_sticky_border_color"
bspc config focused_private_border_color    "$focused_private_border_color"
bspc config active_private_border_color     "$active_private_border_color"
bspc config normal_private_border_color     "$normal_private_border_color"
