#!/bin/bash

ip=$1
port=$2
PING_MSG_COUNT=3
PING_TIMEOUT=5
NETCAT_TIMEOUT=5

if [ -z "$ip" ]; then
    echo "Usage: $0 \"<ip>\" \"<port>\""
    exit 1
fi

if [ -z "$port" ]; then
    echo "Usage: $0 \"<ip>\" \"<port>\""
    exit 1
fi

echo "${ip}" | egrep "^(([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])\.){3}([0-9]|[1-9][0-9]|1[0-9]{2}|2[0-4][0-9]|25[0-5])$" > /dev/null
is_valid_ip=$?
if [ ! $is_valid_ip -eq 0 ]; then
	echo "${ip} is not a valid IP address"
	exit 2		
fi

### ping test
ping -q -W ${PING_TIMEOUT} -c ${PING_MSG_COUNT} ${ip} > /dev/null 2>&1
ping_status=$?
if [ $ping_status -eq 0 ]; then
	ping_result="ping ${ip} [OK]"
else
	ping_result="ping ${ip} [NOT OK]"
fi

### test tcp port
nc -z -v -n -w ${NETCAT_TIMEOUT} ${ip} ${port} > /dev/null 2>&1
port_status=$? 
if [ $port_status -eq 0 ]; then
        port_result_tcp="check tcp port number ${port} [OK]"
else
        port_result_tcp="check tcp port number ${port} [NOT OK]"
fi

### test udp port
nc -u -z -v -n -w ${NETCAT_TIMEOUT} ${ip} ${port} > /dev/null 2>&1
port_status=$?
if [ $port_status -eq 0 ]; then
        port_result_udp="check udp port number ${port} [OK]"
else
        port_result_udp="check udp port number ${port} [NOT OK]"
fi

echo "This script is not using send mail. Please write more !"
echo "PING AND CHECK PORT RESULT"
### use echo -e for new line character 
echo
echo -e "${ping_result}\n${port_result_tcp}\n${port_result_udp}"
