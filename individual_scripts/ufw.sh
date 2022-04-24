#!/bin/bash
if [ $1 == "-h" ] 2> /dev/null
then
    ./functions/helpFunc.sh readmes/ufwreadme.md
    exit 1
fi
echo "enabling ufw"
ufw enable
