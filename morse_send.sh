#!/usr/bin/env bash

set -e

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

if [[ $# -ne 2 ]]
then
    echo "Error: two arguments expected, $# provided."
    echo "Usage: morse_send.sh input1.txt input2.txt"
    exit 1
fi

RAWINPUTA=$(cat $1)
RAWINPUTB=$(cat $2)

function sanitize {
    local VALUE=$(echo $@ | tr -cd '[:alnum:]._-')
    python3 -c "print('$VALUE'.upper())" 
}

INPUTA=$(sanitize $RAWINPUTA)
INPUTB=$(sanitize $RAWINPUTB)

function send_dot {
    sleep 0.1
    printf $(get_next_output_letter)
}

function send_dash {
    sleep 0.5
    printf $(get_next_output_letter)
}

function send_space {
    sleep 1
    printf $(get_next_output_letter)
}

function get_morse_sequence {
    echo "searching for $@"
    grep $@ $SCRIPTPATH/morse_table.txt | sed "s/.\(.*\)/\1/"
}

function get_next_output_letter {
    echo ${INPUTB:$OUTPUT_INDEX:1}
}

function output_morse_sequence {
    local SEQUENCE=$@

    for (( i=0; i<${#SEQUENCE}; i++ )); do
        CURR="${SEQUENCE:$i:1}"
        if [ "$CURR"  = "." ]; then
            send_dot 
            OUTPUT_INDEX=$((OUTPUT_INDEX + 1))
            OUTPUT_INDEX=$((OUTPUT_INDEX % ${#INPUTB}))
        elif [ "$CURR" = "-" ]; then
            send_dash 
            OUTPUT_INDEX=$((OUTPUT_INDEX + 1))
            OUTPUT_INDEX=$((OUTPUT_INDEX % ${#INPUTB}))
        fi
    done
}

OUTPUT_INDEX=0
while read -n 1 CURR ; do
    MORSE_SEQ=$(get_morse_sequence $CURR)
    output_morse_sequence $MORSE_SEQ
    send_space
    OUTPUT_INDEX=$((OUTPUT_INDEX + 1))
    OUTPUT_INDEX=$((OUTPUT_INDEX % ${#INPUTB}))
done <<< "$INPUTA"
