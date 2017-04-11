#!/bin/bash
SERVICE_NAMES="sshd crond haproxy keepalived ntpd rsyslog garb munin-node iptables"
THIS_IP="x.x.x.x"
SMTP_SERVER="y.y.y.y"
ADMIN="abc@xyz.com"
TEST_ADMIN="abc@xxx.com"
TARGET=$ADMIN
output_file="/dev/shm/service_status"
function notify_mail(){
     message=${1}
     cat $message | /bin/mail -s  "[NOTIFICATION]  Service Status on `hostname` - ip: $THIS_IP " -S smtp=smtp://${SMTP_SERVER} -S from="Admin_Check_Service_Status<admin@xxx.com>" "$TARGET"
}
function main(){
for service_item in $SERVICE_NAMES; do
        service $service_item status > /dev/null 2>&1
        status_code=$?
        if [ $status_code -eq 0 ]; then
                echo "$service_item is STARTED" >> "${output_file}"
        elif [ $status_code -eq 3 ]; then
                echo "$service_item is NOT STARTED" >> "${output_file}"
        elif [ $status_code -eq 1 ]; then
                echo "$service_item does not have startup script or it is not installed [RE-CHECK]" >> "${output_file}"
        else
                echo "[$service_item] get status_code=$status_code [UNDEFINED]" >> "${output_file}"
        fi
done
#cat /dev/shm/service_status > /root/output_on_boot ## for test without stmp
notify_mail "${output_file}"
}
main

