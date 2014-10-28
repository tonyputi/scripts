#!/bin/bash

DATE=$(date +"%Y%m%d%H%M%S")
BASE_DIR=/root/backups/mysql
BACKUP_DIR=${BASE_DIR}/${DATE}

USERNAME="root"
PASSWORD="s1cc0m4r10"

[ -e ${BACKUP_DIR} ] || mkdir -p ${BACKUP_DIR}

mysqldump --user=${USERNAME} --password=${PASSWORD} --skip-extended-insert --all-databases > ${BACKUP_DIR}/mysql.sql

tar -jvcf ${BACKUP_DIR}.tar.bz2 -C ${BASE_DIR} ${DATE}
rm -rf ${BACKUP_DIR}
