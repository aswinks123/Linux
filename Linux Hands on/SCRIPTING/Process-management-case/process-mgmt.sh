#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'


#-----Function body----------
high-process()
{
	printf " ${RED}HIGH MEMORY PROCESSES"
	ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head
	printf " ${NC}"
}
#----------------------------




function testCase ()
{

echo " Process management script "

echo "1. Find the process with highest Memory usage"
echo "2. Find process with highest CPU usage "
echo "3. Find total no of process Running now "


echo " Please choose an option (1-3)"
read opt

case $opt in

	1)

	#call the function
	
	high-process
	testCase
	;;
	
	2)
	printf " ${GREEN}HIGH CPU PROCESSES \n"
	ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head
	printf " ${NC}"
	testCase
	;;
	3)
	
	tot=$(ps -e | wc -l)

	printf " ${GREEN} Total Number of Process is : $tot \n"
	printf " ${NC}"
	testCase
	;;
	
	*)
	echo "No matching information found.Quiting"
	;;
	esac
}
testCase


