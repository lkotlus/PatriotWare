#!/bin/bash

if [ $1 == -h ] 2> /dev/null
then
    ./functions/helpFunc.sh readmes/passReqreadme.md
    exit 1
fi

#Let's set some password requirements!

#Polishing our CLI.

echo '*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*'
echo '|                               |'
echo '*                               *'
echo '|      Welcome to passReq!      |'
echo '*      Press y to continue      *'
echo '|      Press n to cancel        |'
echo '*                               *'
echo '*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*'
echo

#Checking that our user wants to proceed.

read -p 'y/n: ' RESP
if [ $RESP == 'y' ]
then
        echo
        echo "Then let's get to setting some password requirements!"
else
        echo 'See you later!'
        exit 1
fi

#Making an if statement that checks the file for our pattern

if grep -q PASS_MAX_DAYS /etc/login.defs
then
	#Saving a copy of the file we are edditing
	echo 'Saving a copy of your /etc/login.defs file'
	cp /etc/login.defs /etc/login.defs.bac

	#Going through the file and replacing our pattern with what we want.

	echo 'Setting maximum days you can keep a password. (/etc/login.defs'
	sed -i 's/PASS_MAX_DAYS.*/PASS_MAX_DAYS	90/g' /etc/login.defs
else
	echo '*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-**-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*'
	echo 'Check the /etc/login.defs for PASS_MAX_DAYS, it appears to be missing.'
	echo '*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-**-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*'
fi

if grep -q PASS_MIN_DAYS /etc/login.defs
then
	#Repeating the process
	echo 'Setting minimum days you can keep a password. (/etc/login.defs)'
	sed -i 's/PASS_MIN_DAYS.*/PASS_MIN_DAYS	7/g' /etc/login.defs
else
	echo '*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-**-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*'
        echo 'Check the /etc/login.defs for PASS_MIN_DAYS, it appears to be missing.'
        echo '*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-**-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*'
fi

if grep -q PASS_WARN_AGE /etc/login.defs
then
	echo 'Setting when linux will warn you about your passwords age (/etc/login.defs)'
	sed -i 's/PASS_WARN_AGE.*/PASS_WARN_AGE	14/g' /etc/login.defs
else
	echo '*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-**-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*'
        echo 'Check the /etc/login.defs for PASS_WARN_AGE, it appears to be missing.'
        echo '*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-**-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*'
fi

if grep -q pam_unix.so /etc/pam.d/common-password
then
	echo 'Saving a copy of your /etc/pam.d/common-password file'
	cp /etc/pam.d/common-password /etc/pam.d/pam.d.bac

	echo 'Setting the minimum length of passwords (/etc/pam.d/common-password)'

	#Since this is a bit different we need to remove the pattern if it is commented out.

	sed -i 's/#.*pam_unix.so/# keyword removed/g' /etc/pam.d/common-password
	sed -i 's/.*pam_unix.so.*/password	[success=1 default=ignore]	pam_unix.so obscure sha512	minlen=8/g' /etc/pam.d/common-password
else
	echo '*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-**-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-'
        echo 'Check the /etc/pam.d/common-password for pam_unix.so, it appears to be missing.'
        echo '*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-**-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-'
fi

# we are doing the /etc/pam.d/common-auth file is a bit different, so we want to do it in a different way. We are going to be overwriting the entire file.

echo 'Saving a copy of your /etc/pam.d/common-auth file'
cp /etc/pam.d/common-auth /etc/pam.d/pam.d.bac

echo 'Setting the account lockout policy (/etc/pam.d/common-auth)'
echo -e 'auth    [success=1 default=ignore]      pam_unix.so nullok_secure\nauth    required                        pam_deny.so\nauth    required    pam_tally2.so    onerr=fail deny=3 unlock_time=1800\nauth    required                        pam_permit.so' | tee /etc/pam.d/common-auth > /dev/null

if [ $?==0 ]
then
	echo 'All done :)'
else
	echo '*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-**-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*'
        echo 'Something went wrong while trying to edit the /etc/pam.d/common-auth file. Please investigate.'
        echo '*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-**-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*-*'
fi
