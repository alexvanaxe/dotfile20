dunst &
nitrogen --restore &
$HOME/.config/i3/monitor/saver.sh &
killall conky
sleep 2
#/home/alexvanaxe/.config/i3/conky/conky.sh &
/home/alexvanaxe/.config/conky/night/conky.sh
#/home/alexvanaxe/.config/conky/day/conky.sh
#/home/alexvanaxe/.config/conky/tonight/conky.sh
compton -b &
killall stalonetray &
stalonetray &
killall dwmstatusbar
~/.dwm/dwmstatusbar &
