# individual_scripts/admin.sh
A script that goes through the sudo and admin groups and replaces the members with the operators given on the script. Run like this: './admin.sh user1 user2 user3 etc...'
Keep in mind that you can only have 9 operators, if you have more than 9 operators, put them into the data_files/adminWhitelist.txt file in this format:
  
  user1
  
  user2
  
  user3
  
  etc...

And then run like this: './admin.sh -f'
