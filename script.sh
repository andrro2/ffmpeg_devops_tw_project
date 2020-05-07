#!/bin/bash

CHANGED_DEP=$1
case $CHANGED_DEP in
	a)
		echo build artifact -d a ,b ,c
		;;
	b)
		echo build artifact -d b
		echo build artifact -d a ,b ,c
		;;
	c)
		echo build artifact -d c
		echo build artifact -d b
		echo build artifact -d a ,b ,c
		;;
	d)
		echo build artifact -d d
		echo build artifact -d c
		echo build artifact -d b
		echo build artifact -d a ,b ,c
		;;
	g)
		echo build artifact -d g
		echo build artifact -d d
		echo build artifact -d c
		echo build artifact -d b
		echo build artifact -d a ,b ,c
		;;
	*)
		echo build artifact -d g
		echo build artifact -d d
		echo build artifact -d c
		echo build artifact -d b
		echo build artifact -d a ,b ,c
		;;
esac

inotifywait sources/ -e close_write | 
while read -r path action file; do 
    ARG=$file 
done 
./start_build.sh 
