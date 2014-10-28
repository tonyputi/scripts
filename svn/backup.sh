#!/bin/bash

DATE=$(date +"%Y%m%d%H%M%S")
BASE_DIR=/root/backups/subversion
BACKUP_DIR=${BASE_DIR}/${DATE}
REPOS="/var/lib/svn"

[ -e ${BACKUP_DIR} ] || mkdir -p ${BACKUP_DIR}

for REPO in $(ls ${REPOS}); do
	svnadmin dump ${REPOS}/${REPO} > ${BACKUP_DIR}/${REPO}.out
done

tar -jvcf ${BACKUP_DIR}.tar.bz2 -C ${BASE_DIR} ${DATE}
rm -rf ${BACKUP_DIR}
