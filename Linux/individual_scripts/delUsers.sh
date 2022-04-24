#!/bin/bash

if [ $1 == -h ] 2> /dev/null
then
    ./functions/helpFunc.sh readmes/delUsersreadme.md
    exit 1
fi

#Checking if the user is coming back after editing the data_files/badUsers.txt file
echo '*_____________________________________*'
echo '     have you come back after          ' 
echo '   editing the badUsers file? (y/n)    '
echo '*_____________________________________*'

read -p 'y/n: ' RESP
if [ $RESP == 'y' ]
then
    echo
    echo "Then let's get to deleting users!"

    ./functions/diffFunc.sh data_files/users.txt data_files/goodUsers.txt data_files/users2.txt data_files/goodUsers2.txt data_files/badUsers.txt
    echo

    IFS=$'\n' read -d '' -r -a badUsers < data_files/badUsers.txt

    for i in ${badUsers[@]}
    do
        echo deleting user: $i
        deluser --quiet $i
    done
    
    echo
    echo 'Would you like to disable the root user on ssh?'
    read -p 'y/n: ' RESP
    if [ $RESP == 'y' ]
    then
            echo
            echo "then let's get back to deleting users!"
    else
            echo 'Smell ya later'
            exit 1
    fi

    if grep -q PermitRootLogin /etc/ssh/sshd_config
    then
            #Saving a copy of the file we are edditing
            echo 'Saving a copy of your /etc/ssh/sshd_config file'
            cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bac

            #Turning root off

            echo 'disabling root'
            sed -i 's/PermitRootLogin.*/PermitRootLogin no/g' /etc/ssh/sshd_config
            sed -i 's/#PermitRootLogin.*/PermitRootLogin no/g' /etc/ssh/sshd_config
    else

        #Giving an error message.

            echo '*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-**-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-'
            echo 'Check the /etc/ssh/sshd_config for PermitRootLogin, it appears to be missing.'
            echo '*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-**-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-'
    fi

    echo 'Would you like to disable the guest user?'
    read -p 'y/n: ' RESP
    if [ $RESP == 'y' ]
    then
            echo
            echo "then let's get back to deleting users"
    else
            echo 'Smell ya later'
            exit 1
    fi

    if grep -q '# allow-guest' /etc/lightdm/lightdm.conf
    then
        echo 'disabling guest'
        sed -i 's/# allow-guest.*/allow-guest=false/g' /etc/lightdm/lightdm.conf
        sed -i 's/allow-guest.*/allow-guest=false/g' /etc/lightdm/lightdm.conf
    else
        echo '*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-**-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-'
            echo 'Check the /etc/lightdm/lighdm.conf for allow-guest, it appears to be missing.'
            echo '*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-**-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-'
    fi
    exit 1
else
        echo 
        echo 'Okay'
fi

#
#
#
#
#
#
#
#
#
######
###   THIS IS WHERE THE REGULAR RUN OF THE SCRIPT BEGINS
######
#
#
#
#
#
#
#
#
#

./functions/getUsersFunc.sh data_files/users.txt data_files/users2.txt

#Comparing data_files/users.txt to data_files/goodUsers.txt and sorting both files (sorting the files is required to use comm)
./functions/diffFunc.sh data_files/users.txt data_files/goodUsers.txt data_files/users2.txt data_files/goodUsers2.txt data_files/badUsers.txt

echo 

#Making a badUsers array out of data_files/badUsers.txt
IFS=$'\n' read -d '' -r -a badUsers < data_files/badUsers.txt

#Printing out the full badUsers array and asking if they are the users you would like to remove
echo '*_____________________________________*'
echo '  are these the users you would        ' 
echo '      like to delete? (y/n)            '
cat data_files/badUsers.txt
echo '*_____________________________________*'

read -p 'y/n: ' RESP
if [ $RESP == 'y' ]
then
        echo
        echo "then let's get to deleting users"
else
        echo 
        echo 'Then edit the data_files/badUsers.txt file.'
        exit 1
fi

for i in ${badUsers[@]}
do
        echo deleting user: $i
        deluser --quiet $i
done

echo
echo 'Would you like to disable the root user on ssh?'
read -p 'y/n: ' RESP
if [ $RESP == 'y' ]
then
        echo
        echo "then let's get back to deleting users!"
else
        echo 'Okay'
fi

if grep -q PermitRootLogin /etc/ssh/sshd_config
then
        #Saving a copy of the file we are edditing
        echo 'Saving a copy of your /etc/ssh/sshd_config file'
        cp /etc/ssh/sshd_config /etc/ssh/sshd_config.bac

        #Turning root off

        echo 'disabled root'
        sed -i 's/PermitRootLogin.*/PermitRootLogin no/g' /etc/ssh/sshd_config
	sed -i 's/#PermitRootLogin.*/PermitRootLogin no/g' /etc/ssh/sshd_config
else

	#Giving an error message.

        echo '*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-**-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-'
        echo 'Check the /etc/ssh/sshd_config for PermitRootLogin, it appears to be missing.'
        echo '*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-**-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-'
fi

echo 'Would you like to disable the guest user?'
read -p 'y/n: ' RESP
if [ $RESP == 'y' ]
then
        echo
        echo "then let's get back to deleting users!"
else
        echo 'Smell ya later'
        exit 1
fi

if grep -q '# allow-guest' /etc/lightdm/lightdm.conf
then
	echo 'disabling guest'
	sed -i 's/# allow-guest.*/allow-guest=false/g' /etc/lightdm/lightdm.conf
	sed -i 's/allow-guest.*/allow-guest=false/g' /etc/lightdm/lightdm.conf
else
	echo '*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-**-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-'
        echo 'Check the /etc/lightdm/lighdm.conf for allow-guest, it appears to be missing.'
        echo '*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-**-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-'
fi
