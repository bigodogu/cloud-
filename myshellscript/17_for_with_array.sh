#!/bin/bash
#
myArray=( 1 3 2 5 hi hello )

length=${#myArray[*]}  # Correct the typo (from legth to length)

for (( i=0; i<$length; i++ ))  # Corrected loop syntax
do
    echo "Value of array is ${myArray[$i]}"
done

