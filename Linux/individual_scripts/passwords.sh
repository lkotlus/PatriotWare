#!/bin/bash

if [ $1 == -h ] 2> /dev/null
then
    ./functions/helpFunc.sh readmes/passwordsreadme.md
    exit 1
fi

echo "It is recomended that you run the delUsers script before this, with this in mind, would you like to continue? (y/n)"

    read -p 'y/n: ' RESP
    if [ $RESP == 'y' ]
    then
        echo
        echo 'Nice'
        echo 
    else
        echo 
        echo 'Bye :('
        exit 1
    fi

# Updating the users.txt file

./functions/getUsersFunc.sh data_files/users.txt data_files/users2.txt

IFS=$'\n' read -d '' -r -a users < data_files/users.txt

if [ $# == 1 ]   
then
    for i in ${users[@]}
    do
        echo -e "$1\n$1" | passwd ${i} &> /dev/null
        if [ $? != 0 ]
        then
            echo -e "Something went wrong when trying to change the password for ${i}"
        else
            echo -e "Successfully changed the password for ${i}"
        fi
    done
elif [ $# == 0 ]
then
    echo "Not enough arguments!"
else 
    echo 'Too many arguments!'
fi
