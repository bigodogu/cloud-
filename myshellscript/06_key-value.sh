#!/bin/bash
#
#
#key value

declare -A myArray

myArray=( [name]=shekhar [city]=bangalore [age]=28 )

echo "name is ${myArray[name]}"
echo "age is ${myArray[age]}"
echo "city is ${myArray[city]}"

