#!/bin/bash

# add hostname and IP of servers to csv file



h=$(hostname)

echo $h
#op=$(nslookup $h)



#ip=$op | awk '/Non-authoritative answer/{f=1}f'

ip=$(nslookup $h | awk '/Non-authoritative answer/{f=1}f' | grep Address: | cut -d' ' -f2-)

echo Hostname,IP Address> abc.csv
echo  $h,$ip >>abc.csv

