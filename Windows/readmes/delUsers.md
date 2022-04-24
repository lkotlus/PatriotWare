# individual_scripts\delUsers.ps1
Start by going into the data_files\goodUsers.txt file and entering all the permitted users on the system line by line like so: \n user1 \n user2 \n user3 \n etc...

after that, just run the script and select n for if you came after editing the data_files\badUsers.txt file.
If you are asked if you want to delete users that you don't want to delete, then edit the data_files\badUsers.txt and select y after rerunning the script. 

(\n means new line (It is actuall `n in powershell). I added it because the way GitHub displays .md files is dumb. Just put the users line by line.)