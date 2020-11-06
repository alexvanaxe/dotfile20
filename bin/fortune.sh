#! /bin/dash

# Source the theme
. ${HOME}/.config/bspwm/themes/bsp.cfg

if [  "shabbat" = "$theme_name" ]; then
    fortune -l -s ara | fold -s -w 100
else
    fortune -n 400 -s
fi
