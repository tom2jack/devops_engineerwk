#!/bin/bash

### write for service on debian OS like Ubuntu

ROOT_ID=0
[ ! $UID -eq $ROOT_ID ] && { echo "You must run script below root permission"; exit 1; }

service=""
flag=0;
while [[ ${#service} -eq 0 || ${flag} -eq 0 ]]; do
	read -p "Enter a service name you know: " service
	if [ ! -f /etc/init.d/${service} ]; then
		echo "The service $service is not exists. Please re-enter."
		continue
	else	
		flag=1
		choice=""
		while [[ "$choice" != "start" && "$choice" != "stop" ]]; do
		        read -p "Do you want start/stop service on boot (start/stop)" choice
		done

		if [ $choice == "start" ]; then
		        update-rc.d $service defaults
		fi

		if [ $choice == "stop" ]; then
		        update-rc.d -f $service remove
		fi
		tbc=""
		while [[ "$tbc" != "yes" && "$tbc" != "no" ]]; do
			read -p "Do you want to continue (yes/no)" tbc
			if [ $tbc == "yes" ]; then
				flag=0
			elif [ $tbc == "no" ]; then
				flag=1	
			else
				continue;	
			fi
		done
	fi	
done
echo "Hello, see you again :D"
