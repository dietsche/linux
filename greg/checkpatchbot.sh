#!/bin/bash

#FILES=`grep -li '^Subject: \[Patch\]' $1*`
FILES=`grep -li 'Subject: \[Patch[ /1-9]*\]' $1*`

rm /tmp/{msg,patch,msg.patch,checkpatch}

for F in $FILES; do
	echo Processing $F
	git mailinfo /tmp/msg /tmp/patch < $F
	cat /tmp/msg > /tmp/msg.patch
	cat /tmp/patch>>/tmp/msg.patch

	if [ $(./scripts/checkpatch.pl -q --mailback /tmp/msg.patch \
		| grep 'ERROR:' \
		| wc -l) -ne 0 ]; then

		echo >>/tmp/checkpatch
		echo $F>>/tmp/checkpatch
		grep -i ^Subject: $F >> /tmp/checkpatch
		./scripts/checkpatch.pl -q --mailback /tmp/msg.patch >> /tmp/checkpatch
	fi
done
cat /tmp/checkpatch
