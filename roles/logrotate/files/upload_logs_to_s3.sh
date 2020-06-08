#!/bin/bash
#
# Move the logfiles created by custom prerotate process to S3 bucket

LOG_PATH=/tmp

for file in ${LOG_PATH}/*.tar; do 
  mypath=$(echo ${file} | awk -F '[-]' '{for(i=NF-2;i<=NF;i++) printf $i"/"; }' |  awk -F '[_]' '{print $1}');
  echo aws s3 mv /tmp/"${file}" s3://curve-log-archive/"${mypath}"/herodb/"${file}" --dryrun >> /log/s3_upload/error_logs/upload;
done