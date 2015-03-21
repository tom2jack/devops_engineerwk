#!/bin/bash

ROOT_ID=0

[ ! $UID -eq $ROOT_ID ] && { echo "You must run script under sudo permission"; exit 1; }

pname=$1

[ -z "$pname" ] && { echo "Usage $0 <processname>"; exit 2; }

kill(){
	ps -elf | grep $pname | grep -v "grep" | grep -v "${0}" | awk '{print $4}' | xargs kill -s SIGTERM
	status=$?
	[ $status -eq 0 ] && { echo "kill $pname SUCCESSFULLY !"; } || { echo "kill $pname UNSUCCESSFULLY !"; }
}

forceKill(){
	ps -elf | grep $pname | grep -v "grep" | grep -v "${0}" | awk '{print $4}' | xargs kill -s SIGKILL
	status=$?
	[ $status -eq 0 ] && { echo "force kill $pname SUCCESSFULLY !"; } || { echo "force kill $pname UNSUCCESSFULLY !"; }
}

list(){
	echo "PID list of process ${pname}:"
	list_pid=$(ps -elf | grep $pname | grep -v "grep" | grep -v "${0}" | awk '{print $4}')
        ## check length
	if [ ${#list_pid} -eq 0 ]; then
		echo "No process with name $pname is running"
	else
		echo $list_pid
	fi
}

case "$2" in
  kill)
        kill
        ;;
  forceKill)
        forceKill
        ;;
  list)
        list
        ;;
  *)
        echo "Usage: $0 <processname>  {kill|forceKill|list}"
        exit 2
esac

