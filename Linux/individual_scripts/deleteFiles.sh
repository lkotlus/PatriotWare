#!/bin/bash

if [ $1 == -h ] 2> /dev/null
then
    ./functions/helpFunc.sh readmes/deleteFilesreadme.md
    exit 1
fi

echo '*____________________________________*'
echo '|                                    |'
echo '|                                    |'
echo '|                                    |'
echo '|      Have you come back after      |'
echo '|            editing the             |'
echo '|     data_files/foundFiles.txt      |' 
echo '|               file?                |'
echo '|                y/n                 |'
echo '|                                    |'
echo '*____________________________________*'

echo 

read -p 'y/n: ' RESP
if [ $RESP == 'y' ]
then
	echo
	echo "Then let's skip the pleasantries"
	echo

	IFS=$'\n' read -d '' -r -a lines < data_files/foundFiles.txt

	for i in "${lines[@]}"
	do
		echo "Deleting file ${i}"
		rm "${i}"
	done

	exit 1
else
	echo
	echo 'Okay'
fi

echo '*____________________________________*'
echo '|                                    |'
echo '|                                    |'
echo '|                                    |'
echo '|    Ready to delete some files?     |'
echo '|                y/n                 |'
echo '|                                    |'
echo '*____________________________________*'

read -p 'y/n: ' RESP
if [ $RESP == 'y' ]
then
	echo
	echo 'Well alrighty then'
else
	echo 'Well alrighty then'
	exit 1
fi

echo 
./functions/findFilesFunc.sh .mp3 > data_files/foundFiles.txt 
echo 
./functions/findFilesFunc.sh .mp4 >> data_files/foundFiles.txt 
echo
./functions/findFilesFunc.sh .pdf | grep -v /snap | grep -v /usr >> data_files/foundFiles.txt 
echo
./functions/findFilesFunc.sh .mov >> data_files/foundFiles.txt 
echo
./functions/findFilesFunc.sh .avi >> data_files/foundFiles.txt 
echo
./functions/findFilesFunc.sh .mpg >> data_files/foundFiles.txt 
echo
./functions/findFilesFunc.sh .mpeg >> data_files/foundFiles.txt 
echo
./functions/findFilesFunc.sh .flac >> data_files/foundFiles.txt 
echo
./functions/findFilesFunc.sh .m4a >> data_files/foundFiles.txt 
echo
./functions/findFilesFunc.sh .flv >> data_files/foundFiles.txt 
echo
./functions/findFilesFunc.sh .ogg | grep -v /snap | grep -v /usr >> data_files/foundFiles.txt 
echo
./functions/findFilesFunc.sh .gif | grep -v /usr >> data_files/foundFiles.txt 
echo
./functions/findFilesFunc.sh .png | grep -v /var | grep -v /usr | grep -v /snap >> data_files/foundFiles.txt 
echo
./functions/findFilesFunc.sh .jpg | grep -v /usr | grep -v /snap >> data_files/foundFiles.txt
echo
./functions/findFilesFunc.sh .jpeg >> data_files/foundFiles.txt
echo 
echo "Would you like to delete sketchy .txt files? (y/n)"
read -p 'y/n: ' RESP
if [ $RESP == 'y' ]
then
    echo
    echo 'Searching for files'
    find /home -iname "*.txt" | grep -v PatriotWare | grep -v .mozilla | grep -v .cache >> data_files/foundFiles.txt
    echo 'Found files'
else
    echo 'Moving on'
fi
echo 

args=($@)

for i in ${args[@]}
do
	./functions/findFilesFunc.sh $i data_files/foundFiles.txt after
	echo
done

cat data_files/foundFiles.txt

echo

echo '*____________________________________*'
echo '|                                    |'
echo '|                                    |'
echo '|                                    |'
echo '|    Are you okay with deleting      |'     
echo '|           these files?             |'
echo '|                y/n                 |'
echo '|                                    |'
echo '*____________________________________*'

echo

read -p 'y/n: ' RESP
if [ $RESP == 'y' ]
then
	echo "Then let's get to deleting."
else
	echo 'Then go edit the data_files/foundFiles.txt file.'
	exit 1
fi

echo 

IFS=$'\n' read -d '' -r -a lines < data_files/foundFiles.txt

for i in "${lines[@]}"
do
	echo "Deleting file ${i}"
	rm "${i}"
done
