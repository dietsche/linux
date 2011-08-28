#!/bin/bash
rsync -a www:./Maildir/.MailingLists.linux-kernel/ greg/lkml/
echo removing old emails...
find greg/lkml/cur/ -type f -mtime +7 -exec rm {} \;
