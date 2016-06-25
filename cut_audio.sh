#!/bin/bash

print_message ""
print_message "CUT AUDIO" "success" "emphasis"
print_message ""

print_message "Options available listed below" "info" "emphasis"
print_message " (1) Select input audio location" "info"
print_message " (2) Select output audio location. Default: 'INPUTFILE_cut'" "info"
print_message " (3) Select start point. Format mm:ss[.xxx]" "info"
print_message " (4) Select duration of the audio. Format mm:ss[.xxx]" "info"
print_message " (0) Finish" "warning"
print_message ""

INPUT_FILE=""
OUTPUT_FILE=""
START_POINT=""
DURATION=""

print_settings(){
    print_message " (1) Input audio location: $INPUT_FILE" "info"
    print_message " (2) Output audio location: $OUTPUT_FILE" "info"
    print_message " (3) Start point: $START_POINT" "info"
    print_message " (4) Duration: $DURATION" "info"
    print_message " (0) To finish" "warning"
    print_message ""
}

while :
do
    read -s -n 1 OPTION
    case $OPTION in
        1)
            read -p "Input audio file: " INPUT_FILE
            if [[ $OUTPUT_FILE == "" ]]; then
                OUTPUT_DIR=$(dirname $INPUT_FILE)
                FILENAME=$(basename $INPUT_FILE | cut -d'.' -f1)
                OUTPUT_FILE="$OUTPUT_DIR/${FILENAME}_cut.mp3"
            fi
        ;;
        2)
            read -p "Output audio file: " OUTPUT_FILE
            OUTPUT_DIR=$(dirname $OUTPUT_FILE)
        ;;
        3)
            read -p "Start point mm:ss[.xxx]: " START_POINT
        ;;
        4)
            read -p "Duration mm:ss[.xxx]: " DURATION
        ;;
        0)
            if [[ $INPUT_FILE == "" ]]; then
                print_message "Input audio file can't be empty. Please select the path of the file" "error"
            elif [[ $START_POINT == "" ]] && [[ $DURATION == "" ]]; then
                print_message "Both 'Start point' and 'Duration' can't be empty at the same time. Please, set at least one" "error"
            else
                break
            fi
        ;;
    esac
    print_settings
done

# http://superuser.com/questions/377343/cut-part-from-video-file-from-start-position-to-end-position-with-ffmpeg

CMD="ffmpeg ${START_POINT:+-ss $START_POINT} ${DURATION:+-t $DURATION} -i $INPUT_FILE -acodec copy $OUTPUT_FILE"

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


