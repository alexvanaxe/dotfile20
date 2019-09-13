#!/bin/sh

echo "swaymsg 'output "*" background '$PWD/"$1"' fill'"
swaymsg 'output "*" background '$PWD/"$1"' fill'
