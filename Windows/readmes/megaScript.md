# megaScript.ps1

[IMPORTANT]

IF YOU'RE RUNNING THIS FOR THE FIRST TIME PASS IN 0 AS THE FIRST ARGUMENT

PUT THE PASSWORD THAT YOU WANT ALL USERS ON THE MACHINE TO BE GIVEN AS THE LAST ARGUMENT

FILL OUT THE data_files\goodAdmins.txt AND data_files\goodUsers.txt FILES BEFORE RUNNING

[IMPORTANT]

megaScript will run all of the individual scripts.
It goes through, and does it's best, but if something goes wrong,
you can call it again, but provide a starting point variable for 
the script that failed. Heres a cheat sheet:

delUsers: 0
missingUsers: 1
admins: 2
delFiles: 3
services: 4
scheduledTasks: 5
passwords: 6
firewall: 7
misc: 8
winDefender: 9
updates: 10