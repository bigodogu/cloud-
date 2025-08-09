#!/bin/bas
#
echo "a for print date"
echo "b for list of scripts"
echo "c to check current location"

read choice

case $choice in
	a)
		echo " today date is:"
		date
		echo "ending....."
		;;
	b)ls;;
	c)pwd;;
	*) echo " please provide a valid input"
esac

