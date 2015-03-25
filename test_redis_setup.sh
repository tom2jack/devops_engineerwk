#!/bin/bash

ROOT_ID=0
[ $UID -ne $ROOT_ID ] && { echo "You must run script as root permission"; exit 1; }

## check it out
service redis_6379 stop > /dev/null 2>&1
echo "waiting for stopping."
while [ -f /var/run/redis_6379.pid ]; do
        echo -n "."
done
echo "redis service is stopped"
service redis_6379 start > /dev/null 2>&1
echo "waiting for starting."
while [ ! -f /var/run/redis_6379.pid ]; do
        echo -n "."
done
echo "redis service is started"
service redis_6379 start > /dev/null 2>&1
status=$(redis-cli ping)
[ "$status" != "PONG" ] && { echo "redis is not started correctly"; exit 5; }
status=$(redis-cli save)
[ "$status" != "OK" ] && { echo "redis is not started correctly"; exit 5; }
echo "DONE ! Redis is now started successfully"

