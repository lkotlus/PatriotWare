#!/bin/bash

if [ $1 == -h ] 2> /dev/null
then
    ./functions/helpFunc.sh readmes/groupreadme.md
    exit 1
fi

#We are doing the fancy y/n stuff again. I miss them. This took me like 5 mins to make lmao!
echo "|*--------------------------*|"
echo "|    Please note that this   |"
echo "|    script is completely    |"
echo "|         optional.          |"
echo "|      Would you like        |"
echo "|       to continue?         |"
echo "|          (y/n)             |"
echo "|*--------------------------*|"

read -p 'y/n: ' RESP
if [ $RESP == 'n' ]
then
    echo
    echo 'Bye!'
    exit 1
else
    echo 
    echo 'Moving on...'
    echo
fi

args=("$@")

groupadd $1

for (( i=1; i<${#args[@]}; i++ ))
do
    echo "Adding user ${args[$i]} to group ${1}"
    usermod -aG $1 ${args[$i]}
done