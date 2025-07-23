#! /bin/bash

function handle_interrupt {
    tput cnorm
    exit 0
}

function print_help {
   echo "A simple script to run the sl program in a loop."
   echo
   echo "Usage:"
   echo     "choo.sh -h"
   echo     "choo.sh [-o <argument]"
   echo     "choo.sh [-s <argument]"
   echo
   echo "Options:"
   echo     "h             Print this Help."
   echo     "s <number>    Set the amount of time to sleep before running sl again."
   echo     "o <options>   Set the options to pass to sl."
   echo
   exit 0
}

trap handle_interrupt SIGINT

sleep_time=0
options="-e"

while getopts hs:o: option
do 
    case "${option}"
    in
	h)print_help;;
        s)sleep_time=${OPTARG};;
        o)options+=${OPTARG};;
    esac
done

tput init
while :
do
    sl $options
    tput clear
    tput civis
    sleep $sleep_time
done
