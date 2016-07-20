#!/bin/bash

print_message ""
print_message "CUT AUDIO OR VIDEO FILE" "success" "emphasis"
print_message ""

print_message "Options available listed below" "info" "emphasis"
print_message " (1) Select type of file: 'audio' or 'video'" "info"
print_message " (2) Select input file location" "info"
print_message " (3) Select output file location. Default: 'INPUTFILE_cut'" "info"
print_message " (4) Select start point. Format mm:ss[.xxx]" "info"
print_message " (5) Select duration of the file. Format mm:ss[.xxx]" "info"
print_message " (0) Finish" "warning"
print_message ""

FILE_TYPE=""
INPUT_FILE=""
OUTPUT_FILE=""
START_POINT=""
DURATION=""

print_settings(){
    print_message " (1) Type of file: ${FILE_TYPE}" "info"
    print_message " (2) Input file location: $INPUT_FILE" "info"
    print_message " (3) Output file location: $OUTPUT_FILE" "info"
    print_message " (4) Start point: $START_POINT" "info"
    print_message " (5) Duration: $DURATION" "info"
    print_message " (0) To finish" "warning"
    print_message ""
}

while :
do
    read -s -n 1 OPTION
    case $OPTION in
        1)
            read -p "File type: " FILE_TYPE
            if [[ $FILE_TYPE == "audio" ]]; then
                FILE_TYPE_CODEC="-acodec"
            elif [[ $FILE_TYPE == "video" ]]; then
                FILE_TYPE_CODEC="-codec"
            fi
        ;;
        2)
            read -p "Input file: " INPUT_FILE
            if [[ $OUTPUT_FILE == "" ]]; then
                OUTPUT_DIR=$(dirname $INPUT_FILE)
                FILENAME=$(basename $INPUT_FILE | cut -d'.' -f1)
                EXTENSION=$(basename $INPUT_FILE | cut -d'.' -f2)
                OUTPUT_FILE="$OUTPUT_DIR/${FILENAME}_cut.${EXTENSION}"
            fi
        ;;
        3)
            read -p "Output file: " OUTPUT_FILE
            OUTPUT_DIR=$(dirname $OUTPUT_FILE)
        ;;
        4)
            read -p "Start point mm:ss[.xxx]: " START_POINT
        ;;
        5)
            read -p "Duration mm:ss[.xxx]: " DURATION
        ;;
        0)
            if [[ $INPUT_FILE == "" ]]; then
                print_message "Input file can't be empty. Please select the path of the file" "error"
            elif [[ $START_POINT == "" ]] && [[ $DURATION == "" ]]; then
                print_message "Both 'Start point' and 'Duration' can't be empty at the same time. Please, set at least one" "error"
            elif [[ $FILE_TYPE == "" ]]; then
                print_message "File type can't be empty. Please, select between 'audio' or 'video'" "error"
            elif [[ $FILE_TYPE != "audio" ]] && [[ $FILE_TYPE != "video" ]]; then
                print_message "'${FILE_TYPE}' is not a valid type of file. Please, select between 'audio' or 'video'" "error"
            else
                break
            fi
        ;;
    esac
    print_settings
done

# http://superuser.com/questions/377343/cut-part-from-video-file-from-start-position-to-end-position-with-ffmpeg

# Build the command to be sent

CMD="ffmpeg ${START_POINT:+-ss $START_POINT} ${DURATION:+-t $DURATION} -i $INPUT_FILE ${FILE_TYPE_CODEC} copy $OUTPUT_FILE"

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
