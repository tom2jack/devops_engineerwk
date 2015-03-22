#!/bin/bash

### write for service on debian OS like Ubuntu

ROOT_ID=0
[ ! $UID -eq $ROOT_ID ] && { echo "You must run script below root permission"; exit 1; }

ask(){
        answer=""
        question="${1}"
        read -p "${question}" answer
        echo "${answer}"      
}
show(){
	msg="${1}"
	echo "${msg}"
}

do_start_on_boot(){
	service="${1}"
	update-rc.d "${service}" defaults
}

do_stop_on_boot(){
	service="${1}"
	update-rc.d -f "${service}" remove
}

do_on_boot(){
	service="${1}"
	choice="${2}"
	if [ $choice == "start" ]; then
		do_start_on_boot "${service}"
	fi
	if [ $choice == "stop" ]; then
		do_stop_on_boot "${service}"
	fi
}


to_be_continue(){
	flag=0	
	tbc=""
        while [[ "$tbc" != "yes" && "$tbc" != "no" ]]; do
        	tbc=$(ask "Do you want to continue (yes/no)? ")
                if [ $tbc == "yes" ]; then
                	flag=0
               	else
			### thoat vong lap ket thuc chuong trinh
                  	flag=1  
                fi
        done
	return "${flag}"
}

service=""
flag=0;
while [[ ${#service} -eq 0 || ${flag} -eq 0 ]]; do
	
	service=$(ask "Enter a service name you know: ")
	if [ ! -f /etc/init.d/${service} ]; then
		show "The service $service is not exists. Please re-enter."
		continue
	else	
		### reset choice var for loop below does work on next loop !
		choice=""
		while [[ "$choice" != "start" && "$choice" != "stop" ]]; do
			choice=$(ask "Do you want start/stop service on boot (start/stop)? ")
		done

		do_on_boot "${service}" "${choice}"
		to_be_continue
		flag=$?
	fi	
done
show "Hello, see you again :D"

