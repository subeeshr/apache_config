#!/bin/bash
set -x
/usr/local/bin/sshpass -p ${root} scp -o StrictHostKeyChecking=no -r `ls | egrep -v '^jenkins_apache.sh$'` root@54.154.236.251:/root/test_install/
#Wait for cronjob to run
sleep 3m

/usr/local/bin/sshpass -p ${root} scp -o StrictHostKeyChecking=no -r root@54.154.236.251:/root/test_install/httpd.log  httpd.log
ls -lrta
while [ -f httpd.log ] ;
do
    if [[ ! -z $(grep "OK" "httpd.log") ]];then
   echo "SUCCESSFUL"
   rm -rf httpd.log
   else
   cat httpd.log
   rm -rf httpd.log
   exit 1
 fi
done
