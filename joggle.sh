#!/bin/bash

echo "What do you want to do?"
echo " (1) Download a video from YouTube"
echo " (2) Extract the audio from a YouTube video"
echo " (3) Extract the audio from a local video"
echo " (4) Cut audio"
echo " (5) Convert audio format"
echo " (6) Convert video format"
echo ""

read -s -n 1 OPTION

echo "Selected option: $OPTION"

case $OPTION in
    1)
        source download_video.sh
    ;;
    2)
        source extract_audio_youtube_video.sh
    ;;
    3)
        source extract_audio_local_video.sh
    ;;
    4)
        source cut_audio.sh
    ;;
    5)
        source convert_audio_format.sh
    ;;
    6)
        source convert_video_format.sh
    ;;
    *)
        echo "'$OPTION' is not a recognised option"
    ;;
esac
