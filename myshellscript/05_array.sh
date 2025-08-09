#!/bin/bash
#
#
#
#Array
myArray=( 1 4 3.5 7 hello "hello man" )

echo "${myArray[0]}"


echo " show all the values in the array ${myArray[*]}"

echo "number of value in an array is ${#myArray[*]}"

echo "number of idex value from 2to3 are ${myArray[*]:2:4}"

myArray+=( new size man curl size devops )

echo "my new array values are ${myArray[*]}"


