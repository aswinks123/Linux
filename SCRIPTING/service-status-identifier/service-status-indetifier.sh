#Stoping a service and printing its return status


#!/bin/bash


echo " We are going to stop  NGINX service.."
systemctl stop nginx
policystatus=$?

if [[ "policystatus" -eq 0 ]]; then

	echo " Stopped successfully"

else
	echo " Some thing Wrong"
fi
