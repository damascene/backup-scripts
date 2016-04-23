#!/bin/sh
#### Based on Rsync Date Stamped, Snapshot Style, Incremental Backups http://webgnuru.com/linux/rsync_incremental.php ########
## This version is modifed to work on BusyBox Sh shell
## Date command is different in BusyBox from the Bash vrsion

#version 0.1

#Website Backup Script

#Todays date in ISO-8601 format:
DAY0=`date -I`

#Yesterdays date in ISO-8601 format that works in Bash:
#DAY1=`date -I -d "1 day ago"`

#Yesterdays date in ISO-8601 format that works in BusyBox:
DAY1=`date -I -d @$(( $(date +%s) - (24*60*60) ))`


#The source directory:
SRC="/var/www/htdocs/"

#The target directory:
TRG="/backup/website/$DAY0"

#The remote server informaions:
RMT="username@example.org"

#The link destination directory:
LNK="/backup/website/$DAY1"

#The rsync options:
OPT="-avh -e ssh --delete --link-dest=$LNK"

#Execute the backup
rsync $OPT $SRC $RMT:$TRG


##optional delete old files
##29 days ago in ISO-8601 bash format
##
##DAY29=`date -I -d "29 days ago"`
##29 days ago in ISO-8601 busybox sh format
DAY29=`date -I -d @$(( $(date +%s) - (29*24*60*60) ))`

#Delete the backup from 29 days ago, if it exists
#if [ -d /backup/website/$DAY29 ]
#then
#rm /backup/website/$DAY29
#fi
