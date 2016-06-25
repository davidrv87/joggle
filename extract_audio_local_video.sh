#!/bin/bash

print_message ""
print_message "EXTRACT AUDIO FROM LOCAL VIDEO" "success" "emphasis"
print_message ""

print_message "Options available listed below" "info" "emphasis"
print_message " (1) Select input video location" "info"
print_message " (2) Select output audio location. Default: location of the video" "info"
print_message " (0) Finish" "warning"
print_message ""

INPUT_FILE=""
OUTPUT_FILE=""
OUTPUT_DIR=""

print_settings(){
    print_message " (1) Video location: $INPUT_FILE" "info"
    print_message " (2) Audio location: $OUTPUT_FILE" "info"
    print_message " (0) To finish" "warning"
    print_message ""
}

while :
do
    read -s -n 1 OPTION
    case $OPTION in
        1)
            read -p "Input video file: " INPUT_FILE
            if [[ $OUTPUT_FILE == "" ]]; then
                OUTPUT_DIR=$(dirname $INPUT_FILE)
                FILENAME=$(basename $INPUT_FILE | cut -d'.' -f1)
                OUTPUT_FILE="$OUTPUT_DIR/$FILENAME.mp3"
            fi
        ;;
        2)
            read -p "Output audio file: " OUTPUT_FILE
            OUTPUT_DIR=$(dirname $OUTPUT_FILE)
        ;;
        0)
            if [[ $INPUT_FILE == "" ]]; then
                print_message "Video can't be empty. Please, select the path of the video" "error"
            else
                break
            fi
        ;;
    esac
    print_settings
done


CMD="ffmpeg -i $INPUT_FILE -acodec libmp3lame $OUTPUT_FILE"

print_message ""
print_message "Command to be sent: '$CMD'" "warning" "emphasis"
read -p "Are you sure? [y/N]: " response

if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then
    mkdir -p $OUTPUT_DIR
    $CMD
else
    print_message "Cancelled by user" "error" "emphasis"
    exit 0
fi


