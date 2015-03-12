#!/bin/bash

function ask(){

answer=''
while [[ "$answer" != "yes" && "$answer" != "no" ]]; do
        read -p "$msg(yes/no) ?" answer
        echo "$answer"
        if [[ "$answer" != "yes" && "$answer" != "no" ]]; then
                echo "Try again"
        fi
done
echo "Your anwser is $answer." >&2
}
msg=$1
if [ -z "$msg" ]; then
    echo "Usage: $0 \"<msg>\""
    exit
fi


result=$(ask "${msg}")
echo "result = ${result}"
