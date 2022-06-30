# collect hostname and memory usage of multiple server

#!/bin/bash
echo Fetching the details of server.....Please wait...

echo "Hostname,Date,Memory Usage(%)"> ./report-generated.csv
for i in $(cat ./servlist.txt);

do

RHostname=$(ssh $i hostname)
RDate=$(ssh $i 'date "+%Y-%m-%d %H:%M"')
RMem=$(ssh $i free | grep Mem | awk '{print $3/$2 * 100.0}')

  
echo $RHostname, $RDate, $RMem >> ./report-generated.csv
#./report-generated.csv
done