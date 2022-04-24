#!/bin/bash

if [ $1 == -h ] 2> /dev/null
then
    ./functions/helpFunc.sh readmes/aptreadme.md
    exit 1
fi

# Updating
apt-get update -y
echo

# Showing the current package list, and notifying them of what there is and how to update it.
grep -r --include '*.list' '^deb ' /etc/apt/sources.list /etc/apt/sources.list.d/ > data_files/sources.txt
sed -i 's/^.*\(http:.*\).*$/\1/' data_files/sources.txt
awk -F' ' '{ print $1}' data_files/sources.txt
echo
awk -F' ' '{ print $1}' data_files/sources.txt > data_files/sourcelist.txt
echo "These are the packages currently being updated through apt. If you want to look at them again, look at the data_files/sourcelist.txt file. Re-add them through the updates settings."
echo

# Overwriting the current /etc/apt with our pre-configured /etc/apt (located on the github)

echo
echo "Are you running Debian or Ubuntu?"

read -p '1 for Debian, 0 for Ubuntu: ' RESP
if [ $RESP == '0' ]
then
    rsync -a --delete pre_configured_apt_files/apt_ubu/ /etc/apt/ > /dev/null
else
    rsync -a --delete pre_configured_apt_files/apt_deb/ /etc/apt/ > /dev/null
fi

# Upgrading and updating
apt-get update -y
apt-get upgrade -y
