#!/bin/bash

ROOT_ID=0
REDIS_LASTEST_STABLE="redis-4.0.1"
URL_REDIS_DOWNLOAD="http://download.redis.io/releases/${REDIS_LASTEST_STABLE}.tar.gz"
FILE_TAR_GZ="${REDIS_LASTEST_STABLE}.tar.gz"
INSTALLATION_DIR="${REDIS_LASTEST_STABLE}"
TCL="tcl"
GCC="gcc"

[ $UID -ne $ROOT_ID ] && { echo "You must run script under the root permission"; exit 1; }

### remove current
echo "Remove ${FILE_TAR_GZ} ${INSTALLATION_DIR} if they exists in current directory"
rm -rf "${FILE_TAR_GZ}" > /dev/null 2>&1
rm -rf "${INSTALLATION_DIR}" > /dev/null 2>&1
echo "Remove ${FILE_TAR_GZ} ${INSTALLATION_DIR} [OK]"

echo "This script will download redis-2.8.19. You should replace URL_REDIS_DOWNLOAD by lastest stable"
curl -o "${FILE_TAR_GZ}" -Lk "${URL_REDIS_DOWNLOAD}" > /dev/null 2>&1
status=$?
[ $status -ne 0 ] && { echo "Download Redis $URL_REDIS_DOWNLOAD failed"; exit 2; }
echo "Download ${REDIS_LASTEST_STABLE} [OK]"

### check file
file "${FILE_TAR_GZ}" | grep "gzip compressed data" > /dev/null 2>&1
status=$?
[ $status -ne 0 ] && { echo "File $FILE_TAR_GZ is broken"; exit 3; }

tar xzf "${FILE_TAR_GZ}"
status=$?
[ $status -ne 0 ] && { echo "Extract ${FILE_TAR_GZ} failed"; exit 3; }
echo "Extract ${FILE_TAR_GZ} [OK]"

yum -y install "${TCL}" > /dev/null 2>&1
rpm -qa | grep tcl > /dev/null 2>&1
status=$?
[ $status -ne 0 ] && { echo "Install tcl failed"; exit 2; }
echo "Install ${TCL} dependency [OK]"

yum -y install gcc gcc-c++ > /dev/null 2>&1
rpm -qa | grep gcc-c++ > /dev/null 2>&1
status=$?
[ $status -ne 0 ] && { echo "Install gcc failed"; exit 2; }
echo "Install ${GCC} dependency [OK]"

### compiling redis
cd "${INSTALLATION_DIR}"
make > /dev/null 2>&1
status=$?
[ $status -ne 0 ] && { echo "Compiling $REDIS_LASTEST_STABLE failed"; exit 4; }

echo "I will make test. If you are impatient, you will comment make test"
### test redis
#make test > /dev/null 2>&1
#status=$?
#[ $status -ne 0 ] && { echo "Test $REDIS_LASTEST_STABLE failed"; exit 4; }

echo "Compiling redis successfully [OK]"

echo "I am now in `pwd`. I will install more correctly"

### more properly installation
cp src/redis-server /usr/local/bin/
echo "copy src/redis-server /usr/local/bin/ [OK]"
cp src/redis-cli /usr/local/bin/
echo "copy src/redis-cli /usr/local/bin/ [OK]"
cp src/redis-benchmark /usr/local/bin
echo "copy src/redis-benchmark /usr/local/bin/ [OK]"
cp src/redis-check-aof /usr/local/bin
echo "copy src/redis-check-aof /usr/local/bin/ [OK]"
cp src/redis-sentinel /usr/local/bin
echo "copy src/redis-sentinel /usr/local/bin/ [OK]"
cp src/redis-check-dump /usr/local/bin
echo "copy src/redis-check-dump /usr/local/bin/ [OK]"

mkdir -p /etc/redis
echo "mkdir -p /etc/redis [OK]"
mkdir -p /var/redis
echo "mkdir -p /var/redis [OK]"

cp utils/redis_init_script /etc/init.d/redis_6379
echo "copy utils/redis_init_script /etc/init.d/redis_6379 [OK]"

cp redis.conf /etc/redis/6379.conf
echo "copy redis.conf /etc/redis/6379.conf [OK]"
mkdir -p /var/redis/6379
echo "mkdir -p /var/redis/6379 [OK]"

### modify /etc/redis/6379.conf
echo -e "Modify /etc/redis/6379.conf\nSet daemonize to yes (by default it is set to no).\nSet the pidfile to /var/run/redis_6379.pid (modify the port if needed).\nChange the port accordingly. In our example it is not needed as the default port is already 6379.\nSet your preferred loglevel.\nSet the logfile to /var/log/redis_6379.log\nSet the dir to /var/redis/6379 (very important step!)\n"

echo -e "If you want to use chkconfig on init script. You should insert three comment lines:\n# chkconfig: - 64 36\n# description:  Redis Server.\n# processname: redis_6379\n"

useradd redis -M -d /var/redis -s /sbin/nologin
chown -R redis:redis /var/redis
touch /var/log/redis_6379.log
chown -R redis:redis /var/log/redis_6379.log

echo "DONE !"
