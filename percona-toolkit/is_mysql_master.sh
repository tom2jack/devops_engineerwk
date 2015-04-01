#!/bin/bash
MYSQL_PASSWORD=""
MYSQL_USER="root"
prog="pt-slave-find"

do_pre_check(){
	which $prog > /dev/null 2>&1
	status=$?
	[ $status -ne 0 ] && { echo "I don't find $prog binary. Please install percona-toolkit before using script"; exit -1; }
}

do_check(){
	$prog --user "${MYSQL_USER}" --password "${MYSQL_PASSWORD}" | grep -F "Is not a slave" > /dev/null 2>&1
	status=$?
	[ $status -eq 0 ] && echo "This is a MASTER" || echo "This is a SLAVE"
}

do_pre_check
do_check

### this script is not tested on single mysql server.
### this script is not tested on chain replication environment. A server is a master and also slave.
### this script also return false alarm if a master is configured change master to other server. This is ordinary case when system switch over
### but he/she forget to do command reset slave all on master (new master)
### Be careful in using
