#!/usr/bin/env bash

set -e

function usage {
    echo "MORSE CODE SENDER"
    echo "morse.sh --send    input1.txt  input2.txt"
    echo "morse.sh --recieve output1.txt output2.txt"
}

MORSE_SEND=0
MORSE_RECIEVE=0

MORSE_RFILES=()
while [[ $# -gt 0 ]]
do
    key="$1"
    case $key in
        -s|--send)
        MORSE_SEND=1
        shift
        ;;
        -r|--recieve)
        MORSE_RECIEVE=1
        shift
        ;;
        *)
        MORSE_FILES+=("$1") 
        shift
        ;;
    esac
done

if (( (MORSE_SEND + MORSE_RECIEVE) != 1 )); then
    echo "error: you must specify either --send or --recieve!"
    usage
    exit 1
fi

if [ "${#MORSE_FILES[@]}" != "2" ]; then
    echo "error: expected two files!"
    usage
    exit 1
fi

if [ $MORSE_READ == "1" ]; then
    while read -n 1 MORSE_CURR_CHAR; do
      echo "$MORSE_CURR_CHAR"
    done < "${1:-/dev/stdin}"
fi

