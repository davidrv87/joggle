#!/bin/bash

source utils.sh

print_message "What do you want to do?" "info" "emphasis"
print_message " (1) Download a video from YouTube" "info"
print_message " (2) Extract the audio from a YouTube video" "info"
print_message " (3) Extract the audio from a local video" "info"
print_message " (4) Cut audio" "info"
print_message " (5) Convert audio format" "info"
print_message " (6) Convert video format" "info"
print_message ""

read -s -n 1 OPTION

print_message "Selected option: $OPTION"

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
        print_message "'$OPTION' is not a recognised option" "error"
    ;;
esac
