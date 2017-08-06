#!/bin/bash

event_type=$event1
event_desc=$event2
OUTPUT_FILE="/dev/shm/notify_redis_event_output"
mail_subject=""
mail_body=""
THIS_IP="x.x.x.x"
SMTP_SERVER="y.y.y.y"
ADMIN="abc@xyz.com"
TEST_ADMIN="abc@xxx.com"
TARGET=$ADMIN


function send_mail(){
     mail_subject="${event1}"
     mail_body="${evvent2}"   
     cat ${mail_body} | /bin/mail -s  "${mail_subject}" -S smtp=smtp://${SMTP_SERVER} -S from="Admin_Notify_Redis_Sentinel<admin@xxx.com>" "$TARGET"
}


echo -e "=== Event ===\nType: ${event_type}\nDescription: ${event_desc}" > "${OUTPUT_FILE}"
if [ "${event_type}" == "+sdown" ]; then
        mail_subject = "[WARNING] Sentinel on `hostname` (${THIS_IP}) detect: There is something is DOWN"
        mail_body=${OUTPUT_FILE}
        send_mail "${mail_subject}" "${mail_body}"
elif [ "${event_type}" == "-sdown" ]; then
        mail_subject = "[NOTICE] Sentinel on `hostname` (${THIS_IP}) detect: There is something is UP"
        mail_body=${OUTPUT_FILE}
        send_mail "${mail_subject}" "${mail_body}"
elif [ "${event_type}" == "+odown" ]; then
        mail_subject = "[WARNING] Sentinel on `hostname` (${THIS_IP}) detect: Master is DOWN"
        mail_body=${OUTPUT_FILE}
        send_mail "${mail_subject}" "${mail_body}"
elif [ "${event_type}" == "+new-epoch" ]; then
        mail_subject = "[WARNING] Sentinel on `hostname` (${THIS_IP}) say: We will TRY FAILOVER this redis replication"
        mail_body=${OUTPUT_FILE}
        send_mail "${mail_subject}" "${mail_body}"
elif [ "${event_type}" == "-failover-abort-not-elected" ]; then
        mail_subject = "[ERROR] Sentinel on `hostname` (${THIS_IP}) shout: ABORT FAILOVER. I need you, system admins"
        mail_body=${OUTPUT_FILE}
        send_mail "${mail_subject}" "${mail_body}"
elif [ "${event_type}" == "+switch-master" ]; then
        mail_subject = "[NOTICE] Sentinel on `hostname` (${THIS_IP}) claim: Switch to new master SUCCESSFULLY"
        mail_body=${OUTPUT_FILE}
        send_mail "${mail_subject}" "${mail_body}"
else
        ### do nothing
fi
