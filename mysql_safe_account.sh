#!/bin/bash
root_name='root'
root_passwd='<root passwd>'
user_name=$1
from_host=$2
db_name=$3
### check param
if [[ -z "${user_name}" || -z "${from_host}" || -z "${db_name}" ]]; then
        echo "Usage: $0 \"<user_name>\" \"<from_host>\" \"<db_name>\""
        exit
fi
### create db neu chua ton tai
mysql -u "${root_name}" -p"${root_passwd}" -ANe "create database if not exists ${db_name}" 2> /dev/null

### check if user is exists, script nay chi ho tro grant quyen cho user da ton tai
mysql -u "${root_name}" -p"${root_passwd}" -ANe "select 1 from mysql.user where user='$user_name'" 2> /dev/null | grep 1 > /dev/null
status=$?
if [ $status -eq 1 ]; then
        echo "User ${user_name} is not exists. Please create this user before using this script"
        exit
fi

### gan quyen
mysql -u "${root_name}" -p"${root_passwd}" -ANe "revoke all privileges on *.*  from '${user_name}'@'${from_host}';" 2> /dev/null
mysql -u "${root_name}" -p"${root_passwd}" -ANe "revoke all privileges on ${db_name}.*  from '${user_name}'@'${from_host}';" 2> /dev/null
mysql -u "${root_name}" -p"${root_passwd}" -ANe "grant create, alter, create view, show view, create routine, alter routine, trigger, delete, insert, select, update, execute on ${db_name}.* to '${user_name}'@'${from_host}';" 2> /dev/null
echo "Show grants:"
mysql -u "${root_name}" -p"${root_passwd}" -ANe "show grants for '${user_name}'@'${from_host}';" 2> /dev/null
### Chu y:
# 1. Neu khong co " " boc ngoai tuyet doi dung dung '${1}' hay chuyen thanh "'{$1}'"
# 2. Dung su dung ${1} don doc, hay kem no trong "${1}"
# 3. Neu muon hien thi "" thi dung kieu echo "Usage: $0 \"<user_name>\" \"<from_host>\" \"<db_name>\""
# 4. Tuyet doi khong dung `` o trong script, trong db day thuong la cap nhay boc ten db name, table name, user name nhung doi voi script no ngam hieu string nam trong `` la command.
# 5. Su dung passwd mysql trong command se xuat hien thong bao: Warning: Using a password on the command line interface can be insecure. Hay dung 2> /dev/null de loai bo thong bao nay

