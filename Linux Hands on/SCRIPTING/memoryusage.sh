#!/bin/bash

# Find total free memory in MB

free=$(free -mt | grep Total | awk '{print $4}')

# check whether the memory is lless or equal to 100 MB

if [[ "$free" -le 200 ]]; then


#get the process that is using high memory and save to a file

ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head >/tmp/top_proccesses_consuming_memory.txt

echo " Memory low........."
#free -h
fi