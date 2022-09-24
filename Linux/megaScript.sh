#!/bin/bash

#checking if the user wants help
if [ $1 == "-h" ] 2> /dev/null
then
    ./functions/helpFunc.sh readmes/megascriptreadme.md
    exit 1
fi

echo "Would you like to continue with the MEGA SCRIPT!? (Please keep in mind that you should pass in an argument for which script to start with, 0 will start from the beginning)."
read -p 'y/n: ' RESP
if [ $RESP == 'n' ]
then
    echo "Exiting..."
    exit 1
else
    echo "Cool, moving on..."
    echo
fi

#making an array of scripts
scripts=("individual_scripts/delUsers.sh" "individual_scripts/missingUsers.sh" "individual_scripts/admin.sh" "individual_scripts/deleteFiles.sh" "individual_scripts/services.sh" "individual_scripts/cron.sh" "individual_scripts/packages.sh" "individual_scripts/passReq.sh" "individual_scripts/passwords.sh" "individual_scripts/sysctl.sh" "individual_scripts/ufw.sh" "individual_scripts/apt.sh")

startingPoint=$1

#looping through and running the scripts
for i in $(seq $startingPoint 11)
do
    echo "Would you like to run ${scripts[$i]}?"
    read -p 'y/n: ' RESP
    if [ $RESP == 'n' ]
    then
        echo
        echo "Okay, skipping ${scripts[$i]}"
        echo
    else
        echo 
        echo "Nice, starting ${scripts[$i]}..."
        if [ ${scripts[$i]} == ${scripts[0]} ]
        then
            ./individual_scripts/delUsers.sh
        fi
        if [ ${scripts[$i]} == ${scripts[1]} ]
        then
            ./individual_scripts/missingUsers.sh
        fi
        if [ ${scripts[$i]} == ${scripts[2]} ]
        then
            ./individual_scripts/admin.sh -f
        fi
        if [ ${scripts[$i]} == ${scripts[3]} ]
        then
            ./individual_scripts/deleteFiles.sh
        fi
        if [ ${scripts[$i]} == ${scripts[4]} ]
        then
            ./individual_scripts/services.sh
        fi
        if [ ${scripts[$i]} == ${scripts[5]} ]
        then
            ./individual_scripts/cron.sh
        fi
        if [ ${scripts[$i]} == ${scripts[6]} ]
        then
            ./individual_scripts/packages.sh
        fi
        if [ ${scripts[$i]} == ${scripts[7]} ]
        then
            ./individual_scripts/passReq.sh
        fi
        if [ ${scripts[$i]} == ${scripts[8]} ]
        then
            ./individual_scripts/passwords.sh $2
        fi
        if [ ${scripts[$i]} == ${scripts[9]} ]
        then
            ./individual_scripts/sysctl.sh
        fi
        if [ ${scripts[$i]} == ${scripts[10]} ]
        then
            ./individual_scripts/ufw.sh
        fi
        if [ ${scripts[$i]} == ${scripts[11]} ]
        then
            ./individual_scripts/apt.sh
        fi
        echo
    fi
done
