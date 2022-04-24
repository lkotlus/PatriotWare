#!/bin/bash

if [ $1 == "-h" ] 2> /dev/null
then
    ./functions/helpFunc.sh readmes/sysctlreadme.md
    exit 1
fi

#systemctl is what we are doing.

echo "Would you like to do systemctl things?"

read -p 'y/n: ' RESP
if [ $RESP == 'n' ]
then
    echo
    echo "Bye!"
    exit 1
else
    echo
    echo 'Moving on...'
    echo 
fi

rsync -a --delete pre_configured_sysctl_files/sysctl.d/ /etc/sysctl.d/ > /dev/null
rsync -a --delete pre_configured_sysctl_files/sysctl.conf /etc/sysctl.conf > /dev/null

echo "done :)"
