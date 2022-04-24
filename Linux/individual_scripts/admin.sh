#!/bin/bash

if [ $1 == -h ] 2> /dev/null
then
    ./functions/helpFunc.sh readmes/adminreadme.md
    exit 1
fi

#We actually about to do the admins!

#
#
##
##
###
#### THE FILE METHOD STARTS HERE!!!
###
##
##
#
#

if [ $1 == -f ]
then
    echo '*-*-*-*-*-*-*-*-*-*-*-*'
    echo 'Using the file setting!'
    echo '*-*-*-*-*-*-*-*-*-*-*-*'
    echo
    echo

    echo '*_____________________________________*'
    echo '      Would you like correct the       ' 
    echo '      sudo and admin group?(y/n)       '
    echo '*_____________________________________*'

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

    #Putting the full line of the groups we are editing into a file
    grep sudo /etc/group > data_files/sudoers.txt
    grep admin /etc/group > data_files/admins.txt
    
    #Making strings of just groupname:x:linenumber
    sudoGroup=$(awk -F: 'BEGIN{OFS=":";} {print $1,$2,$3;}' data_files/sudoers.txt)
    adminGroup=$(awk -F: 'BEGIN{OFS=":";} {print $1,$2,$3;}' data_files/admins.txt)

    echo ${sudoGroup}
    echo ${adminGroup}

    #Making an array of all our usernames from the data_files/adminWhitelist.txt
    IFS=$'\n' read -d '' -r -a arguments < data_files/adminWhitelist.txt

    for i in ${arguments[@]}
    do
        if [ ${i} == ${arguments[0]} ]
        then
            id ${i} &> data_files/isUser.txt
        else
            id ${i} &>> data_files/isUser.txt
        fi
    done

    if grep -q 'no such user' data_files/isUser.txt
    then
        echo '*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*'
        echo 
        grep 'no such user' data_files/isUser.txt
        echo
        echo 'Try fixing the usernames!'
        echo
        echo '*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*'
        exit 1
    fi

    for i in ${arguments[@]}
    do 
        if [[ ${i} == ${arguments[0]} && ${#arguments[@]} > 0 ]]
        then
            sudoGroup="${sudoGroup}:${i},"
            adminGroup="${adminGroup}:${i},"
        elif [[ ${i} == ${arguments[0]} && ${#arguments[@]} == 0 ]]
        then
            sudoGroup="${sudoGroup}:${i}"
            adminGroup="${adminGroup}:${i}"
        elif [ ${i} == ${arguments[-1]} ]
        then
            sudoGroup="${sudoGroup}${i}"
            adminGroup="${adminGroup}${i}"
        else
            sudoGroup="${sudoGroup}${i},"
            adminGroup="${adminGroup}${i},"
        fi
    done

    sed -i "s/sudo.*/${sudoGroup}/g" /etc/group
    sed -i "s/admin.*/${adminGroup}/g" /etc/group

    echo "New sudo group: ${sudoGroup}"
    echo "New admin group: ${adminGroup}"

    exit 1
fi

#
#
##
##
###
#### THE ARGUMENTS METHOD STARTS HERE!!!
###
##
##
#
#

echo '*_____________________________________*'
echo '      Would you like correct the       ' 
echo '      sudo and admin group?(y/n)       '
echo '*_____________________________________*'

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

#Putting the full line of the groups we are editing into a file
grep sudo /etc/group > data_files/sudoers.txt
grep admin /etc/group > data_files/admins.txt

#Making strings of just groupname:x:linenumber
sudoGroup=$(awk -F: 'BEGIN{OFS=":";} {print $1,$2,$3;}' data_files/sudoers.txt)
adminGroup=$(awk -F: 'BEGIN{OFS=":";} {print $1,$2,$3;}' data_files/admins.txt)

#echo ${sudoGroup}
#echo ${adminGroup}

#Making an array of the operators of our script (./admins.sh lkotlus rkotlus skotlus)
arguments=("$@")

for i in ${arguments[@]}
do
    if [ ${i} == ${arguments[0]} ]
    then
        id ${i} &> data_files/isUser.txt
    else
        id ${i} &>> data_files/isUser.txt
    fi
done

if grep -q 'no such user' data_files/isUser.txt
then
    echo '*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*'
    echo 
    grep 'no such user' data_files/isUser.txt
    echo
    echo 'Try fixing the usernames!'
    echo
    echo '*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*'
    exit 1
fi

for i in ${arguments[@]}
do 
    if [[ ${i} == ${arguments[0]} && $# > 1 ]]
    then
        sudoGroup="${sudoGroup}:${i},"
        adminGroup="${adminGroup}:${i},"
    elif [[ ${i} == ${arguments[0]} && $# == 1 ]]
    then
        sudoGroup="${sudoGroup}:${i}"
        adminGroup="${adminGroup}:${i}"
    elif [ ${i} == ${arguments[-1]} ]
    then
        sudoGroup="${sudoGroup}${i}"
        adminGroup="${adminGroup}${i}"
    else
        sudoGroup="${sudoGroup}${i},"
        adminGroup="${adminGroup}${i},"
    fi
done

sed -i "s/sudo.*/${sudoGroup}/g" /etc/group
sed -i "s/admin.*/${adminGroup}/g" /etc/group

echo "New sudo group: ${sudoGroup}"
echo "New admin group: ${adminGroup}"
