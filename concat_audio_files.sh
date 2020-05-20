#!/bin/bash

print_message ""
print_message "CONCAT AUDIO FILES" "success" "emphasis"
print_message ""

print_message "Options available listed below" "info" "emphasis"
print_message " (1) Folder mode: relative path to the folder that contains the audio files to concatenate" "info"
print_message " (2) File mode: relative path to a file that contains the name of the audio files to concatenate (one per line)" "info"
print_message " (3) Select output file location. Default: 'concat_audios' (note the extension)" "info"
print_message " (0) Finish" "warning"
print_message ""

MODE=""
FOLDER_LOCATION=""
FILE_LOCATION=""
OUTPUT_FILE="concat_audios.mp3"
OUTPUT_DIR=""
FILES_LIST=""

print_settings(){
    print_message " (1) Folder location: $FOLDER_LOCATION" "info"
    print_message " (2) File location: $FILE_LOCATION" "info"
    print_message " (3) Output file location: $OUTPUT_FILE" "info"
    print_message " (0) To finish" "warning"
    print_message " Note: options (1) and (2) are exclusive. Last one set will be used" "note"
    print_message ""
}

concat_files() {
  if [[ $MODE == "folder" ]]; then
    for FILE in `ls $FOLDER_LOCATION`; do FILES_LIST="$FILES_LIST$FILE|"; done
  else
    for FILE in `cat $FILE_LOCATION`; do FILES_LIST="$FILES_LIST$FILE|"; done
  fi
  # Remove the last '|'
  FILES_LIST=${FILES_LIST%?}
}

while :
do
    read -s -n 1 OPTION
    case $OPTION in
        1)
            read -p "Folder location: " FOLDER_LOCATION
            MODE="folder"
        ;;
        2)
            read -p "File location: " FILE_LOCATION
            MODE="file"
        ;;
        3)
            read -p "Output file: " OUTPUT_FILE
            OUTPUT_DIR=$(dirname $OUTPUT_FILE)
        ;;
        0)
            if [[ $MODE == "" ]]; then
                print_message "Select either the 'folder' or 'file' for the audios to be concatenated" "error"
            else
                break
            fi
        ;;
    esac
    print_settings
done

# https://trac.ffmpeg.org/wiki/Concatenate

# Build list of files to concatenate
concat_files

# Build the command to be sent
CMD="ffmpeg -i \"$FILES_LIST\" -acodec copy $OUTPUT_FILE"

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
