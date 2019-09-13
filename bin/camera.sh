#!/bin/sh

ffplay -f video4linux2 -i /dev/video0 -video_size 320x240 -left 1030 -top 510 -fflags nobuffer
