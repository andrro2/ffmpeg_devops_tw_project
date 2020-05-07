#!/bin/bash

CHANGED_DEP=$1
case $CHANGED_DEP in
	*)
		ffmpeg -i sources/main.mp4 -i sources/logo.png -filter_complex "overlay=10:10" test1.mp4
		;;
esac

inotifywait sources/ -e close_write | 
while read path action file; do 
    ARG=$file 
done 
./script.sh $ARG
