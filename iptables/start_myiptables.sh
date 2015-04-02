#!/bin/bash
IPT=`which iptables`
GW_IF=`route -n | grep "UG" | awk '{print $8}'`
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

for interface in $GW_IF; do
	IP=`ip a | grep "inet" | grep "$interface" | awk '{print $2}' | xargs | sed 's/\s/,/g'`
	### /bin/sh co bo cu phap gon hon /bin/bash, khi do toi phai dung dau = (trong /bin/sh) thay vi dau == (trong /bin/bash)
	if [ "${interface}" == "${TUN_IF}" ]; then
		ports="22,80" 		
	else
		ports="80"
		$IPT -A OUTPUT -o $interface -s $IP -p udp --dport 53 -j ACCEPT	
	fi	
	filter_int $interface $IP $ports
done
