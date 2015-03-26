#!/bin/bash
THIS_IP=192.168.7.230
REDIS_WORKING_DIR="/var/redis/6379"
src=$REDIS_WORKING_DIR
dest="/data/backup/redis-$THIS_IP"
backup_server=192.168.7.232
SSH_PORT=22
### do rsync
function do_rsync(){
     rsync --log-file=/var/log/redis_6379_backup.log --delete -avzhP $src -e "ssh -p $SSH_PORT" $backup_server:$dest
}

(
# Wait for lock on /var/lock/.myscript.lock (fd 200) for 10 seconds
flock -x -w 10 200 || exit 1
    do_rsync
) 200>/var/lock/.redis_6379_backup.lock
