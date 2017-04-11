#!/bin/bash

starting_dir=$1
if [ -z "${starting_dir}" ]; then
	echo "This script will print only files or only directies of current directory"
	echo "Usage $0 <starting_dir> [file|dir]"
	exit 1
fi

tag=$2
if [[ -z "${tag}" || ( "${tag}" != "file" && "${tag}" != "dir" ) ]]; then
	echo "This script will print only files or only directies of current directory"
	echo "Usage $0 <staring_dir> [file|dir]"
	exit 1
fi

if [ ! -d "${starting_dir}" ]; then
	echo "${starting_dir} is not exists. This must be a absolute path to dir or a . for current directory"
	exit 2
fi

if [ "${tag}" == "file" ]; then
	ls -l "${starting_dir}" | grep -E -v "^d" | awk '{print $9}' | strings
fi
if [ "${tag}" == "dir" ]; then
	ls -l "${starting_dir}" | grep -E "^d" | awk '{print $9}' | strings
fi
