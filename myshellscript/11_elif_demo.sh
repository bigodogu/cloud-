#!/bin/bash
#
#
read -p  "enter your marks: " marks
if [[ $marks -gt 80 ]]
then
	echo "YOU ARE FIRST DIVISION, HURRAYYYYYY"
elif [[ $marks -gt 60 ]]
then
	echo "YOU ARE SECOND DIVISION"
elif [[ $marks -gt 45 ]]
then
	echo " YOU ARE THIRD DIVISION"
else
	echo "YOU ARE FAIL, ??????????????????"
fi
