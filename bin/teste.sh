#!/bin/sh

teste=($(playerctl -a metadata 2> /dev/null | awk '{print $1}' | uniq))

teste_len=${#teste[@]}

if [ $teste_len -gt 1 ]; then
    echo "plus"
fi
