#!/bin/bash

DATE=$(date +"%Y%m%d%H%M%S")
BASE_DIR=/root/backups/redmine
BACKUP_DIR=${BASE_DIR}/${DATE}

DATABASE=`cat /etc/redmine/default/database.yml | sed -rn 's/ *database: (.+)/\1/p'`
USERNAME=`cat /etc/redmine/default/database.yml | sed -rn 's/ *username: (.+)/\1/p'`
PASSWORD=`cat /etc/redmine/default/database.yml | sed -rn 's/ *password: (.+)/\1/p'`
FILES=/var/lib/redmine/default/files

[ -e ${BACKUP_DIR} ] || mkdir -p ${BACKUP_DIR}

mysqldump --user=${USERNAME} --password=${PASSWORD} --skip-extended-insert $DATABASE > ${BACKUP_DIR}/redmine.sql
cp -r ${FILES} ${BACKUP_DIR}

tar -jvcf ${BACKUP_DIR}.tar.bz2 -C ${BASE_DIR} ${DATE}
rm -rf ${BACKUP_DIR}
