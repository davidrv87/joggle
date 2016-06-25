#!/bin/bash

# Define colors
BLACK="\033[0;30m"
BLACKBOLD="\033[1;30m"
RED="\033[0;31m"
REDBOLD="\033[1;31m"
GREEN="\033[0;32m"
GREENBOLD="\033[1;32m"
YELLOW="\033[0;33m"
YELLOWBOLD="\033[1;33m"
BLUE="\033[0;34m"
BLUEBOLD="\033[1;34m"
PURPLE="\033[0;35m"
PURPLEBOLD="\033[1;35m"
CYAN="\033[0;36m"
CYANBOLD="\033[1;36m"
WHITE="\033[0;37m"
WHITEBOLD="\033[1;37m"
RESETCOLOR="\e[00m"

RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to print a message with colors
# $1 - the message to be printed
# $2 - the level of the message - info, success, warning, error
# $3 - used to emphasized the message (bold)
print_message(){
    MSG=$1
    LEVEL=$2
    EMPHASIS=$3
    case $LEVEL in
        info)
            if [[ $EMPHASIS == "emphasis" ]]; then
                echo -e "${BLUEBOLD}${MSG}${RESETCOLOR}"
            else
                echo -e "${BLUE}${MSG}${RESETCOLOR}"
            fi
        ;;
        success)
            if [[ $EMPHASIS == "emphasis" ]]; then
                echo -e ${GREENBOLD}${MSG}${RESETCOLOR}
            else
                echo -e ${GREEN}${MSG}${RESETCOLOR}
            fi
        ;;
        warning)
            if [[ $EMPHASIS == "emphasis" ]]; then
                echo -e ${YELLOWBOLD}${MSG}${RESETCOLOR}
            else
                echo -e ${YELLOW}${MSG}${RESETCOLOR}
            fi
        ;;
        error)
            if [[ $EMPHASIS == "emphasis" ]]; then
                echo -e ${REDBOLD}${MSG}${RESETCOLOR}
            else
                echo -e ${RED}${MSG}${RESETCOLOR}
            fi
        ;;
        note)
            if [[ $EMPHASIS == "emphasis" ]]; then
                echo -e ${PURPLEBOLD}${MSG}${RESETCOLOR}
            else
                echo -e ${PURPLE}${MSG}${RESETCOLOR}
            fi
        ;;
        *)
                echo -e ${MSG}
        ;;
    esac
}
