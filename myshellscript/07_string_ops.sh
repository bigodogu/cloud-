#!/bin/bash
#
#
myVar="hello sangamesh, how are you"
myVarLength=${#myVar}

echo "myVar legth is $myVarLength"

echo "upper case alphabet is ${myVar^^}"
echo "lower case alphabet is ${myVar,,}"

newVar=${myVar/sangamesh/Shekhar}

echo "my newvar values $newVar"

# slice a string
echo " slice string is ${myVar:6:9}"

