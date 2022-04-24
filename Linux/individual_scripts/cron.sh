#!/bin/bash

if [ $1 == -h ] 2> /dev/null
then
    ./functions/helpFunc.sh readmes/cronreadme.md
    exit 1
fi

echo "Are you ready to view the cron jobs? (y/n)"

read -p 'y/n: ' RESP
if [ $RESP == 'y' ]
then
    echo "Noice, smort"
else
    exit 1
fi

#clearing the rawCronJobs directory
rm rawCronJobs/* &> /dev/null

#listing out the crontab files
ls /var/spool/cron/crontabs/ > data_files/crontabs.txt

#making an array from the crontabs file
IFS=$'\n' read -d '' -r -a crontabs < data_files/crontabs.txt

#looping through the files
for i in ${crontabs[@]}
do
    if [[ ${i} == ${crontabs[0]} ]]
    then
        echo "${i}:" > data_files/cronjobs.txt
        touch rawCronJobs/${i}
        echo "m h  dom mon dow   command" >> data_files/cronjobs.txt
        cat /var/spool/cron/crontabs/${i} >> data_files/cronjobs.txt
        cat /var/spool/cron/crontabs/${i} >> rawCronJobs/${i}
        sed -i '/# .*/d' rawCronJobs/${i}
    else
        echo "${i}:" >> data_files/cronjobs.txt
        touch rawCronJobs/${i}
        echo "m h  dom mon dow   command" >> data_files/cronjobs.txt
        cat /var/spool/cron/crontabs/${i} >> data_files/cronjobs.txt
        cat /var/spool/cron/crontabs/${i} >> rawCronJobs/${i}
        sed -i '/# .*/d' rawCronJobs/${i}
    fi
done

sed -i '/# .*/d' data_files/cronjobs.txt

echo 
cat data_files/cronjobs.txt

echo
echo "you can view this agian in the data_files/cronjobs.txt file."
echo

echo "Pick n for nuke (comment all cron jobs)"
echo "Pick a for assist (ask y/n for each cron job)"
echo "Pick m for manual (exit the script and DIY)"
read -p 'n/a/m: ' RESP
if [ $RESP == 'n' ]
then
    echo "Turning the keys..."
    for i in "${crontabs[@]}"
    do
        IFS=$'\n' read -d '' -r -a rawCron < rawCronJobs/${i}
        for rc in "${rawCron[@]}"
        do
            #we need to escape all the special characters in rc, so we use ESCAPED_REPLACE as a workaround.
            ESCAPED_REPLACE=$(printf '%s\n' "$rc" | sed -e 's/[\/&*]/\\&/g')
            sed -i "s/${ESCAPED_REPLACE}/#${ESCAPED_REPLACE}/" /var/spool/cron/crontabs/${i}
        done
    done
elif [ $RESP == 'a' ]
then
    echo "Coolio"
    for i in "${crontabs[@]}"
    do 
        IFS=$'\n' read -d '' -r -a rawCron < rawCronJobs/${i}
        for rc in "${rawCron[@]}"
        do
            echo "Would you like to comment ${rc} from ${i}'s crontab? (y/n)"
            read -p 'y/n: ' RESP
            if [ $RESP == 'y' ]
            then
                echo "Commenting..."
                ESCAPED_REPLACE=$(printf '%s\n' "$rc" | sed -e 's/[\/&*]/\\&/g')
                sed -i "s/${ESCAPED_REPLACE}/#${ESCAPED_REPLACE}/" /var/spool/cron/crontabs/${i}
            else
                echo "Okay"
            fi
        done
    done
else
    echo "DIY then ):"
fi

echo "Would you like to only allow root cron? (y/n)"

read -p 'y/n: ' RESP
if [ $RESP == 'y' ]
then
    echo 'Okay'
elif [ $RESP =='n' ]
then
    echo 'Bye'
    exit 1
fi

crontab -r
rm -f cron.deny at.deny
echo root > cron.allow
echo root > at.allow
chown root:root cron.allow at.allow
chmod 644 cron.allow at.allow