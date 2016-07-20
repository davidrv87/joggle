#!/bin/bash

print_message ""
print_message "CONVERT AUDIO FORMAT" "success" "emphasis"
print_message ""

print_message "Options available listed below" "info" "emphasis"
print_message " (1) Select input audio location" "info"
print_message " (2) Select output audio location. If not specified, the same name of the input file will be used" "info"
print_message " (3) Select format of the output audio (aac/ac3/ogg/mp3/wav). Default: mp3" "info"
print_message " (0) Finish" "warning"
print_message ""

INPUT_FILE=""
OUTPUT_FILE=""
OUTPUT_DIR=""
FORMAT="mp3"
CODEC="libmp3lame"

print_settings(){
    print_message " (1) Input audio location: $INPUT_FILE" "info"
    print_message " (2) Output audio location: $OUTPUT_FILE" "info"
    print_message " (3) Format (aac/ac3/ogg/mp3/wav): $FORMAT" "info"
    print_message " (0) To finish" "warning"
    print_message ""
}

# https://linuxconfig.org/ffmpeg-audio-format-conversions
# This function returns the codec to be used based on the format selected
set_codec(){
    FORMAT=$1

    case $FORMAT in
        aac)
            CODEC="libfaac"
        ;;
        ac3)
            CODEC="ac3"
        ;;
        mp3)
            CODEC="libmp3lame"
        ;;
        ogg)
            CODEC="libvorbis"
        ;;
        wav)
            CODEC=""
        ;;
    esac
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
                OUTPUT_FILE="$OUTPUT_DIR/${FILENAME}.${FORMAT}"
            fi
        ;;
        2)
            read -p "Output audio file: " OUTPUT_FILE
            FILENAME=$(basename $OUTPUT_FILE | cut -d'.' -f1)
            OUTPUT_DIR=$(dirname $OUTPUT_FILE)
        ;;
        3)
            read -p "Output format (aac/ac3/ogg/mp3/wav): " FORMAT
            # Set the codec based on the format selected
            set_codec $FORMAT
            OUTPUT_FILE="$OUTPUT_DIR/${FILENAME}.${FORMAT}"
        ;;
        0)
            if [[ $INPUT_FILE == "" ]]; then
                print_message "Input audio file can't be empty. Please select the path of the file" "error"
            else
                break
            fi
        ;;
    esac
    print_settings
done

# Build the command to be sent
CMD="ffmpeg -i $INPUT_FILE  ${CODEC:+-acodec $CODEC} $OUTPUT_FILE"

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
