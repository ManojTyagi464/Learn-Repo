#!/bin/bash
truncate -s 0 efs_info
aws efs describe-file-systems | grep FileSystemId | grep -v tag | awk '{print $2 }' | sed 's/\"//g;s/\,//g' > efs_info 
truncate -s 0 eni
for i in `cat efs_info`
do
aws efs describe-mount-targets --file-system-id $i | grep NetworkInterfaceId | grep -v tag | awk '{print $2}' | sed 's/\"//g;s/\,//g;s/^/'"$i"' /' >> eni
done 
