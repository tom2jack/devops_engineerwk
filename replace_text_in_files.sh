#!/bin/bash
FILES="sample1 sample2 sample3"
old_word=$1
new_word=$2

if [ -z "${old_word}" ]; then
    echo "Usage: $0 \"<old_word>\" \"<new_word>\""
    exit
fi

if [ -z "$new_word" ]; then
    echo "Usage: $0 \"<old_word>\" \"<new_word>\""
    exit
fi


for file_item in $FILES; do
	if [ ! -f $file_item ]; then
        	echo "$file_item is not exists in current directory"
        	exit
	else
		### replace string in files
		sed -i "s/${old_word}/${new_word}/g" ${file_item}
	fi
done

