#!/bin/bash

ROOT_ID=0
INTERNAL_PORT=4567
prog="garbd"

[ $UID -ne $ROOT_ID ] && { 
	echo "You must run script under root permission" 
	exit 1
}

rpm -qa | grep galera > /dev/null 2>&1
status=$?
[ ! $status -eq 0 ] && {
        echo "You don't have galera installation. You must run yum install galera first"
        exit 2
}

which $prog > /dev/null 2>&1
status=$?
[ ! $status -eq 0 ] && {
        echo "I cannot find $prog binary on your system in PATH"
        exit 2
}

group=$1
node1=$2
node2=$3

if [ -z "$group" ]; then
    echo "Usage: $0 \"<group>\" \"<ip node1>\" \"<ip node2>\" {start|stop|status|}"
    exit 3
fi

if [ -z "$node1" ]; then
    echo "Usage: $0 \"<group>\" \"<ip node1>\" \"<ip node2>\" {start|stop|status|}"
    exit 3
fi  

if [ -z "$node2" ]; then
    echo "Usage: $0 \"<group>\" \"<ip node1>\" \"<ip node2>\" {start|stop|status|}"
    exit 3
fi

start(){
    echo "start $prog service"		
}

stop(){
    echo "stop $prog service"		
}

status(){
    echo "status of $prog service"		
}

case "$4" in
  start)
        start
        ;;
  stop)
        stop
        ;;
  status)
        status
        ;;
  *)
        echo "Usage: $0 \"<group>\" \"<ip node1>\" \"<ip node2>\" {start|stop|status|}"
        exit 3
esac



