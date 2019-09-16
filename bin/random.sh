#!/bin/sh

teste="$(shuf -n1 -e $HOME/.config/variety/Downloaded/*/*)"
swaymsg 'output "*" background '"$teste"' fill'
