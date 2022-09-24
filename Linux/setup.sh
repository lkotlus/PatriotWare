#!/bin/bash

#
## giving executable permissions to the scripts
#

chmod +x individual_scripts/delUsers.sh
chmod +x individual_scripts/deleteFiles.sh
chmod +x individual_scripts/passReq.sh
chmod +x individual_scripts/admin.sh
chmod +x individual_scripts/services.sh
chmod +x individual_scripts/packages.sh
chmod +x individual_scripts/passwords.sh
chmod +x individual_scripts/apt.sh
chmod +x individual_scripts/missingUsers.sh
chmod +x individual_scripts/cron.sh
chmod +x individual_scripts/ufw.sh
chmod +x individual_scripts/group.sh
chmod +x individual_scripts/sysctl.sh
chmod +x functions/helpFunc.sh
chmod +x functions/getUsersFunc.sh
chmod +x functions/diffFunc.sh
chmod +x functions/findFilesFunc.sh
chmod +x megaScript.sh

#
## making the necessary directories 
#

mkdir pre_configured_apt_files/apt_ubu
mkdir pre_configured_apt_files/apt_deb

#
## making the necessary files and directories to pass around information, read information from, and write information to.
#

touch data_files/adminWhitelist.txt
touch data_files/sudoers.txt
touch data_files/admins.txt
touch data_files/isUser.txt
touch data_files/users.txt
touch data_files/users2.txt
touch data_files/goodUsers.txt
touch data_files/goodUsers2.txt
touch data_files/badUsers.txt
touch data_files/foundFiles.txt
touch data_files/services.txt
touch data_files/services2.txt
touch data_files/servicesWhitelist2.txt
touch data_files/badServices.txt
touch data_files/sourcelist.txt
touch data_files/sources.txt
touch data_files/missingUsers.txt
touch data_files/uid.txt
touch data_files/uid2.txt
touch data_files/crontabs.txt
touch data_files/cronjobs.txt
mkdir rawCronJobs

#
## installing necessary tools
#

apt-get install net-tools -y > /dev/null

#
## saying thank you (I'm not a monster)
#

echo "Thank you for using PatriotWare"
