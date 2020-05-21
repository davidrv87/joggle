#!/bin/bash

print_message ""
print_message "EXTRACT AUDIO FROM A YOUTUBE VIDEO" "success" "emphasis"
print_message ""

print_message "Options available listed below" "info" "emphasis"
print_message " (1) Select a YouTube video URL" "info"
print_message " (2) Select the file with video URLs" "info"
print_message " (3) Set the output directory for the audios. Default 'output/'" "info"
print_message " (0) Finish" "warning"
print_message " Note: options (1) and (2) are exclusive. Last one set will be used" "note"
print_message ""

WORKING_DIR=$(pwd)
YOUTUBE_URL=""
VIDEOS_FILE=""
OUTPUT_DIR="output"

# This variable is used to control if the download is from a URL or from a file
# Values: "url" or "file"
MODE="none"

print_settings(){
    print_message " (1) YouTube video URL: $YOUTUBE_URL" "info"
    print_message " (2) File with video URLs: $VIDEOS_FILE" "info"
    print_message " (3) Output directory: $OUTPUT_DIR" "info"
    print_message " (0) To finish" "warning"
    print_message " Current mode: '$MODE'" "note"
    print_message ""
}

extract_audio_from_video(){
    local VID=$1

    print_message "Extracting audio from '$VID'" "info" "emphasis"

    # Download the video
    youtube-dl --extract-audio --audio-format mp3 $VID

    if [[ $? != "0" ]]; then
        print_message "There was an error downloading this video" "error" "emphasis"
        print_message ""
    else
        print_message "Video successfully downloaded" "success"
    fi
}

while :
do
    read -s -n 1 OPTION
    case $OPTION in
        1)
            read -p "YouTube video URL: " YOUTUBE_URL
            MODE="url"
        ;;
        2)
            read -p "File with video URLs: " VIDEOS_FILE
            MODE="file"
        ;;
        3)
            read -p "Output directory: " OUTPUT_DIR
        ;;
        0)
            if [[ $VIDEOS_FILE == "" ]] && [[ YOUTUBE_URL == "" ]]; then
                print_message "Please, indicate a YouTube URL or a file with YouTube videos URLs" "error"
            else
                break
            fi
        ;;
    esac
    print_settings
done

if [[ $MODE == "file" ]]; then
    print_message ""
    print_message "Audios from '$VIDEOS_FILE' will be downloaded to '$OUTPUT_DIR'" "warning" "emphasis"
    read -p "Are you sure? [y/N]: " response

    if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
    then
        # Create the output directory
        mkdir -p $OUTPUT_DIR
        # Copy the videos file to a known location
        cp $VIDEOS_FILE /tmp
        cd $OUTPUT_DIR

        # Download the videos from the file
        while IFS= read -r VIDEO || [ -n "$VIDEO" ]
        do
            extract_audio_from_video $VIDEO
        done < /tmp/$(basename $VIDEOS_FILE)
    else
        print_message "Cancelled by user" "error" "emphasis"
        exit 0
    fi

elif [[ $MODE == "url" ]]; then
    print_message ""
    print_message "The audio of '$YOUTUBE_URL' will be downloaded to '$OUTPUT_DIR'" "warning" "emphasis"
    read -p "Are you sure? [y/N]: " response

    if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]
    then
        # Create the output directory
        mkdir -p $OUTPUT_DIR
        cd $OUTPUT_DIR
        extract_audio_from_video $YOUTUBE_URL
    else
        print_message "Cancelled by user" "error" "emphasis"
        exit 0
    fi
fi