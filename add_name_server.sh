#!/bin/bash
KEY_WORD="nameserver"

PRIMARY_GOOGLE_DNS="8.8.8.8"
SECONDARY_GOOGLE_DNS="8.8.4.4"

PRIMARY_OPEN_DNS="208.67.222.222"
SECONDARY_OPEN_DNS="208.67.220.220"

FILE="/etc/resolv.conf"

ROOT_ID=0
[ ! $UID -eq $ROOT_ID ] && { echo "You must run script as a root"; exit 1; }

[ ! -f ${FILE} ] && { echo "File ${FILE} is not exists"; exit 2; }

### xoa tat ca cac dong bat dau bang cum tu nameserver
sed -i "/^${KEY_WORD}/d" "${FILE}"  

echo -e "${KEY_WORD} ${PRIMARY_GOOGLE_DNS}\n${KEY_WORD} ${SECONDARY_GOOGLE_DNS}\n${KEY_WORD} ${PRIMARY_OPEN_DNS}\n${KEY_WORD} ${SECONDARY_OPEN_DNS}" >> ${FILE}
