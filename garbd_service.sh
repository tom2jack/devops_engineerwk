#!/bin/bash

ROOT_ID=0
INTERNAL_PORT=4567
LOG_FILE=/var/log/garbd.log
BIND_IP="0.0.0.0"
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
    garbd -a gcomm://${node1}:${INTERNAL_PORT},${node2}:${INTERNAL_PORT}?wait_prim=no -g ${group} -o gmcast.listen_addr=tcp://${BIND_IP}:${INTERNAL_PORT} --daemon --log ${LOG_FILE}
    status=$?
    [ $status -eq 0 ] && { echo "starting $prog service [OK]"; } || { echo "starting $prog service [NOT OK]"; }
}

stop(){
    killall $prog > /dev/null 2>&1
    status=$?
    [ $status -eq 0 ] && { echo "stopping $prog service [OK]"; } || { echo "stopping $prog service [NOT OK]"; }

}

forceStop(){
    ps -elf | grep $prog | grep -v "grep" | awk '{print $4}' | xargs kill -s SIGKILL
   # status=$?
   # [ $status -eq 0 ] && { echo "force stopping $prog service [OK]"; } || { echo "force stopping $prog service [NOT OK]"; }
}

status(){
    ps -elf | grep $prog | grep -v "grep" > /dev/null 2>&1
    status1=$?
    netstat -tulpn | grep tcp | grep ${INTERNAL_PORT} > /dev/null 2>&1
    status2=$?
    [[ ! status1 -eq 0 || ! status2 -eq 0 ]] && { echo "$prog service is NOT RUNNING"; return; }
    echo "$prog service is RUNNING"
}

case "$4" in
  start)
        start
        ;;
  stop)
        stop
        ;;
  forceStop)
        forceStop
        ;;
  status)
        status
        ;;
  *)
        echo "Usage: $0 \"<group>\" \"<ip node1>\" \"<ip node2>\" {start|stop|forceStop|status|}"
        exit 3
esac

