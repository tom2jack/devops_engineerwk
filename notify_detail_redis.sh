#!/bin/bash
master_name=$1
role=$2
state=$3
from_ip=$4
from_port=$5
to_ip=$6
to_port=$7
OUTPUT_FILE="/dev/shm/notify_redis_detail_event_output"
mail_subject=""
mail_body=""
THIS_IP="x.x.x.x"
SMTP_SERVER="y.y.y.y"
ADMIN="abc@xyz.com"
TEST_ADMIN="abc@xxx.com"
TARGET=$ADMIN

function send_mail(){
     mail_subject="${1}"
     mail_body="${2}"   
     cat ${mail_body} | /bin/mail -s  "${mail_subject}" -S smtp=smtp://${SMTP_SERVER} -S from="Admin_Notify_Redis_Sentinel<admin@xxx.com>" "$TARGET"
}


echo -e "Event:\nMaster_Name: ${master_name}\nRole: ${role}\nState: ${state}\nFrom_IP: ${from_ip}\nFrom_Port: ${from_port}\nTo_IP: ${to_ip}\nTo_Port: ${to_port}" > "${OUTPUT_FILE}"
mail_subject="DETAIL FAILOVER REDIS"
mail_body="${OUTPUT_FILE}"

### send mail
send_mail "${mail_subject}" "${mail_body}"
