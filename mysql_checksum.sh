#!/bin/bash

master_ip="x.y.z.t"
mysql_user="check_db"
mysql_passwd="check_db"
checksum_meta_db="check_db"
checksum_meta_tbl="dsns"
separator="|"
DEFAULT_IFS=$IFS
SMTP_SERVER="xx.yy.zz.tt"

function is_master(){
        pt-slave-find --user $mysql_user --password "$mysql_passwd" --host "$master_ip" | grep -F "Is not a slave" > /dev/null
        return_val=$?
        return "$return_val"
}

function notify_not_master(){
     ADMIN="xxx@xxx.com"
     message=$1
     echo $message | /bin/mail -s  "This server $master_ip is no longer master" -S smtp=smtp://${SMTP_SERVER} -S from="Admin_Checksum<admin@xxx.com>" "$ADMIN"
}

function notify_differences(){ ### send mail neu co difference
     ADMIN="xxx@xxx.com"
     slave_host_ip=$1
     message=$2
     cat $message | /bin/mail -s  "[Warning]  There is a difference between master `hostname` ($master_ip) and slave $slave_host_ip" -S smtp=smtp://${SMTP_SERVER} -S from="Admin_Checksum<admin@xxx.com>" "$ADMIN"
}

function checksum(){ ### pass param $1 la dsn string
     dsn=$1
     slave_host_ip=$(echo $dsn | cut -d "," -f 1 | cut -d "=" -f 2)
     if [ "$slave_host_ip" == "$master_ip" ]; then
        return
     fi
     checksum_output="/dev/shm/checksum_output"
     pt-table-checksum -h $master_ip -u $mysql_user -p"$mysql_passwd"  --recursion-method dsn=$dsn,D=$checksum_meta_db,t=$checksum_meta_tbl --nocheck-binlog-format --set-vars innodb_lock_wait_timeout=50 --replicate-check-only --quiet  > $checksum_output
     grep -F "Differences" $checksum_output
     status=$?
     [ $status -eq 0 ] && notify_differences "${slave_host_ip}" "${checksum_output}"
}

function main(){
     is_master
     return_val=$?
     if [ "$return_val" == 1 ]; then
        msg="This server $master_ip is no longer master. Please run script on your current master"
        notify_not_master "${msg}"
        exit
     fi

     IFS=$DEFAULT_IFS
     all_nodes=$(mysql -u $mysql_user -p"$mysql_passwd" -h $master_ip -ANe "select group_concat(dsn separator '$separator')  from $checksum_meta_db.$checksum_meta_tbl;")
     IFS="|"
     for node in $all_nodes; do
         checksum "${node}"
     done
}

main

