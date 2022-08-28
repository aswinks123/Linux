#checking whether a user is root or not?,Also print it in color text

#!/bin/bash

#adding color variable

RED='\033[0;31m'
GREEN='\033[0;32m'

#if [[ $EUID -ne 0 ]]; then  or 

if [[ $(id -u) -ne 0 ]]; then	
printf " ${RED}This is not root.Please run from Root user \n"
else
printf " ${GREEN}This is root \n"
exit 1
fi
