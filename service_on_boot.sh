#!/bin/bash

SERVICE_NAMES="sshd crond haproxy keepalived ntpd rsyslog garb munin-node iptables"

for service_item in $SERVICE_NAMES; do
        chkconfig $service_item on > /dev/null 2>&1
        status_code=$?
        if [ $status_code -eq 0 ]; then
                echo "$service_item is auto-boot [OK]"
        elif [ $status_code -eq 1 ]; then
                echo "$service_item does not have startup script or it is not installed [NOT OK]"
        else
                echo "[$service_item] get status_code=$status_code [UNDEFINED]"   
        fi
done
