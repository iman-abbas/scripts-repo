#! /bin/bash
 i=`pwd`
 Watched_Directory=$i
 echo "directory name is="$Watched_Directory

 
 Directory_Size=$( du -sk "$Watched_Directory" | cut -f1 )
 echo "directory size is ="$Directory_Size

 Disk_Size=$(( $(df $Watched_Directory | tail -n 1 | awk '{print $3}')+$(df $Watched_Directory | tail -n 1 | awk '{print $4}') ))       
echo "Total space of the partition="$Disk_Size

#Curent percentage used by the directory
Directory_Percentage=$(echo "scale=2;100*$Directory_Size/$Disk_Size+0.5" | bc | awk '{printf("%d\n",$1 + 0.5)}')
echo "Curent percentage used by the directory="$Directory_Percentage"%"

if [ $Directory_Percentage -gt 1 ]
then
    echo "hi"
    find $Watched_Directory/* -mtime +1 -type f -delete
fi

