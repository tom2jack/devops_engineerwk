#!/bin/bash
HOST="localhost"
PORT="6379"
TOTAL_KEYS="10"

which nc > /dev/null 2>&1
status=$?
[ $status -ne 0 ] && { echo "There is no nc on your system"; exit 1; }

which redis-cli > /dev/null 2>&1
status=$?
[ $status -ne 0 ] && { echo "There is no redis-cli on your system"; exit 1; }

redis-cli keys key? | xargs redis-cli del

i=0
while [ $i -lt ${TOTAL_KEYS} ]; do
        echo -e "set key${i} value${i}\n" | nc "${HOST}" "${PORT}"
        i=$((i+1))
done

