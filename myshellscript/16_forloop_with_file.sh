#!/bin/bash
#
#getting values from name.txt file
#
FILE="/home/ubuntu/myscripts/names.txt"

for name in $(cat $FILE)
do
	echo "name is $name"
done

