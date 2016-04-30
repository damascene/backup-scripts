#!/bin/sh
#### Based on Rsync Date Stamped, Snapshot Style, Incremental Backups http://webgnuru.com/linux/rsync_incremental.php ########
## This version is modifed to work on BusyBox Sh shell
## Date command is different in BusyBox from the Bash vrsion


# Copyright 2016 Usama Akkad, Released under GNU General Public License v3.

# BusyBox Snapshot Backup Script is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

#Software version 0.1.3

#WARNING - TEST BEFORE YOU USE. A MISTAKE IN RSYNC COULD ERASE YOUR FILES. USE WITH CAUTION.
#Website Backup Script

#Todays date in ISO-8601 format:
day0=$(date -I)

#Yesterdays date in ISO-8601 format that works in Bash:
#DAY1=`date -I -d "1 day ago"`

#Yesterdays date in ISO-8601 format that works in BusyBox:
day1=$(date -I -d @$(( $(date +%s) - (24*60*60) )))


#The source directory:
source="/path/to/source/files/"

#The target directory:
target="/path/to/backup/location/$day0"

#The remote server informaions:
remote="test@example.org"

#The link destination directory:
link="/path/to/backup/location/$day1"

#Rsync options:
#OPT="-avh -e ssh --delete --link-dest=$LNK"

#Execute the backup
#Remove --dry-run to activate the command. With --dry-run it will just demonistrate what will happen. 
rsync -avh -e ssh --dry-run --delete --link-dest="$link" "$remote:$source" "$target"

##optional delete old files
##29 days ago in ISO-8601 bash format
##
##DAY29=`date -I -d "29 days ago"`
##29 days ago in ISO-8601 busybox sh format
#day29=`date -I -d @$(( $(date +%s) - (29*24*60*60) ))`

#Delete the backup from 29 days ago, if it exists
#if [ -d /path/to/backup/location/$day29 ]
#then
#rm /path/to/backup/location/$day29
#fi
