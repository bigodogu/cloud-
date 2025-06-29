#!/bin/bash

while IFS="," read name id age
do
	echo "name is $name"
#	echo "ID is $id"
#	echo "age is $age"
done < text.csv

