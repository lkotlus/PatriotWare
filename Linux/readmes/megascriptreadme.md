# megaScript.sh

[IMPORTANT]

CALL THIS WITH 0 FOR THE FIRST PARAM ON THE FIRST RUN!


FILL OUT THE data_files/goodUsers.txt AND data_files/adminWhitelist.txt BEFORE RUNNING

[IMPORTANT]

megaScript will run all of the individual scripts. 
It goes through, and does it's best, but if something goes wrong, you
can call it again, but provide a starting point variable for the script
that failed. Here is a lil' starting point chart for ya:

delUsers: 0
missingUsers: 1
admin: 2
deleteFiles: 3
services: 4
cron: 5
packages: 6
passReq: 7
passwords: 8
sysctl: 9
ufw: 10
apt: 11

If you need to rup passwords.sh, make sure you provide the password as the SECOND argument.
