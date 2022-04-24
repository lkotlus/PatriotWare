#!/bin/bash

if [ $1 == -h ] 2> /dev/null
then
    ./functions/helpFunc.sh readmes/missingUsersreadme.md
    exit 1
fi

echo 'Would you like to check for missing users (keep in mind that you should either run the root.sh script or manually check for uid 0 users first.)?'

read -p 'y/n: ' RESP
if [ $RESP == 'y' ]
then
        echo
        echo "Then let's keep on keeping on"
else
        echo 
        echo 'Bye'
        exit 1
fi

./functions/getUsersFunc.sh data_files/users.txt data_files/users2.txt

#Comparing data_files/users.txt to data_files/goodUsers.txt and sorting both files (sorting the files is required to use comm)
./functions/diffFunc.sh data_files/goodUsers.txt data_files/users.txt data_files/goodUsers2.txt data_files/users2.txt data_files/missingUsers.txt
echo 

#Making a badUsers array out of data_files/badUsers.txt
IFS=$'\n' read -d '' -r -a missingUsers < data_files/missingUsers.txt

echo '*_____________________________________*'
echo ' Do these look like the missing users? ' 
cat data_files/missingUsers.txt
echo '*_____________________________________*'

read -p 'y/n: ' RESP
if [ $RESP == 'y' ]
then
        echo
        echo "then let's add them"
        echo
else
        echo 
        echo 'Then DIY.'
        exit 1
fi

for i in ${missingUsers[@]}
do
    echo "adding the user $i"
    useradd $i > /dev/null
    echo
done

echo 'Done (:'
