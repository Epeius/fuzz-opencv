#!/bin/sh

if [$# -eq 0 ]; then	
	exit
fi
num=$1

if [ $num -eq 1]; then
	sh ./startafl.sh  1 &
else
	while [ $num -ge 1 ]
	do
		sh ./startafl.sh $num &
		num=$((num-1))
	done
fi
