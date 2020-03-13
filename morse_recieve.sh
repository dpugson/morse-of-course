#!/usr/bin/env bash

set -e

SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"

if [[ $# -ne 2 ]]
then
    echo "Error: two arguments expected, $# provided."
    echo "Usage: morse_recieve.sh output1.txt output2.txt"
    exit 1
fi

function now
{
    python -c 'from time import time; print int(round(time() * 1000))'
}

function get_time_and_value
{
    start=$(now)
    read -n 1 curr
    end=$(now)
    runtime=$((end-start))

    echo $curr $runtime
}

TEXTA=""
TEXTB=""

curr_string=""
while true ; do
    time_and_value=$(get_time_and_value)
    value=$(echo $time_and_value | cut -d " " -f 1)
    time=$(echo $time_and_value | cut -d " " -f 2)

    TEXTB=$TEXTB$value

    if (( $time < 200 )); then
        curr_string=${curr_string}.
    elif (( $time < 800 )); then
        curr_string=$curr_string-
    else
        curr_string=$(echo $curr_string | sed "s/\./\\\\./g")
        translation="$(grep -- ^.$curr_string\$ $SCRIPTPATH/morse_table.txt | sed "s/\(.\).*/\1/")"
        if [ "$translation" != "" ]; then
            TEXTA=${TEXTA}${translation}
            curr_string=""
        else
            break
        fi
    fi
done

echo $TEXTA > $1
echo $TEXTB > $2
