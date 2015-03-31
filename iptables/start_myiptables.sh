#!/bin/sh
IPT=`which iptables`
GW_IF=`route -n | grep "UG" | grep "0.0.0.0" | awk '{print $8}'`
LO_IF="lo"
TUN_IF="tun0"

$IPT -F

$IPT -P INPUT DROP
$IPT -P OUTPUT DROP
$IPT -P FORWARD DROP

##### for loopback ####
$IPT -A OUTPUT -o $LO_IF -j ACCEPT
$IPT -A INPUT -i $LO_IF -j ACCEPT

filter_int()
{
	int="${1}"
	ip="${2}"
	ports="${3}"
	echo $int $ip $ports
	$IPT -A OUTPUT -o $int -d 0/0 -s $ip -p tcp -m multiport --dport $ports -m state --state NEW,ESTABLISHED -j ACCEPT
	$IPT -A INPUT -i $int -s 0/0 -d $ip -m state --state ESTABLISHED,RELATED -j ACCEPT	
	$IPT -A OUTPUT -o $int -s $ip -d 0/0 -p icmp --icmp-type 8/0 -j ACCEPT
	$IPT -A INPUT -i $int -s 0/0 -d $ip -p icmp --icmp-type 0/0 -j ACCEPT
	
}

IP=`ifconfig | grep "inet addr" | grep -v "255.0.0.0" | grep -v "255.255.255.0" | awk -F ":" '{print $2}' | awk '{print $1}'| xargs | sed 's/\s/,/g'`
if [ ! -z "$IP" ]; then
filter_int $TUN_IF $IP "22"
fi
IP=`ifconfig | grep "inet addr" | grep -v "255.0.0.0" | grep -v "255.255.255.255" | awk -F ":" '{print $2}' | awk '{print $1}'| xargs | sed 's/\s/,/g'`
$IPT -A OUTPUT -o $GW_IF -s $IP -p udp --dport 53 -j ACCEPT
filter_int $GW_IF $IP "80"



