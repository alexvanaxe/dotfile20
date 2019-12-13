dunst &
nitrogen --restore &
$HOME/.config/i3/monitor/saver.sh &
killall conky
killall stalonetray &
killall dwmstatusbar
sleep 2
#/home/alexvanaxe/.config/i3/conky/conky.sh &
#/home/alexvanaxe/.config/conky/night/conky.sh
/home/alexvanaxe/.config/conky/day/conky.sh
#/home/alexvanaxe/.config/conky/tonight/conky.sh
compton -b &
~/.dwm/dwmstatusbar &
stalonetray &
