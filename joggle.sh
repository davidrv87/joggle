#!/bin/bash

DIR="/opt/joggle"

source $DIR/utils/utils.sh

print_message "What do you want to do?" "info" "emphasis"
print_message " (1) Download a video from YouTube" "info"
print_message " (2) Extract the audio from a YouTube video" "info"
print_message " (3) Extract the audio from a local video" "info"
print_message " (4) Cut audio or video file" "info"
print_message " (5) Convert audio format" "info"
print_message " (6) Concat audio files" "info"
print_message ""

read -s -n 1 OPTION

print_message "Selected option: $OPTION"

case $OPTION in
    1)
        source $DIR/functions/func__download_video.sh
    ;;
    2)
        source $DIR/functions/func__extract_audio_youtube_video.sh
    ;;
    3)
        source $DIR/functions/func__extract_audio_local_video.sh
    ;;
    4)
        source $DIR/functions/func__cut_file.sh
    ;;
    5)
        source $DIR/functions/func__convert_audio_format.sh
    ;;
    6)
        source $DIR/functions/func__concat_audio_files.sh
    ;;
    *)
        print_message "'$OPTION' is not a recognised option" "error"
    ;;
esac
