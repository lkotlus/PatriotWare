#!/bin/bash

if [ $1 == -h ] 2> /dev/null
then
    ./functions/helpFunc.sh readmes/servicesreadme.md
    exit 1
fi

echo '!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!'
echo '           pay attention!!!'
echo '        Did you come back after'
echo '     editing the badServices file?'
echo '                (y/n)'
echo '!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!'

read -p 'y/n: ' RESP
if [ $RESP == 'y' ]
then
    IFS=$'\n' read -d '' -r -a badServices < data_files/badServices.txt

    for i in ${badServices[@]}
    do
        systemctl disable ${i}
        echo "Disabled ${i}"
        echo
    done
    
    exit 1
else
    echo "Okay"
fi

service --status-all > data_files/services.txt

IFS=$'\n' read -d '' -r -a servicesWhitelist < data_files/servicesWhitelist.txt
services=`awk -F] '{print $2}' data_files/services.txt`

echo "${services//[[:blank:]]/}" > data_files/services.txt

./functions/diffFunc.sh data_files/services.txt data_files/servicesWhitelist.txt data_files/services2.txt data_files/servicesWhitelist2.txt data_files/badServices.txt

echo '!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!'
echo '           pay attention!!!'
cat data_files/badServices.txt
echo '   Do you want to disable these services?'
echo '                (y/n)'
echo '!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!'

read -p 'y/n: ' RESP
if [ $RESP == 'y' ]
then
    echo
    echo "Then let's do this"
    echo
else
    echo
    echo "Then edit the badServices file."
    exit 1
fi

echo 'it worked'

IFS=$'\n' read -d '' -r -a badServices < data_files/badServices.txt

for i in ${badServices[@]}
do 
    systemctl disable ${i}
    echo "Disabled ${i}"
done

echo '!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!'
echo '           pay attention!!!'
echo '   Do you want to reverse this action?'
echo '                (y/n)'
echo '!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!@!'

read -p 'y/n: ' RESP
if [ $RESP == 'y' ]
then
    for i in ${badServices[@]}
    do
        systemctl enable ${i}
        echo "Reenabled ${i}"
        echo
    done
else
    echo "I'm glad to see at least someone is responsible..."
    echo
fi
