#!/bin/bash

#to access the arguments

echo "first argument is $1"
echo "second argument is $2"

echo "all the arguments are $@"
echo "number of arguements are $#"

#for loop to access the value from arguments

for filename in $@
do
	echo "copying file -- $filename"
done

