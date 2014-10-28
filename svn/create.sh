#! /bin/bash

BASE="/var/lib/svn"

if [ $# -lt 1 ]; then
	echo "Usage : $0 <project>"
	exit
fi

URI=$BASE/$1

if [ -d ${URI} ]; then
	echo "Warning!!! The project ${1} already exist!"
	exit
fi

mkdir -p ${URI}
svnadmin create ${URI}
chown -R www-data.www-data ${URI}
chmod -R g+rws ${URI}
