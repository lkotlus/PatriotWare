# megaScript.sh

CALL THIS WITH 0 FOR THE FIRST PARAM ON THE FIRST RUN!
megaScript will run all of the scripts. All of them.
It goes through, and does it's best, but if something goes wrong, you
can call it again, but provide a starting point variable for the script
that failed. Here is a lil' starting point chart for ya:

delUsers: 0
missingUsers: 1
admin: 2
deleteFiles: 3
services: 4
apt: 5
cron: 6
packages: 7
passReq: 8
passwords: 9
sysctl: 10
ufw: 11

If you need to rup passwords.sh, make sure you provide the password as the SECOND argument.
