

#!/bin/bash


h=$(hostname)



ip=$(nslookup $h | awk '/Non-authoritative answer/{f=1}f' | grep Address: | cut -d' ' -f2-)




#echo Hostname,IP Address> abc.csv
echo  $h,$ip >>abc.csv