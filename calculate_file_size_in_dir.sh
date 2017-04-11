#!/bin/bash

echo "This script is very useful for finding big files to remove when full disk usage"
echo 
HELP="Usage $0 <staring_dir> [file|dir] [asc|desc]"

starting_dir=$1
if [ -z "${starting_dir}" ]; then
	echo "${HELP}"
	exit 1
fi

tag=$2
if [[ -z "${tag}" || ( "${tag}" != "file" && "${tag}" != "dir" ) ]]; then
	echo "${HELP}"
	exit 1
fi

order=$3
if [[ -z "${order}" || ( "${order}" != "asc" && "${order}" != "desc" ) ]]; then
	echo "${HELP}"
	exit 1
fi


if [ ! -d "${starting_dir}" ]; then
	echo "${starting_dir} is not exists. This must be a absolute path to dir or a . for current directory"
	exit 2
fi

_command="find ${starting_dir} -maxdepth 1"
[ "${tag}" == "file" ] &&  _command="$_command -type f"
[ "${tag}" == "dir" ] &&  _command="$_command -type d"
_command="$_command -exec du -hs {} \;"
[ "${order}" == "asc" ] &&  _command="$_command | sort -h" 
[ "${order}" == "desc" ] &&  _command="$_command | sort -rh" 
eval $_command
