#!/bin/sh

valor=$(pidof spotify)
if [ -z "$valor" ]
then
	printf $valor
fi

