#!/bin/bash

CHANGED_DEP=$1
case $CHANGED_DEP in
	intro.opus)
		ffmpeg -i sources/outro.mp3 sources/intro.opus
		ffmpeg -i sources/main.mp4 -i sources/logo.png -filter_complex "overlay=10:10" test1.mp4
		;;
	outro.mp3)
		;;
	main.mp4)
		;;
	logo.png)
		;;
	outro.opus)
		ffmpeg -i sources/intro.mp3 sources/outro.opus
		ffmpeg -i sources/main.mp4 -i sources/logo.png -filter_complex "overlay=10:10" test1.mp4
		;;
	intro.mp3)
		;;
	intro_b.webm)
		ffmpeg -i sources/outro.mp3 sources/intro.opus
		ffmpeg -i sources/intro.webm -i sources/intro.opus -c copy -map 0:v:0 -map 1:a:0 sources/intro_b.webm
		ffmpeg -i sources/main.mp4 -i sources/logo.png -filter_complex "overlay=10:10" test1.mp4
		;;
	intro.webm)
		;;
	outro_b.webm)
		ffmpeg -i sources/intro.mp3 sources/outro.opus
		ffmpeg -i sources/out.webm -i sources/outro.opus -c copy -map 0:v:0 -map 1:a:0 sources/outro_b.webm
		ffmpeg -i sources/main.mp4 -i sources/logo.png -filter_complex "overlay=10:10" test1.mp4
		;;
	outro.webm)
		;;
	*)
		ffmpeg -i sources/outro.mp3 sources/intro.opus
		ffmpeg -i sources/intro.webm -i sources/intro.opus -c copy -map 0:v:0 -map 1:a:0 sources/intro_b.webm
		ffmpeg -i sources/intro.mp3 sources/outro.opus
		ffmpeg -i sources/out.webm -i sources/outro.opus -c copy -map 0:v:0 -map 1:a:0 sources/outro_b.webm
		ffmpeg -i sources/main.mp4 -i sources/logo.png -filter_complex "overlay=10:10" test1.mp4
		;;
esac

inotifywait sources/ -e close_write | 
while read path action file; do 
    ARG=$file 
done 
./script.sh $ARG
