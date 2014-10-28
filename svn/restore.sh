#!/bin/bash

SRC="$1"
DST="${2:-/var/lib/svn/}"
TMP=$(mktemp -d /tmp/svn.XXXXXXXX)

bzip2 -qt $SRC && {
	tar -xjpf $SRC -C $TMP
	for repo in $(find $TMP -name *.out); do
		name=$(basename $repo | awk -F. '{print $1}')
		[ -e $DST/$name ] || sudo svnadmin create $DST/$name
		svnadmin load $DST/$name < $repo
		chown -R www-data.www-data $DST/$name
		chmod -R g+rws $DST/$name
	done
}

rm -rf $TMP
