#input 1 is the first user file, input 2 is the second user file

#clearing both files
cat $1 > $1
cat $2 > $2

#Getting rid of empty lines
sed -i '/^$/d' $1
sed -i '/^$/d' $2

#Looping through 1000 possible uids for users. This will work most of the time. Take care when looking at the badUsers file.
for i in $(seq 1000 2000)
do 
    grep -n $i /etc/passwd >> $1
done

sed -i '/^$/d' $1
sed -i '/^$/d' $2

awk -F: '{ print $2}' $1 > $2
cat $2 > $1

sed -i '/^$/d' $1
sed -i '/^$/d' $2