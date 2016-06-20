#!/bin/bash

echo ""
echo "EXTRACT AUDIO FROM LOCAL VIDEO"
echo ""

echo "Options available listed below"
echo " (1) Select input video location"
echo " (2) Select output audio location. Default: location of the video"
echo " (0) Finish"
echo ""

VIDEO=""
AUDIO=""
OUTPUT_DIR=""

print_settings(){
    echo " (1) Video location: $VIDEO"
    echo " (2) Audio location: $AUDIO"
    echo " (0) To finish"
    echo ""
}

while :
do
    read -s -n 1 OPTION
    case $OPTION in
        1)
            read -p "Video file: " VIDEO
            if [[ $AUDIO == "" ]]; then
                OUTPUT_DIR=$(dirname $VIDEO)
                FILENAME=$(basename $VIDEO | cut -d'.' -f1)
                AUDIO="$OUTPUT_DIR/$FILENAME.mp3"
            fi
        ;;
        2)
            read -p "Audio output file: " AUDIO
            OUTPUT_DIR=$(dirname $AUDIO)
        ;;
        0)
            break
        ;;
    esac
    print_settings
done


CMD="ffmpeg -i $VIDEO -acodec libmp3lame $AUDIO"

echo ""
echo "Command to be sent: '$CMD'"
read -p "Are you sure? [y/N]: " response

if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
then
    mkdir -p $OUTPUT_DIR
    $CMD
else
    echo "Cancelled by user"
    exit 0
fi


